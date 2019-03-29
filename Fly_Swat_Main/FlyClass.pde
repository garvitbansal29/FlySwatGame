class mainFly
{
  int x, y;
  int dx, dy;
  PImage fly1, fly2, fly3, fly4, fly5, fly6, fly7;
  int counter = 0;
  int imgSize;
  boolean alive;
  boolean full;
  int decSize;
  int [] speed = {1, 10}; // 2 speeds, 1st for speed when alive, second when fly dies.
  
  mainFly()
  {
    setXandY();
    fly1 = loadImage("images/Fly/fly_1.png");
    fly2 = loadImage("images/Fly/fly_2.png");
    fly3 = loadImage("images/Fly/fly_3.png");
    fly4 = loadImage("images/Fly/fly_4.png");
    fly5 = loadImage("images/Fly/fly_5.png");
    fly6 = loadImage("images/Fly/fly_6.png");
    fly7 = loadImage("images/Fly/FlyDie.png"); 
    alive = true;
    full = false;
  }
    
  void setXandY()  
  {
    int bufferDist = 100;
    int x2, y2;
    do 
    {
      x = int(random(width-imgSize));
      y = int(random(height - imgSize));
      x2 = x + imgSize;
      y2 = y + imgSize;
    }
    while((x2>cake.x-bufferDist) && (x<cake.x+cake.size+bufferDist) &&(y2>cake.y-bufferDist)&&(y<cake.y+cake.size+bufferDist)); //fly is not inside the cake when it is created
  }  
  
  void flyAnimation() //creates the fly movement animation
  {
    if (counter>=0 && counter<=9){
      image(fly1,x,y,imgSize,imgSize); 
    }
    else if (counter>=10 && counter<=19){
      image(fly2,x,y,imgSize,imgSize); 
    }
    else if (counter>=20 && counter<=29){
      image(fly3,x,y,imgSize,imgSize);  
    }
    else if (counter>=30 && counter<=39){
      image(fly4,x,y,imgSize,imgSize);  
    }
    else if (counter>=40 && counter<=49){
      image(fly5,x,y,imgSize,imgSize);  
    }
    else if (counter>49){
     counter=0; 
    }
    counter +=1;
  }
 
  void moveFly()
  {
    int flySpeed;
    setDxDy();
    if (alive)
      flySpeed = speed[0];
    else 
      flySpeed = speed[1];
    x+=dx*flySpeed;
    y+=dy*flySpeed;
  }  
  
  void setDxDy()
  {
    int flyCenterX = x+(imgSize/2);
    int flyCenterY = y+(imgSize/2);
    int cakeCenterX = cake.x+(cake.size/2);
    int cakeCenterY = cake.y+(cake.size/2);
    int tx=0;
    int ty=0;
    
    if (alive)
    {
      tx = cakeCenterX - flyCenterX;
      ty = cakeCenterY - flyCenterY;
    }
    else if (!alive)
    {
      tx = 1;
      ty = height+50 - flyCenterY;
    }
    double dist = Math.sqrt((tx*tx)+(ty*ty));
    
    dx = int(Math.round(tx/dist*1)); 
    dy = int(Math.round(ty/dist*1));
  }
  
  
  void flyDieingAnimation()
  {
    image(fly7, x, y, imgSize, imgSize);   
  }

  void flyClick(int mouseClickX, int mouseClickY)
  {
    int swatterSize = swatter.imgSize;
    if ((mouseClickX+swatterSize>=x) && (mouseClickX<=x+imgSize )&& (mouseClickY+swatterSize>=y) && (mouseClickY<=y+imgSize))
    {
      killFly();
    }
  }
  
  void killFly()
  {
    alive = false;
  }
  
  void flyEatFood() // check if fly reached food
  {
    if ((x+50 >= cake.x) && (x <=cake.x+100))
      if ((y+50 >= cake.y) && (y <=cake.y+100))
    {
      full = true;
      cake.cakeLifeLost();
    }
  }
  
  void flyFull()
  {
    x = width;
    y = height;
  }
 
  void render()
  {
    if(alive)
    {
      flyEatFood();
      flyAnimation();
      moveFly();
    }
    if (!alive)
    {
      moveFly();
      flyDieingAnimation();
    }
    if(full)
    {
      flyFull();      
    }
  }  
}
