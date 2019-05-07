import java.util.LinkedList;

public class Grid {

  Cell[][] cellGrid = new Cell[15+1][17];
  Cell[] bottomCellGrid= new Cell[6];
  Cell mainCell;
  
  boolean stopBubbleCollisionCheck = false; // replace with break?

  Colour aColour = new Colour();
  
  int bottomNum;
  
  int populationNum = 9;
  
  boolean win = false;
  
  
  
  Grid() {}

  public void populate() {
    for (int i=0; i<15+1; i++) { // 15+1 rows (last row is for losing)
      for (int j=0; j<17; j++) { // 17 items per row 
        if (i % 2 == 0)
          this.cellGrid[i][j] = new Cell(new Bubble((i<populationNum) ? aColour.randomColour() : INV,false), gAPO+2*gAPO*j, gRAD+1.5*gRAD*i);
        else
          this.cellGrid[i][j] = new Cell(new Bubble((i<populationNum) ? aColour.randomColour() : INV,false), 2*gAPO+(2*gAPO*j), gRAD+1.5*gRAD*i);
      }
    }
    
    this.bottomNum=aColour.colList2.size(); //initialize bottumNum
    
    for (int i=0; i<6; i++) {
      this.bottomCellGrid[i] = new Cell(new Bubble(INV,(i<bottomNum)), 2*gAPO+37*i, gRAD+1.5*gRAD*16);
    }
    this.bottomCellGrid[0].bubble.col=aColour.randomColour();
    this.mainCell = new Cell(new Bubble(aColour.randomColour(), false), gAPO+2*gAPO*8, gRAD+1.5*gRAD*16);
  }
  
  public void drawGrid() {
    for (Cell[] cellRow : this.cellGrid) {
      for (Cell aCell : cellRow) { 
        aCell.drawCell(); 
      }
    }
    for (Cell aCell : this.bottomCellGrid){
      aCell.drawCell();
    }
    mainCell.drawCell();
  }
  
  public void shootMain() {
    mainCell.bubble.shoot();
    doubleloop:
    for (int i=0; i<15+1; i++) { // 15 columns
      for (int j=0; j<17; j++) { // 17 rows
        if (stopBubbleCollisionCheck)
          break doubleloop;
        if (CGC(i,j) != INV && !stopBubbleCollisionCheck) { 
          bubbleCollide(new GridPos(i,j));
        }
      }
    }
    stopBubbleCollisionCheck = false;
    if (mainCell.bubble.yPos<=gAPO){
      bottomCollide();
    }
  }

  public void bottomCollide(){
    
    GridPos g = new GridPos(0,0);
    
    float closestDist=dist(cellGrid[0][0].xPos,cellGrid[0][0].yPos,mainCell.bubble.xPos,mainCell.bubble.yPos);//dist to 0,0 bubble

    for (int j=0; j<17; j++){
      float aCellDist=dist(cellGrid[0][j].xPos,cellGrid[0][j].yPos,mainCell.bubble.xPos,mainCell.bubble.yPos);
      //println("checked 0," + j);
      //println("closest Dist :" + closestDist);
      //println("actual Dist: "+ aCellDist);
      if (aCellDist<closestDist){
        closestDist=aCellDist;
        g.j=j;
      }
    }
    
    //println("old color: " + hex(cellGrid[0][newJ].bubble.col) + ", " + "new color: " + hex(mainCell.bubble.col));
    
    cellGrid[0][g.j].bubble.col=mainCell.bubble.col;
    //println("bottom: bubble placed at 0," + newJ + " with col " + hex(cellGrid[0][newJ].bubble.col));
    bubbleHasCollided(g);
    
  }
  
  public void bubbleCollide(GridPos g) {
    
    GridPos newG = new GridPos();
    
    float actDist=dist(cellGrid[g.i][g.j].xPos,cellGrid[g.i][g.j].yPos,mainCell.bubble.xPos,mainCell.bubble.yPos);
    float collDist=2*mainCell.bubble.APO-3;
    
    if (actDist<=collDist) {
      
      float ang=-atan2(mainCell.bubble.yPos-cellGrid[g.i][g.j].yPos,mainCell.bubble.xPos-cellGrid[g.i][g.j].xPos);
      
      stopBubbleCollisionCheck=true; // stop checking for bubble collision
      
      if (ang <= PI/6 && ang > -PI/6) {
        newG = setBubbleColorAsMainColor(g.i,g.j+1);
      }
      else if (ang <= 3*PI/6 && ang > PI/6) {
        if (g.i%2==0) {
          newG = setBubbleColorAsMainColor(g.i-1,g.j);
        }
        else {
          newG = setBubbleColorAsMainColor(g.i-1,g.j+1);
        }
      }
      else if (ang <= 5*PI/6 && ang > 3*PI/6) {
        if (g.i%2==0) {
          newG = setBubbleColorAsMainColor(g.i-1,g.j-1);
        }
        else {
          newG = setBubbleColorAsMainColor(g.i-1,g.j);
        }
      }
      else if (ang <= -PI/6 && ang > -3*PI/6) {
        if (g.i%2==0) {
          newG = setBubbleColorAsMainColor(g.i+1,g.j);
        }
        else {
          newG = setBubbleColorAsMainColor(g.i+1,g.j+1);
        }
      }
      else if (ang <= -3*PI/6 && ang > -5*PI/6) {
        if (g.i%2==0) {
          newG = setBubbleColorAsMainColor(g.i+1,g.j-1);
        }
        else {
          newG = setBubbleColorAsMainColor(g.i+1,g.j);
        }
      }
      else { // either ang >5PI/6 or ang <-5PI/6
        newG = setBubbleColorAsMainColor(g.i,g.j-1);
      }
      
      if (newG.i>=15) {
        println("too high");
      }
      
      bubbleHasCollided(newG);
      
      
    }
    
  }
  
  public void bubbleHasCollided(GridPos newG){
    
    mouse=false; // allows mouse to be clicked again 
    
    checkColorConnections(newG);
    
    LinkedList<GridPos> topConnectList = checkTopConnectList();
    
    deleteIfNotConnected(topConnectList);
    
    checkColorsPresent();
    
    mainCell.bubble.resetBubble();
    mainCell.bubble.col=bottomCellGrid[0].bubble.col;
    bottomCellGrid[0].bubble.col=aColour.randomColour(); 
    
    checkWinLose();
    //println("");
    
  }
  
  public void checkWinLose(){
    for (int j = 0; j<17; j++){
      if (CGC(15,j)!=INV) {
        showGameOver=true; //<>//
        gameOver();
        break;
      }
    }
    if (!showGameOver){
      win=true;
      outerloop:
      for (int i=0; i<15+1; i++) { // 15 columns
        for (int j=0; j<17; j++) { // 17 rows
          if (CGC(i,j)!=INV){
            win = false;
            break outerloop;
          }
        }
      }
      if (win){
        showWin=true;
        gameOver();
      } 
    }
    
    
  }
  
  public void checkColorConnections(GridPos g){
    LinkedList<GridPos> checkPoppingList = new LinkedList<GridPos>();
    
    checkPopping(g.i, g.j, checkPoppingList);
    
    if (checkPoppingList.size()<3) {
      bottomNum--;
      changeDrawOutline();
    }
    else {
      for (GridPos popG : checkPoppingList){
        println("Color connection: " + colorName(hex(cellGrid[popG.i][popG.j].bubble.col)) +" bubble deleted at " + popG.i + "," + popG.j);
        cellGrid[popG.i][popG.j].bubble.col = INV;
      }
      
    }
  }
  
  public void checkPopping(int i, int j, LinkedList<GridPos> checkPoppingList) {
    if (i<=15  && i>=0 && j<=17 && j>=0) {
      if (CGC(i,j)==CGC(i,j+1) && !checkPoppingList.contains(new GridPos(i,j+1))) {
        checkPoppingList.add(new GridPos(i,j+1));
        checkPopping(i,j+1,checkPoppingList);
      }
      if (CGC(i,j)==CGC(i,j-1) && !checkPoppingList.contains(new GridPos(i,j-1))) {
        checkPoppingList.add(new GridPos(i,j-1));
        checkPopping(i,j-1,checkPoppingList);
      }
      if (CGC(i,j)==CGC(i+1,j) && !checkPoppingList.contains(new GridPos(i+1,j))) {
        checkPoppingList.add(new GridPos(i+1,j));
        checkPopping(i+1,j,checkPoppingList);
      }
      if (CGC(i,j)==CGC(i-1,j) && !checkPoppingList.contains(new GridPos(i-1,j))) {
        checkPoppingList.add(new GridPos(i-1,j));
        checkPopping(i-1,j,checkPoppingList);
      }
      
      if (i%2==0) {
        if (CGC(i,j)==CGC(i+1,j-1) && !checkPoppingList.contains(new GridPos(i+1,j-1))) {
          checkPoppingList.add(new GridPos(i+1,j-1));
          checkPopping(i+1,j-1,checkPoppingList);
        }
        if (CGC(i,j)==CGC(i-1,j-1) && !checkPoppingList.contains(new GridPos(i-1,j-1))) {
          checkPoppingList.add(new GridPos(i-1,j-1));
          checkPopping(i-1,j-1,checkPoppingList);
        }
      }
      else {
        if (CGC(i,j)==CGC(i+1,j+1) && !checkPoppingList.contains(new GridPos(i+1,j+1))) {
          checkPoppingList.add(new GridPos(i+1,j+1));
          checkPopping(i+1,j+1,checkPoppingList);
        }
        if (CGC(i,j)==CGC(i-1,j+1) && !checkPoppingList.contains(new GridPos(i-1,j+1))) {
          checkPoppingList.add(new GridPos(i-1,j+1));
          checkPopping(i-1,j+1,checkPoppingList);
        }
      }
    }
  }
   
  public LinkedList checkTopConnectList(){
    
    LinkedList<GridPos> topConnectList = new LinkedList<GridPos>();
    
    for (int j=0; j<17; j++) {
      if (this.cellGrid[0][j].bubble.col != INV){
        if (!topConnectList.contains(new GridPos(0,j))) {
          topConnectList.add(new GridPos(0,j));
        }
        checkTopConnect(0,j,topConnectList);
      }
    }
    
    /*
    for (GridPos g : topConnectList){
      println("" + g.i + " " + g.j);
    }
    */
    return topConnectList;
  }

  public void checkTopConnect(int i, int j, LinkedList<GridPos> topConnectList) {// return list of pairs to be deleted
    //println("added "+ i + " "+ j);
    if (CGC(i,j+1)!=INV && j<16 && !topConnectList.contains(new GridPos(i,j+1))){
      topConnectList.add(new GridPos(i,j+1));
      checkTopConnect(i,j+1,topConnectList);
    }
    if (CGC(i,j-1)!=INV && j>0 && !topConnectList.contains(new GridPos(i,j-1))){
      topConnectList.add(new GridPos(i,j-1));
      checkTopConnect(i,j-1,topConnectList);
    }
    if (CGC(i+1,j)!=INV && i<15 && !topConnectList.contains(new GridPos(i+1,j))){
      topConnectList.add(new GridPos(i+1,j));
      checkTopConnect(i+1,j,topConnectList);
    }
    if (CGC(i-1,j)!=INV && i>0 && !topConnectList.contains(new GridPos(i-1,j))){
      topConnectList.add(new GridPos(i-1,j));
      checkTopConnect(i-1,j,topConnectList);
    }
    if (i%2==0){
      if (CGC(i+1,j-1)!=INV && i<15 && j>0 && !topConnectList.contains(new GridPos(i+1,j-1))){
        topConnectList.add(new GridPos(i+1,j-1));
        checkTopConnect(i+1,j-1,topConnectList);
      }
      if (CGC(i-1,j-1)!=INV && i>0 && j>0 && !topConnectList.contains(new GridPos(i-1,j-1))){
        topConnectList.add(new GridPos(i-1,j-1));
        checkTopConnect(i-1,j-1,topConnectList);
      }
    }
    else {
      if (CGC(i+1,j+1)!=INV && i<15 && j<16 && !topConnectList.contains(new GridPos(i+1,j+1))){
        topConnectList.add(new GridPos(i+1,j+1));
        checkTopConnect(i+1,j+1,topConnectList);
      }
      if (CGC(i-1,j+1)!=INV && i>0 && j<16 && !topConnectList.contains(new GridPos(i-1,j+1))){
        topConnectList.add(new GridPos(i-1,j+1));
        checkTopConnect(i-1,j+1,topConnectList);
      }
    }   
  }
  
  public void deleteIfNotConnected(LinkedList<GridPos> topConnectList){
    LinkedList<GridPos> notConnectedList = new LinkedList<GridPos>();
    for (int i=0; i<15+1; i++) { // 15 columns
      for (int j=0; j<17; j++) { // 17 rows
        if (this.CGC(i,j) != INV && !topConnectList.contains(new GridPos(i,j))) {
          notConnectedList.add(new GridPos(i,j));
        }
      }
    }
    
    for (GridPos g : notConnectedList){
      println("Top connection: " + colorName(hex(cellGrid[g.i][g.j].bubble.col)) +" bubble deleted at " + g.i + "," + g.j);
      cellGrid[g.i][g.j].bubble.col=INV;
    }
    
  }
  
  public void changeDrawOutline() {
    if (bottomNum == 0) {
      bottomNum = (int)random(1,aColour.numColors);
      addLines();
    }
    for (Cell aCell : this.bottomCellGrid) {
      aCell.bubble.outline=false;
    }
    for (int i = 0; i<bottomNum; i++) {
      this.bottomCellGrid[i].bubble.outline = true;
    }
  }
  
  public void addLines(){
    int lines = 7 - aColour.numColors;
    //print(lines + " new line(s) generated with colors ");
    
    /*
    for (String col : aColour.colList2){
      print(colorName(col)+" ");
    }
    */    
    
    //println(lines + " lines added");
    for (int i=15+1; i>=0; i--) { // 15 columns
      for (int j=0; j<17; j++) { // 17 rows
        try {
          cellGrid[i+lines][j].bubble.col = CGC(i,j);
          //println((i+lines) + "," + j +" set as " + i + "," + j + " to " + hex(cellGrid[i+lines][j].bubble.col));
        }
        catch (ArrayIndexOutOfBoundsException e) {}
      }
    }
    
    for (int i = 0; i < lines; i++){
      for (int j=0; j<17; j++) {
        cellGrid[i][j].bubble.col = aColour.randomColour();
      }
    }
  }
  
  public void checkColorsPresent(){
    LinkedList<String> colsToBeRemoved = new LinkedList<String>();
    
    for (String aCol : aColour.colList2) {
      boolean colorPresent = false;
      
      doubleLoop:
      for (int i=0; i<15+1; i++) { // 15 columns
        for (int j=0; j<17; j++) { // 17 rows
          if (unhex(aCol) == CGC(i,j) || 
              unhex(aCol) == bottomCellGrid[0].bubble.col || 
              unhex(aCol) == mainCell.bubble.col) { // can be refactored?
            colorPresent=true;
            break doubleLoop;
          }
        }
      }
      if (!colorPresent){
        colsToBeRemoved.add(aCol);
      }
      
    }
    for (String aCol : colsToBeRemoved){
      aColour.removeCol(aCol);
    }
    
  }
  
  public GridPos setBubbleColorAsMainColor(int i, int j) {
    try {
      cellGrid[i][j].bubble.col=mainCell.bubble.col;
      
    } catch (ArrayIndexOutOfBoundsException e) {} // this shouldn't ever happen

    return new GridPos(i,j); 
  }
  
  public color CGC(int i, int j) { // returns Cell Grid Color CGC
    try {
      return this.cellGrid[i][j].bubble.col;
    }
    catch (ArrayIndexOutOfBoundsException e) {
      
      return color (1,1,1,1); // color that nothing matches with
    }
  }
  
  public String colorName(String hex){
    if (hex.equals("FFFF0000"))
      return "red";
    else if (hex.equals("FFF0E600"))
      return "yellow";
    else if (hex.equals("FF00FF00"))
      return "green";
    else if (hex.equals("FF00FFFF"))
      return "cyan";
    else if (hex.equals("FF0000FF"))
      return "blue";
    else if (hex.equals("FF7F00FF"))
      return "purple";
    else if (hex.equals("00010101"))
      return "invisible";
    else
      return ""; //should never happen
  }
  
  public void gameOver(){
    arrow.show=false;
    mainCell.bubble.hide=true;
    bottomCellGrid[0].bubble.hide=true;
    mouse=true;
    
  }
  
  
}
