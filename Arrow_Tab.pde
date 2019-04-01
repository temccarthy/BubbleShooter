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
  
  Arrow(){
    this.show = true;
  }
  
  public void drawArrow() {
    if (this.show) {
      ang=atan2(mouseY-(gRAD+1.5*gRAD*16), mouseX-(gAPO+2*gAPO*8));
      if (ang > -PI+.2 && ang < 0-.2)
        checkAng = ang;
      stroke(131,131,131);
      fill(131,131,131);
      line((gAPO+2*gAPO*8), (gRAD+1.5*gRAD*16), (gAPO+2*gAPO*8)+length*cos(checkAng), (gRAD+1.5*gRAD*16)+length*sin(checkAng));
      triangle((gAPO+2*gAPO*8)+length*cos(checkAng), (gRAD+1.5*gRAD*16)+length*sin(checkAng),
        (gAPO+2*gAPO*8)+(length-arrowHeadLength)*cos(checkAng+arrowHeadAngle), (gRAD+1.5*gRAD*16)+(length-arrowHeadLength)*sin(checkAng+arrowHeadAngle),
        (gAPO+2*gAPO*8)+(length-arrowHeadLength)*cos(checkAng-arrowHeadAngle), (gRAD+1.5*gRAD*16)+(length-arrowHeadLength)*sin(checkAng-arrowHeadAngle));
    }
  }
  
}
