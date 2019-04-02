public class Cell {
  
  Bubble bubble;
  float xPos;
  float yPos;
  
  Cell(Bubble bubble, float xPos, float yPos) {
    this.bubble = bubble;
    this.xPos = xPos;
    this.yPos = yPos;
  }
  
  // maybe can be shortened
  public void drawCell(){
    
  //need to slowly move bubble when it collides with cell
    if (bubble.inCell) {
      
      bubble.xPos = this.xPos;
      bubble.yPos = this.yPos;
      
    }
    
    if (bubble.outline)
      bubble.drawBubble();
    else {
      if (bubble.col != INV)
        bubble.drawBubble();
    }
  }
  
  
}
