public class Grid {

  Cell[][] cellGrid = new Cell[15][17];
  Cell[] bottomCellGrid= new Cell[6];
  Cell mainCell;
  
  boolean stop = false; // replace with break
  
  /*
  Bubble aBubble;
  //float RAD = aBubble.RAD;
  //float APO = aBubble.APO;
  */

  Colour aColour = new Colour();
  
  
  boolean hasCollided;

  Grid() {
  }

  public void populate() {
    for (int i=0; i<15; i++) { // 15 columns
      for (int j=0; j<17; j++) { // 17 rows
        if (i % 2 == 0){
          this.cellGrid[i][j] = new Cell(new Bubble((i<9) ? aColour.randomColour() : INV,false), gAPO+2*gAPO*j, gRAD+1.5*gRAD*i);
          //System.out.println(this.cellGrid[i][j].bubble.col);
        }
        else
          this.cellGrid[i][j] = new Cell(new Bubble((i<9) ? aColour.randomColour() : INV,false), 2*gAPO+(2*gAPO*j), gRAD+1.5*gRAD*i);
      }
    }
    for (int i=0; i<6; i++) {
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
    for (int i=0; i<15; i++) { // 15 columns
      for (int j=0; j<17; j++) { // 17 rows
        if (cellGrid[i][j].bubble.col != INV && !stop) { 
          //stroke(0);
          //line(aCell.xPos,aCell.yPos,mainCell.bubble.xPos,mainCell.bubble.yPos);
          this.collide(cellGrid[i][j], i, j);
        }
      }
    }
    stop = false;
  }
  
  public void collide(Cell aCell,int i, int j) {
    float actDist=dist(aCell.xPos,aCell.yPos,mainCell.bubble.xPos,mainCell.bubble.yPos);
    
    float ang=atan2(mainCell.bubble.yPos-aCell.yPos,mainCell.bubble.xPos-aCell.xPos);
    float simpAng=ang;
    while (!(simpAng < PI/6 && simpAng > -PI/6)) {
      if (simpAng>PI/6) {
        simpAng-=PI/6;
      }
      else if (simpAng<PI/6) {
        simpAng+=PI/6;
      }
    }
    
    float hexDist = gRAD/cos(simpAng);
    float collDist = mainCell.bubble.RAD+hexDist;
    
    if (collDist>=actDist) {
      if (ang <= PI/6 && ang > -PI/6) {
        cellGrid[i][j+1].bubble.col=mainCell.bubble.col;
      }
      else if (ang <= 3*PI/6 && ang > PI/6) {
        if (i%2==0)
          cellGrid[i+1][j].bubble.col=mainCell.bubble.col;
        else
          cellGrid[i+1][j+1].bubble.col=mainCell.bubble.col;
      }
      else if (ang <= 5*PI/6 && ang > 3*PI/6) {
        if (i%2==0)
          cellGrid[i+1][j-1].bubble.col=mainCell.bubble.col;
        else
          cellGrid[i+1][j].bubble.col=mainCell.bubble.col;
      }
      else if (ang <= -PI/6 && ang > -3*PI/6) {
        if (i%2==0)
          cellGrid[i-1][j].bubble.col=mainCell.bubble.col;
        else
          cellGrid[i-1][j+1].bubble.col=mainCell.bubble.col;
      }
      else if (ang <= -3*PI/6 && ang > -5*PI/6) {
        if (i%2==0)
          cellGrid[i-1][j-1].bubble.col=mainCell.bubble.col;
        else
          cellGrid[i-1][j].bubble.col=mainCell.bubble.col;
      }
      else {
        cellGrid[i][j-1].bubble.col=mainCell.bubble.col;
      }
      
      mainCell.bubble.inCell=true;
      mainCell.bubble.resetBubble();
      mouse=false;
      //arrow.show=true;
      
      mainCell.bubble.col=bottomCellGrid[0].bubble.col;
      bottomCellGrid[0].bubble.col=aColour.randomColour();
      mainCell.bubble.collided=true;
      stop=true;
      
    }
    
    //find dist from cell center to main bubble center
      //dist()
    //find colliding distance
      //the angle from the bubble to cell
      //find dist to edge of hexagon based on angle
      //add radius to get ans
    //compare dist to coll dist
      //if actual dist < coll dist
        //add mainbubble to adjacent cell
        //old mainbubble not mainbubble
        //new waiting bubble
        //old waiting bubb/le = new main bubble
    
  }
  
  
}
