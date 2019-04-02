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
      aCell.drawCell(); //all but one need to be empty
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
      
      
      
      println(newI + " " + newJ + ":");
      println(hex(CGC(newI,newJ)));
      checkPopping(newI, newJ);
      println(numTouching);
      println("");
      if (numTouching<3)
        bottomNum--;
      
      
      numTouching=0;
      
      mainCell.bubble.resetBubble();
      
      mainCell.bubble.col=bottomCellGrid[0].bubble.col;
      bottomCellGrid[0].bubble.col=aColour.randomColour(); 
      
      
    }
  }
  
  int numTouching=0;
  
  public void checkPopping(int i, int j) {
    //println(hex(CGC(i,j)));
    //println(hex(INV));
    //println(i + " " + j);
    
    //try {
      if (hex(CGC(i,j)).equals(hex(CGC(i,j+1))) && !this.cellGrid[i][j].bubble.popCheck) {
        println(i + " " + str(j+1) + ":");
        println(hex(CGC(i,j+1)));
        this.cellGrid[i][j].bubble.popCheck=true;
        checkPopping(i,j+1);
        numTouching++;
      }
      else if (hex(CGC(i,j)).equals(hex(CGC(i,j-1))) && !this.cellGrid[i][j].bubble.popCheck) {
        println(i + " " + str(j-1) + ":");
        println(hex(CGC(i,j-1)));
        this.cellGrid[i][j].bubble.popCheck=true;
        checkPopping(i,j-1);
        numTouching++;
      }
      else if (hex(CGC(i,j)).equals(hex(CGC(i+1,j))) && !this.cellGrid[i][j].bubble.popCheck) {
        println(str(i+1) + " " + str(j) + ":");
        println(hex(CGC(i+1,j)));
        this.cellGrid[i][j].bubble.popCheck=true;
        checkPopping(i+1,j);
        numTouching++;
      }
      else if (hex(CGC(i,j)).equals(hex(CGC(i-1,j))) && !this.cellGrid[i][j].bubble.popCheck) {
        println(str(i-1) + " " + str(j) + ":");
        println(hex(CGC(i-1,j)));
        this.cellGrid[i][j].bubble.popCheck=true;
        checkPopping(i-1,j);
        numTouching++;
      }
      
      else if (i%2==0) {
        if (hex(CGC(i,j)).equals(hex(CGC(i+1,j-1))) && !this.cellGrid[i][j].bubble.popCheck) {
          println(str(i+1) + " " + str(j-1) + ":");
          println(hex(CGC(i+1,j-1)));
          this.cellGrid[i][j].bubble.popCheck=true;
          checkPopping(i+1,j-1);
          numTouching++;
        }
        else if (hex(CGC(i,j)).equals(hex(CGC(i-1,j-1))) && !this.cellGrid[i][j].bubble.popCheck) {
          println(str(i-1) + " " + str(j-1) + ":");
          println(hex(CGC(i-1,j-1)));
          this.cellGrid[i][j].bubble.popCheck=true;
          checkPopping(i-1,j-1);
          numTouching++;
        }
        
      }
      else {
        if (hex(CGC(i,j)).equals(hex(CGC(i+1,j+1))) && !this.cellGrid[i][j].bubble.popCheck) {
          println(str(i+1) + " " + str(j+1) + ":");
          println(hex(CGC(i+1,j+1)));
          this.cellGrid[i][j].bubble.popCheck=true;
          checkPopping(i+1,j+1);
          numTouching++;
        }
        else if (hex(CGC(i,j)).equals(hex(CGC(i-1,j+1))) && !this.cellGrid[i][j].bubble.popCheck) {
          println(str(i-1) + " " + str(j+1) + ":");
          println(hex(CGC(i-1,j+1)));
          this.cellGrid[i][j].bubble.popCheck=true;
          checkPopping(i-1,j+1);
          numTouching++;
        }
       
      //}
    //} catch (ArrayIndexOutOfBoundsException e){
    //  ;
    }
  
  }
  
  public color CGC(int i, int j){
    try {
      return this.cellGrid[i][j].bubble.col;
    } catch (ArrayIndexOutOfBoundsException e){
      return color (5,5,5,5);
    }
  }
  
  
  
}
