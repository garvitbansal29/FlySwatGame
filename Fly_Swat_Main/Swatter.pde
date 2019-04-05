class flyswatter 
{
  PImage swatterImage;
  int imgSize = 50;
  int counter;

  flyswatter()
  {
    swatterImage = loadImage("images/flyswatter.png");
  }
  void render()
  {
    image(swatterImage, mouseX, mouseY, imgSize, imgSize);
  }
}
