public class Cell {
  
  int radius=20;
  float apothem = sqrt(3)*radius/2;
  
  GridBubble bubble;
  int xPos;
  int yPos;
  
  Cell(GridBubble bubble, int xPos, int yPos){
    this.bubble = bubble;
    this.xPos = xPos;
    this.yPos = yPos;
  }
  
    
  public void drawBubble(){
    if (bubble.colour!="invisble") {
      if (bubble.colour=="blue")
        fill(#0000FF);
      circle(this.xPos,this.yPos,2*apothem);
    }
  }
  
}
