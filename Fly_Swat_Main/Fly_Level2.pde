class Fly2 extends mainFly // fly 2 is bigger, and needs 3 clicks to die. Also grows smaller after every click.
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
