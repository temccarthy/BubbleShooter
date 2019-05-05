//Bubble Shooter reverse engineering

/* TODO
- finish collide with bottom

- gameover (move bubble down again?)
- score?

- refactor 
*/

public int gRAD=19; // grid radius
public float gAPO = sqrt(3)*gRAD/2;
int WIDTH = round(gAPO*35)+1;
int HEIGHT = round(gRAD+1.5*gRAD*18);

Grid grid = new Grid();
Arrow arrow = new Arrow();
HexGrid hGrid = new HexGrid();

boolean mouse;


public void mousePressed(){
  //if bottom bubble hasn't been shot:
  mouse=true;
  //once it gets into a cell, reset mouse to false
}

void settings(){
  size(WIDTH,HEIGHT);
}

void setup() {
  //frameRate(15);
  hGrid.makeHex();
  grid.populate();
  
}

void draw() {
  
  background(255); //refresh
  
  hGrid.drawHexGrid();
  
  grid.drawGrid();
  arrow.drawArrow();
  if (mouse) {
    grid.shootMain();
  }
  hGrid.drawNumGrid();
  
}
