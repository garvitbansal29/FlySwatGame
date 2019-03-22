class Fly2 extends Fly
{
  int flyLife;
  Fly2()
  {
    imgSize = 80;
    flyLife = 3;
  }
 //<>//
   @Override void killFly()
   {
     flyLife --;
     imgSize -= 10;
     if (flyLife ==0)
     {
       alive = false;
     }
     
   }
  
}
