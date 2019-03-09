class Fly2 extends Fly
{
  Fly2()
  {
    this.imgSize = 80;
    this.flyLife = 3;
  }
 @Override void flyClick(int mouseClickX, int mouseClickY)
  {
    if ((mouseClickX>=x) && (mouseClickX<=x+imgSize )&& (mouseClickY>=y) && (mouseClickY<=y+imgSize))
    {
      if (flyLife ==1)
      {
        alive = false;
      }
      flyLife -=1;
      imgSize -=10;
    }
  }
  
}
