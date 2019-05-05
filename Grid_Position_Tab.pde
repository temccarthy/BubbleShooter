public class GridPos {
  int x;
  int y;
  
  GridPos(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  public boolean equals(Object o){
    GridPos aPos = (GridPos) o;
    return (aPos.x == this.x && aPos.y == this.y);
  }
  
  
}
