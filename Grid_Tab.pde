public class Grid {

  Cell[][] cellGrid = new Cell[15][17];
  Cell[] bottomCellGrid= new Cell[6];
  Cell mainCell;
  
  /*
  Bubble aBubble;
  //float RAD = aBubble.RAD;
  //float APO = aBubble.APO;
  */
  
  int gRAD=18; // grid radius
  float gAPO = sqrt(3)*gRAD/2;

  Colour aColour = new Colour();

  Grid() {
  }

  public void populate() {
    for (int i=0; i<15; i++) { // 15 columns
      for (int j=0; j<17; j++) { // 17 rows
        if (i % 2 == 0){
          this.cellGrid[i][j] = new Cell(new Bubble((i<9) ? aColour.randomColour() : INV,false), int(gAPO+2*gAPO*j), int(gRAD+1.5*gRAD*i));
          //System.out.println(this.cellGrid[i][j].bubble.col);
        }
        else
          this.cellGrid[i][j] = new Cell(new Bubble((i<9) ? aColour.randomColour() : INV,false), int(2*gAPO+(2*gAPO*j)), int(gRAD+1.5*gRAD*i));
      }
    }
    for (int i=0; i<6; i++) {
      this.bottomCellGrid[i] = new Cell(new Bubble(INV,true), int(2*gAPO+37*i), int(gRAD+1.5*gRAD*16));
    }
    this.mainCell = new Cell(new Bubble(aColour.randomColour(), false), int(gAPO+2*gAPO*8), int(gRAD+1.5*gRAD*16));
    this.bottomCellGrid[0].bubble.col=aColour.randomColour();
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
    
    
    
    
  }
  
}
