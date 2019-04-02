color RED = color (255,0,0,255);
color YEL = color (240,230,0,255);
color GRE = color (0,255,0,255);
color CYA = color (0,255,255,255);
color BLU = color (0,0,255,255);
color PUR = color (127,0,255,255);
color INV = color (1,1,1,0);



public class Colour {
  
  //color[] colList = {RED,YEL,GRE,CYA,BLU,PUR} ;
  ArrayList<String> colList2 = new ArrayList<String>();
  int numColors=6;
  
  
  String hRED = hex(color (255,0,0,255));
  String hYEL = hex(color (240,230,0,255));
  String hGRE = hex(color (0,255,0,255));
  String hCYA = hex(color (0,255,255,255));
  String hBLU = hex(color (0,0,255,255));
  String hPUR = hex(color (127,0,255,255));
  String hINV = hex(color (1,1,1,0));
  
  
  
  Colour(){
    
    colList2.add(hRED);colList2.add(hYEL);colList2.add(hGRE);colList2.add(hCYA);colList2.add(hBLU);colList2.add(hPUR);
  }
  
  
  
  public color randomColour(){
    int rand = int(random(0,numColors));
    
    /*
    if (rand == 0)
      return colList[0];
    if (rand == 1)
      return colList[0];
    if (rand == 2)
      return colList[0];
    if (rand == 3)
      return colList[0];
    if (rand == 4)
      return colList[0];
    if (rand == 5)
      return colList[0];
      */
    //return colList[rand];
    return unhex(this.colList2.get(rand));
  }
  
  public void removeCol(color col){
    //int i=colList.indexOf(col);
    colList2.remove(col);
  }
}
