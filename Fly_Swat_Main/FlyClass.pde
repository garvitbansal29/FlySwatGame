class mainFly
{
  int x, y;
  int dx, dy;
  PImage fly1, fly2, fly3, fly4, fly5, fly6, fly7;
  PImage die1, die2, die3, die4, die5, die6, die7;  
  int counter = 0;
  int counte =0;
  int imgSize;
  boolean alive;
  boolean full;
  int decSize;
  int [] speed = {1, 10}; // 2 speeds, 1st for speed when alive, second when fly dies.

  mainFly()
  {
    setXandY();
    fly1 = loadImage("images/BetterFlies/1.png");
    fly2 = loadImage("images/BetterFlies/2.png");
    fly3 = loadImage("images/BetterFlies/3.png");
    fly4 = loadImage("images/BetterFlies/4.png");
    fly5 = loadImage("images/BetterFlies/5.png");
    fly7 = loadImage("images/Fly/FlyDie.png"); 
    die1 = loadImage("images/BetterFlies/Die/1.png");
    die2 = loadImage("images/BetterFlies/Die/2.png");
    die3 = loadImage("images/BetterFlies/Die/3.png");
    die4 = loadImage("images/BetterFlies/Die/4.png");
    die5 = loadImage("images/BetterFlies/Die/5.png");
    die6 = loadImage("images/BetterFlies/Die/6.png");
    die7 = loadImage("images/BetterFlies/Die/7.png");
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
    while ((x2>cake.x-bufferDist) && (x<cake.x+cake.size+bufferDist) &&(y2>cake.y-bufferDist)&&(y<cake.y+cake.size+bufferDist)); //fly is not inside the cake when it is created
  }  

  void flyAnimation() //creates the fly movement animation
  {
    if (counter>=0 && counter<=9) {
      image(fly1, x, y, imgSize, imgSize);
    } else if (counter>=10 && counter<=19) {
      image(fly2, x, y, imgSize, imgSize);
    } else if (counter>=20 && counter<=29) {
      image(fly3, x, y, imgSize, imgSize);
    } else if (counter>=30 && counter<=39) {
      image(fly4, x, y, imgSize, imgSize);
    } else if (counter>=40 && counter<=49) {
      image(fly5, x, y, imgSize, imgSize);
    } else if (counter>49) {
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
    } else if (!alive)
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
    int q=5;
    if (counte>=0 && counte<5) {
      image(die1, x, y, imgSize, imgSize);
    } else if (counte>=5 && counte<10) {
      image(die2, x, y, imgSize, imgSize);
    } else if (counte>=10 && counte<15) {
      image(die3, x, y, imgSize, imgSize);
    } else if (counte>=15 && counte<20) {
      image(die4, x, y, imgSize, imgSize);
    } else if (counte>=20 && counte<25) {
      image(die5, x, y, imgSize, imgSize);
    } else if (counte>=25 && counte<30) {
      image(die6, x, y, imgSize, imgSize);
    } else if (counte>30 && counte<35){
      image(die7, x, y, imgSize, imgSize);
    }
    counte +=1;
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
    points++;
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
    if (alive)
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
    if (full)
    {
      flyFull();
    }
  }
}
