//Bubble Shooter reverse engineering

/* TODO
- mouse boolean that when mouse is pressed, is true until bubble lands in grid
- shooting/moving bubble from main cell to grid

*/
PShape hexagon;
int radius=18;
float apothem = sqrt(3)*radius/2;
int WIDTH = round(apothem*35)+1;
int HEIGHT = round(radius+1.5*radius*18);

Grid grid = new Grid(new Cell[15][17],new Cell[6]);
Arrow arrow = new Arrow();

boolean mouse;
  
  

void settings(){
  size(WIDTH,HEIGHT);
}

void setup() {
  //frameRate(60);
  
  //Defines hexagon for grid
  float angle=30.0*PI/180.0;
  float sixty=0.0;
  hexagon = createShape();
  hexagon.beginShape();
  for (int i = 0; i<=6; i++) {
    hexagon.vertex(radius*cos(angle+sixty), radius*sin(angle+sixty));
    sixty+=60.0*PI/180.0;
  }
  hexagon.endShape();
  
  
  grid.populate();
  
}

void draw() {
  background(255);
  
  //GRID
  /*
  for (int i=0; i<15; i++) {
    if (i % 2 == 0) {
      for (int j=0; j<17; j++) {
        shape(hexagon,(apothem+2*apothem*j),(radius+1.5*radius*i));
      }
      
    } 
    else {
      for (int j=0; j<17; j++) {
        shape(hexagon,2*apothem+(2*apothem*j),radius+1.5*radius*i);
      }
      
    }
  }
  */
  
  
  grid.drawGrid();
  arrow.drawArrow();
  System.out.println(mouse);
  
  
}
