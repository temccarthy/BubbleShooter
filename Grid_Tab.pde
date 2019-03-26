public class Grid {

  Cell[][] cellGrid; //= new Cell[17][15];

  GridBubble aBubble;


  Grid(Cell[][] cellGrid) {
    this.cellGrid=cellGrid;
  }

  public void populate() {
    for (int i=0; i<15; i++) {
      if (i % 2 == 0) {
        for (int j=0; j<17; j++) {
          cellGrid[i][j] = new Cell(aBubble, int(apothem+2*apothem*j), int(radius+1.5*radius*i));
        }
      } else {
        for (int j=0; j<17; j++) {
          cellGrid[i][j] = new Cell(aBubble, int(2*apothem+(2*apothem*j)), int(radius+1.5*radius*i));
        }
      }
    } 
    



    //for (int i=0; i<14; i++) {
    //  for (int j=0; j<16; j++){
    //    cellGrid[i][j] = new Cell(aBubble, 0,0);
    //  }
    //}
  }
}
