public class Bubble {
  
  int RAD=17; // rad of circle, slightly smaller than hexagon
  float APO = sqrt(3)*RAD/2; // apothem of hexagon; radius of circle
  
  color col;
  boolean outline;
  float angle;
  boolean updated = false;
  boolean shot = false;
  boolean inCell = true;
  float xPos;
  float yPos;
  float dx;
  float dy;
  int vel = 11;
  
  public Bubble(color col, boolean outline) {
    this.col = col;
    this.outline = outline;
  }
  
  
  //needs reflector at wall
  public void move(){
    if (shot && !inCell) {
      
      
      //noFill();
      //stroke(0);
      //circle(this.xPos, this.yPos, 2*this.APO);
      
      this.xPos+=this.dx;
      this.yPos+=this.dy;
      
      
      //delay(1000);
      
      if (this.xPos <= 0+RAD || this.xPos >= WIDTH-RAD)
        this.dx=-this.dx;
      
    }
  }
  
  public void drawBubble() {
    if (outline)
      stroke(0);
    else
      noStroke();
    fill(this.col);
    circle(this.xPos,this.yPos,2*APO);
  }
  
  public void shoot() {
    
    if (!this.updated) { // this method of checking arrow angle is eh, can be refactored
      this.inCell=false;
      this.angle = arrow.checkAng; // cant have arrow here
      this.dx = this.vel*cos(this.angle);
      this.dy = this.vel*sin(this.angle);
      arrow.show=false;
      this.shot = true;
      this.updated=true;
    }
    this.move();
    
  }
  public void resetBubble(){
    this.updated=false;
    arrow.show=true;
    this.shot=false;
    this.inCell=true;
  }
  
  
}
