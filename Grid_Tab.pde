public class Grid {

  Cell[][] cellGrid;
  Cell[] bottomCellGrid;
  Cell mainCell;

  Colour aColour = new Colour();

  Grid(Cell[][] cellGrid, Cell[] bottomCellGrid) {
    this.cellGrid=cellGrid;
    this.bottomCellGrid=bottomCellGrid;
  }

  public void populate() {
    for (int i=0; i<15; i++) { // 15 columns
      for (int j=0; j<17; j++) { // 17 rows
        if (i % 2 == 0)
          this.cellGrid[i][j] = new Cell(new GridBubble((i<9) ? aColour.randomColour() : INV,false), int(apothem+2*apothem*j), int(radius+1.5*radius*i));
        else
          this.cellGrid[i][j] = new Cell(new GridBubble((i<9) ? aColour.randomColour() : INV,false), int(2*apothem+(2*apothem*j)), int(radius+1.5*radius*i));
      }
    }
    for (int i=0; i<6; i++) {
      this.bottomCellGrid[i] = new Cell(new GridBubble(INV,true), int(2*apothem+37*i), int(radius+1.5*radius*16));
    }
    this.mainCell = new Cell(new GridBubble(aColour.randomColour(), false), int(apothem+2*apothem*8), int(radius+1.5*radius*16));
    this.bottomCellGrid[0].bubble.col=aColour.randomColour();
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
