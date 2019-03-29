public class Bubble {
  
  int RAD=17; // rad of circle, slightly smaller than hexagon
  float APO = sqrt(3)*RAD/2; // apothem of hexagon; radius of circle
  
  color col;
  boolean outline;
  float angle;
  boolean shot;
  boolean inCell;
  float xPos;
  float yPos;
  
  
  /*
  dont need 2 different bubbles - just dont use this.x and this.y when in cell/grid
  BUT if you do that, then when a bubble is in a cell, you have 2 positions that are the same: cell and bubble - redundant
  */
  
  public Bubble(color col, boolean outline) {
    this.col = col;
    this.outline = outline;
    this.shot=false;
    this.inCell=true;
  }
  
  
  //needs reflector at wall
  public void move(){
    if (shot && !inCell) {
      int vel = 3;
      
      float dx= vel*cos(this.angle);
      float dy= vel*sin(this.angle);
      
      this.xPos+=dx;
      this.yPos+=dy;
      
    }
  }
  
  public void drawBubble() {
    fill(this.col);
    circle(this.xPos,this.yPos,2*APO);
  }
  
  public void shoot() {
    this.inCell=false;
    this.angle = arrow.ang; // cant have arrow here
    this.shot = true;
    this.move();
  }
  
  
}
