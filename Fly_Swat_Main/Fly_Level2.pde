class Fly2 extends mainFly
{
  int flyLife;
  Fly2()
  {
    imgSize = 80;
    flyLife = 3;
  }
  @Override void killFly()  //<>//
  {
    flyLife --;
    if (flyLife ==0)
    {
      alive = false;
      incrementPoints();
    }
    imgSize -= 10;
  }
}
