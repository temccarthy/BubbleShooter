//Bubble Shooter reverse engineering



/* TODO
enums

draw bubble in cell, THEN grid class (x and y position)


*/
PShape hexagon;
int radius=20;
float apothem = sqrt(3)*radius/2;
int WIDTH = round(apothem*35);
int HEIGHT = round((2*radius+21*radius));

Grid grid = new Grid(new Cell[15][17]);


void settings(){
  size(WIDTH+1,HEIGHT);
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
  
  
  
  //Bubbles?
  for (int i=0; i<15; i++) {
    for (int j=0; j<17; j++) {
      fill(#FF0000);
      noStroke();
      circle(grid.cellGrid[i][j].xPos,grid.cellGrid[i][j].yPos,2*apothem-4);
        
    }
    
  }
  
  
  
  
  
}
