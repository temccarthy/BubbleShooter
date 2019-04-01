class HexGrid {
  
  //HexGrid(){}
  
  PShape hexagon;
  int WIDTH = round(gAPO*35)+1;
  int HEIGHT = round(gRAD+1.5*gRAD*18);
  
  float angle=30.0*PI/180.0;
  float sixty=0.0;
  
  public void makeHex(){
    hexagon = createShape();
    hexagon.beginShape();
    
    for (int i = 0; i<=6; i++) {
      hexagon.vertex(gRAD*cos(angle+sixty), gRAD*sin(angle+sixty));
      sixty+=60.0*PI/180.0;
    }
    hexagon.endShape(); 
  }
  
  public void drawHexGrid(){
    for (int i=0; i<15; i++) {
      if (i % 2 == 0) {
        for (int j=0; j<17; j++)
          shape(hexagon,(gAPO+2*gAPO*j),(gRAD+1.5*gRAD*i));
      } 
      else {
        for (int j=0; j<17; j++) {
          shape(hexagon,2*gAPO+(2*gAPO*j),gRAD+1.5*gRAD*i);
        }
        
      }
    }
  }
  
  
}
