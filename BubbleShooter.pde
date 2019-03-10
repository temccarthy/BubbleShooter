//Bubble Shooter reverse engineering

PShape hexagon;
int size=10;
float angle=0.0;
float sixty=0.0;

void setup(){
  size(400,400);
  frameRate(60);
  hexagon = createShape();
  hexagon.beginShape();
  for (int i = 1; i<=6; i++){
    hexagon.vertex(size*cos(angle+sixty),size*sin(angle+sixty));
    sixty+=60.0;
  }
  hexagon.endShape();
  
  
  
  
  
  
}

void draw(){
  background(255);
  shape(hexagon,200,200);
  
  
}
