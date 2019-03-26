color RED = color (255,0,0);
color YEL = color (240,230,0);
color GRE = color (0,255,0);
color CYA = color (0,255,255);
color BLU = color (0,0,255);
color PUR = color (127,0,255);
color INV = color (0,0,255,0);

public class Colour {
  
  Colour(){}
 
  public color randomColour(){
    int rand = int(random(0,6));
    //change back colors
    if (rand == 0)
      return RED;
    if (rand == 1)
      return YEL;
    if (rand == 2)
      return GRE;
    if (rand == 3)
      return CYA;
    if (rand == 4)
      return BLU;
    else
      return PUR;
  }
}
