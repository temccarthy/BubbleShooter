//Bubble Shooter reverse engineering

/* TODO
- double bubble problem
- wrong color when appears in grid
- cant change angle on new shot
- movement?
*/

int gRadius=18; // grid radius
float apothem = sqrt(3)*gRadius/2;
int WIDTH = round(apothem*35)+1;
int HEIGHT = round(gRadius+1.5*gRadius*18);

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
  //frameRate(60);
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
    //if (grid.mainCell.bubble.collided)
      //System.out.println("collided!");
  }
  
  
}
