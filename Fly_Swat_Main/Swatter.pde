class flyswatter 
{
  int x, y;
  PImage swatterImage;
  int imgSize = 50;
  int counter;
  
  flyswatter(int x, int y)
  {
    this.x = x;
    this.y = y;
    swatterImage = loadImage("images/flyswatter.png");
  }
  void render()
  {
    noCursor();
    image(swatterImage, mouseX, mouseY,imgSize ,imgSize);
  }
}