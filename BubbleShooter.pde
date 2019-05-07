//Bubble Shooter reverse engineering

/* TODO
- finish collide with bottom

- gameover (move bubble down again?)
- score?

- refactor 
*/

public int gRAD=19; // grid radius
public float gAPO = sqrt(3)*gRAD/2;
public final int WIDTH = round(gAPO*35)+1;
public final int HEIGHT = round(gRAD+1.5*gRAD*18);

Grid grid = new Grid();
Arrow arrow = new Arrow();
HexGrid hGrid = new HexGrid();

boolean mouse=false;
boolean showGameOver=false;
boolean showWin=false;


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
  
  background(255); //refresh //<>//
  
  //hGrid.drawHexGrid();
  stroke(0);
  line(0,gRAD+1.5*gRAD*14+.75*gRAD,WIDTH,gRAD+1.5*gRAD*14+.75*gRAD);
  
  grid.drawGrid();
  arrow.drawArrow();
  if (mouse){
    if(!showGameOver && !showWin) {
      grid.shootMain();
    }
  }
  
  fill(0);
  textSize(50);
  if (showGameOver){
    text("You lose!", WIDTH/2, HEIGHT/2);
  }
  if (showWin){
    text("You win!", WIDTH/2, HEIGHT/2);
  }
  
  
  //hGrid.drawNumGrid();
  
}
