import java.util.Queue;
import java.util.ArrayDeque;


public class Grid {

  Cell[][] cellGrid = new Cell[15+1][17];
  Cell[] bottomCellGrid= new Cell[6];
  Cell mainCell;
  
  boolean stopCollision = false; // replace with break?

  Colour aColour = new Colour();
  
  int bottomNum;
  
  
  Grid() {
  }

  public void populate() {
    for (int i=0; i<15+1; i++) { // 15+1 rows
      for (int j=0; j<17; j++) { // 17 items per row (last row is for losing)
        if (i % 2 == 0)
          this.cellGrid[i][j] = new Cell(new Bubble((i<9) ? aColour.randomColour() : INV,false), gAPO+2*gAPO*j, gRAD+1.5*gRAD*i);
        else
          this.cellGrid[i][j] = new Cell(new Bubble((i<9) ? aColour.randomColour() : INV,false), 2*gAPO+(2*gAPO*j), gRAD+1.5*gRAD*i);
      }
    }
    this.bottomNum=6;
    for (int i=0; i<this.bottomNum; i++) {
      this.bottomCellGrid[i] = new Cell(new Bubble(INV,true), 2*gAPO+37*i, gRAD+1.5*gRAD*16);
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
    for (int i=0; i<15+1; i++) { // 15 columns
      for (int j=0; j<17; j++) { // 17 rows
        if (cellGrid[i][j].bubble.col != INV && !stopCollision) { 
          this.collide(cellGrid[i][j], i, j);
        }
      }
    }
    stopCollision = false;
  }
  
  public void resetChecking() {
    for (Cell[] cellRow : this.cellGrid) {
      for (Cell aCell : cellRow) { 
        aCell.bubble.popCheck = false;
        aCell.bubble.delete=false;
      }
    }
    mainCell.bubble.popCheck = false;
  }
  
  public void collide(Cell aCell,int i, int j) {
    int newI;
    int newJ;
    
    float actDist=dist(aCell.xPos,aCell.yPos,mainCell.bubble.xPos,mainCell.bubble.yPos);
    float collDist=2*mainCell.bubble.RAD-8;
    
    float ang=atan2(mainCell.bubble.yPos-aCell.yPos,mainCell.bubble.xPos-aCell.xPos);
    
    if (collDist>=actDist) {
      stopCollision=true;
      
      if (ang <= PI/6 && ang > -PI/6) {
        cellGrid[i][j+1].bubble.col=mainCell.bubble.col;
        newI = i;
        newJ = j+1;
      }
      else if (ang <= 3*PI/6 && ang > PI/6) {
        if (i%2==0) {
          cellGrid[i+1][j].bubble.col=mainCell.bubble.col;
          newI = i+1;
          newJ = j;
        }
        else {
          cellGrid[i+1][j+1].bubble.col=mainCell.bubble.col;
          newI = i+1;
          newJ = j+1;
        }
      }
      else if (ang <= 5*PI/6 && ang > 3*PI/6) {
        if (i%2==0) {
          cellGrid[i+1][j-1].bubble.col=mainCell.bubble.col;
          newI = i+1;
          newJ = j-1;
        }
        else {
          cellGrid[i+1][j].bubble.col=mainCell.bubble.col;
          newI = i+1;
          newJ = j;
        }
      }
      else if (ang <= -PI/6 && ang > -3*PI/6) {
        if (i%2==0) {
          cellGrid[i-1][j].bubble.col=mainCell.bubble.col;
          newI = i-1;
          newJ = j;
        }
        else {
          cellGrid[i-1][j+1].bubble.col=mainCell.bubble.col;
          newI = i-1;
          newJ = j+1;
        }
      }
      else if (ang <= -3*PI/6 && ang > -5*PI/6) {
        if (i%2==0) {
          cellGrid[i-1][j-1].bubble.col=mainCell.bubble.col;
          newI = i-1;
          newJ = j-1;
        }
        else {
          cellGrid[i-1][j].bubble.col=mainCell.bubble.col;
          newI = i-1;
          newJ = j;
        }
      }
      else {
        cellGrid[i][j-1].bubble.col=mainCell.bubble.col;
        newI = i;
        newJ = j-1;
      }
      
      mouse=false;
      
      //println(newI + " " + newJ + ":");
      //println(hex(CGC(newI,newJ)));
      
      checkPopping(newI, newJ);
      this.resetChecking();
      
      if (numTouching<3){
        bottomNum--;
        changeDrawOutline();
      }
      else{
        //println(newI+" "+newJ);
        pop(newI,newJ);
        delete();
      }
      resetChecking();
      
      checkTopConnectQ();
      
      
      /*
      for (int a=0; a<15; a++) { // 15 columns
        for (int b=0; b<17; b++) { // 17 rows
          if (cellGrid[a][b].bubble.col != INV){
            checkTopConnect(a,b);
            breakrec=false;
          }
        }
      }
      
      
      println(notConnected);
      
      
      for (int c=0;c<notConnected.size()/2; c++) {
        cellGrid[2*c][2*c+1].bubble.col = INV;
      }
      
      resetChecking();
      notConnected.clear();
      */
      
      mainCell.bubble.resetBubble();
      numTouching=1;
      mainCell.bubble.col=bottomCellGrid[0].bubble.col;
      bottomCellGrid[0].bubble.col=aColour.randomColour(); 
      
      
    }
  }
  
  int numTouching=1;
  
  public void checkPopping(int i, int j) {
    
    this.cellGrid[i][j].bubble.popCheck=true;
    
    if (hex(CGC(i,j)).equals(hex(CGC(i,j+1))) && !this.cellGrid[i][j+1].bubble.popCheck) {
      
      numTouching++;
      checkPopping(i,j+1);
    }
    if (hex(CGC(i,j)).equals(hex(CGC(i,j-1))) && !this.cellGrid[i][j-1].bubble.popCheck) {
      numTouching++;
      checkPopping(i,j-1);
    }
    if (hex(CGC(i,j)).equals(hex(CGC(i+1,j))) && !this.cellGrid[i+1][j].bubble.popCheck) {
      numTouching++;
      checkPopping(i+1,j);
    }
    if (hex(CGC(i,j)).equals(hex(CGC(i-1,j))) && !this.cellGrid[i-1][j].bubble.popCheck) {
      numTouching++;
      checkPopping(i-1,j);
    }
    
    if (i%2==0) {
      if (hex(CGC(i,j)).equals(hex(CGC(i+1,j-1))) && !this.cellGrid[i+1][j-1].bubble.popCheck) {
        numTouching++;          
        checkPopping(i+1,j-1);
      }
      if (hex(CGC(i,j)).equals(hex(CGC(i-1,j-1))) && !this.cellGrid[i-1][j-1].bubble.popCheck) {
        numTouching++;          
        checkPopping(i-1,j-1);

      }
      
    }
    else {
      if (hex(CGC(i,j)).equals(hex(CGC(i+1,j+1))) && !this.cellGrid[i+1][j+1].bubble.popCheck) {
        numTouching++;
        checkPopping(i+1,j+1);
      }
      if (hex(CGC(i,j)).equals(hex(CGC(i-1,j+1))) && !this.cellGrid[i-1][j+1].bubble.popCheck) {
        numTouching++;
        checkPopping(i-1,j+1);
      }
    }
  }
  
  public color CGC(int i, int j) { // returns Cell Grid Color CGC
    try {
      return this.cellGrid[i][j].bubble.col;
    }
    catch (ArrayIndexOutOfBoundsException e) {
      return color (5,5,5,5); // color that nothing matches with
    }
  }
  
  public void pop(int i, int j){
    this.cellGrid[i][j].bubble.popCheck=true;
    this.cellGrid[i][j].bubble.delete=true;
    
    if (hex(CGC(i,j)).equals(hex(CGC(i,j+1))) && !this.cellGrid[i][j+1].bubble.popCheck) {
      pop(i,j+1);
    }
    if (hex(CGC(i,j)).equals(hex(CGC(i,j-1))) && !this.cellGrid[i][j-1].bubble.popCheck) {
      pop(i,j-1);
    }
    if (hex(CGC(i,j)).equals(hex(CGC(i+1,j))) && !this.cellGrid[i+1][j].bubble.popCheck) {
      pop(i+1,j);
    }
    if (hex(CGC(i,j)).equals(hex(CGC(i-1,j))) && !this.cellGrid[i-1][j].bubble.popCheck) {
      pop(i-1,j);
    }
    if (i%2==0) {
      if (hex(CGC(i,j)).equals(hex(CGC(i+1,j-1))) && !this.cellGrid[i+1][j-1].bubble.popCheck) {        
        pop(i+1,j-1);
      }
      if (hex(CGC(i,j)).equals(hex(CGC(i-1,j-1))) && !this.cellGrid[i-1][j-1].bubble.popCheck) {        
        pop(i-1,j-1);
      }
    }
    else {
      if (hex(CGC(i,j)).equals(hex(CGC(i+1,j+1))) && !this.cellGrid[i+1][j+1].bubble.popCheck) {
        pop(i+1,j+1);
      }
      if (hex(CGC(i,j)).equals(hex(CGC(i-1,j+1))) && !this.cellGrid[i-1][j+1].bubble.popCheck) {
        pop(i-1,j+1);
      }
    }
  }
  
   Queue<Integer> topConnectQ = new ArrayDeque();
  
  void checkTopConnectQ(){
    //starting at 0,0
    //if not INV
    //if not in queue already
    
    
  }
  
  
  
  boolean breakrec = false;
  ArrayList<Integer> notConnected = new ArrayList<Integer>();
  
  public void checkTopConnect(int i, int j) {// return list of pairs to be deleted
    this.cellGrid[i][j].bubble.popCheck=true;
    notConnected.add(i); notConnected.add(j);
    println("added "+ i + " "+ j);
    
    if (i!=0) {
      if ((CGC(i,j+1)!=INV) && j<16 && !this.cellGrid[i][j+1].bubble.popCheck && !breakrec)
        checkTopConnect(i,j+1);
      if ((CGC(i,j-1)!=INV) && j>0 && !this.cellGrid[i][j-1].bubble.popCheck && !breakrec)
        checkTopConnect(i,j-1);
      if ((CGC(i+1,j)!=INV) && i<15 && !this.cellGrid[i+1][j].bubble.popCheck && !breakrec)
        checkTopConnect(i+1,j);
      if ((CGC(i-1,j)!=INV) && i>0 && !this.cellGrid[i-1][j].bubble.popCheck && !breakrec)
        checkTopConnect(i-1,j);
      if (i%2==0){
        if ((CGC(i+1,j-1)!=INV) && i<15 && j>0 && !this.cellGrid[i+1][j-1].bubble.popCheck && !breakrec)
          checkTopConnect(i+1,j-1);
        if ((CGC(i-1,j-1)!=INV) && i>0 && j>0 && !this.cellGrid[i-1][j-1].bubble.popCheck && !breakrec)
          checkTopConnect(i-1,j-1);
      }
      else {
        if ((CGC(i+1,j+1)!=INV) && i<15 && j<16 && !this.cellGrid[i+1][j+1].bubble.popCheck && !breakrec)
          checkTopConnect(i+1,j+1);
        if ((CGC(i-1,j+1)!=INV) && i>0 && j<16 && !this.cellGrid[i-1][j+1].bubble.popCheck && !breakrec)
          checkTopConnect(i-1,j+1);
          
      }
      if (breakrec) {
        println("cleared");
        notConnected.clear();
        return;
        //final break?
      }
      else {
        //nothing?
      }
    }
    else { //if i==0
      println("broke");
      breakrec=true;
      return;
      //break recursion
    }
  }
  
  public void delete(){
    for (Cell[] cellRow : this.cellGrid) {
      for (Cell aCell : cellRow) { 
        if (aCell.bubble.delete)
          aCell.bubble.col = INV;
      }
    }
  }
  
  public void changeDrawOutline() {
    if (bottomNum == 0)
      bottomNum = (int)random(1,6);
    for (Cell aCell : this.bottomCellGrid) {
      aCell.bubble.outline=false;
    }
    for (int i = 0; i<bottomNum; i++) {
      this.bottomCellGrid[i].bubble.outline = true;
    }
    // the 6 will be dependent on the number of colors in the game
      //function for adding row(s), also dependent of the number of colors
    
  }
}
