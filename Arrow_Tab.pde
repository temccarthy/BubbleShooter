public class Arrow {
  boolean show;
  int length = 60;
  float ang;
  float checkAng;
  int arrowHeadLength=6;
  float arrowHeadAngle=.1;
  
  Bubble aBubble;
  //float RAD = aBubble.RAD;
  //float APO = aBubble.APO;
  
  int RAD=18;
  float APO = sqrt(3)*RAD/2;
  
  Arrow(){
    this.show = true;
  }
  
  public void drawArrow() {
    if (this.show) {
      ang=atan2(mouseY-(RAD+1.5*RAD*16), mouseX-(APO+2*APO*8));
      if (ang > -PI+.2 && ang < 0-.2)
        checkAng = ang;
      stroke(131,131,131);
      fill(131,131,131);
      line((APO+2*APO*8), (RAD+1.5*RAD*16), (APO+2*APO*8)+length*cos(checkAng), (RAD+1.5*RAD*16)+length*sin(checkAng));
      triangle((APO+2*APO*8)+length*cos(checkAng), (RAD+1.5*RAD*16)+length*sin(checkAng),
        (APO+2*APO*8)+(length-arrowHeadLength)*cos(checkAng+arrowHeadAngle), (RAD+1.5*RAD*16)+(length-arrowHeadLength)*sin(checkAng+arrowHeadAngle),
        (APO+2*APO*8)+(length-arrowHeadLength)*cos(checkAng-arrowHeadAngle), (RAD+1.5*RAD*16)+(length-arrowHeadLength)*sin(checkAng-arrowHeadAngle));
    }
  }
  
}
