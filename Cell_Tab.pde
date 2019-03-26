public class Cell {
  
  int radius=17;
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
    if (bubble.outline)
      stroke(0);
    else
      noStroke();
    fill(bubble.col);
    circle(this.xPos,this.yPos,2*apothem);
    
  }
  
}
