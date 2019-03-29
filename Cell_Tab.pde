public class Cell {
  
  //int radius=17;
  //float apothem = sqrt(3)*radius/2;
  
  Bubble bubble;
  int xPos;
  int yPos;
  
  Cell(Bubble bubble, int xPos, int yPos) {
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
    
    if (bubble.outline) {
      if (bubble.col == INV)
        stroke(0);
        
      else {
        noStroke();
      bubble.drawBubble();
      }
    }
    
    else {
      if (bubble.col != INV)
        noStroke();
        bubble.drawBubble();
    }
    
    
  }
  
  
  
  
}
