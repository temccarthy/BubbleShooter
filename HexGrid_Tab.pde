class HexGrid {
  
  //HexGrid(){}
  
  PShape hexagon;
  int gRadius=18; // grid radius
  float apothem = sqrt(3)*gRadius/2;
  int WIDTH = round(apothem*35)+1;
  int HEIGHT = round(gRadius+1.5*gRadius*18);
  
  float angle=30.0*PI/180.0;
  float sixty=0.0;
  
  public void makeHex(){
    hexagon = createShape();
    hexagon.beginShape();
    
    for (int i = 0; i<=6; i++) {
      hexagon.vertex(gRadius*cos(angle+sixty), gRadius*sin(angle+sixty));
      sixty+=60.0*PI/180.0;
    }
    hexagon.endShape(); 
  }
  
  public void drawHexGrid(){
    for (int i=0; i<15; i++) {
      if (i % 2 == 0) {
        for (int j=0; j<17; j++)
          shape(hexagon,(apothem+2*apothem*j),(gRadius+1.5*gRadius*i));
      } 
      else {
        for (int j=0; j<17; j++) {
          shape(hexagon,2*apothem+(2*apothem*j),gRadius+1.5*gRadius*i);
        }
        
      }
    }
  }
  
  
}
