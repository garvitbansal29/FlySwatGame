class Food //Food is the cake
{
  int x;
  int y;
  int size = 150;
  PImage cakeImg;
  int life; //Cake has lives (player life)
  Food (int x, int y, int life)
  {
    this.life = life;
    this.x = x;
    this.y = y;
    cakeImg = loadImage("images/cake.png");
  }
  void render()
  {
    image (cakeImg, x, y, size, size);
  }
  void cakeLifeLost() //lower the life of cake when fly eats it
  { 
    life -=1;
  }
}
