public class Arrow {
  boolean show;
  
  Arrow(){
    this.show = true;
  }
  
  /* TODO
  - length of line consistent
  - limit to angle
  - arrow heads
  */
  
  public void drawArrow(){
    if (this.show) {
      stroke(131,131,131);
      line(int(apothem+2*apothem*8), int(radius+1.5*radius*16), mouseX, mouseY);
    }
  }
  
}
