public class Grid {

  Cell[][] cellGrid = new Cell[15][17];
  Cell[] bottomCellGrid= new Cell[6];
  Cell mainCell;
  
  Bubble aBubble;
  //float RAD = aBubble.RAD;
  //float APO = aBubble.APO;
  
  int RAD=17;
  float APO = sqrt(3)*RAD/2;

  Colour aColour = new Colour();

  Grid() {
  }

  public void populate() {
    System.out.println("start grid pop");
    for (int i=0; i<15; i++) { // 15 columns
      for (int j=0; j<17; j++) { // 17 rows
        if (i % 2 == 0)
          this.cellGrid[i][j] = new Cell(new Bubble((i<9) ? aColour.randomColour() : INV,false), int(APO+2*APO*j), int(RAD+1.5*RAD*i));
        else
          this.cellGrid[i][j] = new Cell(new Bubble((i<9) ? aColour.randomColour() : INV,false), int(2*APO+(2*APO*j)), int(RAD+1.5*RAD*i));
      }
    }
    for (int i=0; i<6; i++) {
      this.bottomCellGrid[i] = new Cell(new Bubble(INV,true), int(2*APO+37*i), int(RAD+1.5*RAD*16));
    }
    this.mainCell = new Cell(new Bubble(aColour.randomColour(), false), int(APO+2*APO*8), int(RAD+1.5*RAD*16));
    this.bottomCellGrid[0].bubble.col=aColour.randomColour();
    System.out.println("end grid pop");
  }
  
  
  public void drawGrid() {
    for (Cell[] cellRow : this.cellGrid) {
      for (Cell aCell : cellRow) { 
        aCell.drawBubble(); 
      }
    }
    for (Cell aCell : this.bottomCellGrid){
      aCell.drawBubble(); //all but one need to be empty
    }
    mainCell.drawBubble();
  }
  
  public void shoot() {
  }
  
}
