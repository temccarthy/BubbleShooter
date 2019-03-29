public class Bubble {
  
  int RAD=17; // rad of circle, slightly smaller than hexagon
  float APO = sqrt(3)*RAD/2; // apothem of hexagon; radius of circle
  
  color col;
  boolean outline;
  float angle;
  boolean updated;
  boolean shot;
  boolean inCell;
  float xPos;
  float yPos;
  float dx;
  float dy;
  int vel = 5;
  
  
  public Bubble(color col, boolean outline) {
    this.col = col;
    this.outline = outline;
    this.shot=false;
    this.inCell=true;
    this.updated=false;
  }
  
  
  //needs reflector at wall
  public void move(){
    if (shot && !inCell) {
      this.xPos+=this.dx;
      this.yPos+=this.dy;
      
      
      if (this.xPos <= 0+RAD || this.xPos >= WIDTH-RAD)
        this.dx=-this.dx;
      
    }
  }
  
  public void drawBubble() {
    //System.out.println(arrow.checkAng);
    fill(this.col);
    circle(this.xPos,this.yPos,2*APO);
  }
  
  public void shoot() {
    this.inCell=false;
    if (!this.updated) // this method of checking arrow angle is eh, can be refactored
      this.dx = this.vel*cos(this.angle);
      this.dy = this.vel*sin(this.angle);
      this.angle = arrow.checkAng; // cant have arrow here
      arrow.show=false;
      this.updated=true;
      System.out.println(updated);
    this.shot = true;
    
    this.move();
  }
  
  
}
