class mainFly
{
  int x, y;
  int dx, dy;
  PImage fly1, fly2, fly3, fly4, fly5;   //Images for when flies are moving 
  PImage die1, die2, die3, die4, die5, die6, die7;  //Images to animate dieing flies
  int counter = 0; //Counter 1 for first set of animation
  int counter2 = 0; //counter 2 for second set of animations
  int imgSize; 
  boolean alive = true; //Flies are alive by default when they are created
  boolean full = false; //Flies are not full by defaut when they are created, ie they have not eaten cake.
  int [] speed = {1, 5}; // 2 speeds, 1st for speed when alive, second when fly dies.

  mainFly()
  {
    setXandY();  
    fly1 = loadImage("images/BetterFlies/1.png");
    fly2 = loadImage("images/BetterFlies/2.png");
    fly3 = loadImage("images/BetterFlies/3.png");
    fly4 = loadImage("images/BetterFlies/4.png");
    fly5 = loadImage("images/BetterFlies/5.png");

    die1 = loadImage("images/BetterFlies/Die/1.png");
    die2 = loadImage("images/BetterFlies/Die/2.png");
    die3 = loadImage("images/BetterFlies/Die/3.png");
    die4 = loadImage("images/BetterFlies/Die/4.png");
    die5 = loadImage("images/BetterFlies/Die/5.png");
    die6 = loadImage("images/BetterFlies/Die/6.png");
    die7 = loadImage("images/BetterFlies/Die/7.png");
  }

  void setXandY()  //Generates initialising position for the flies
  {
    int bufferDist = 100; //a buffer distance. so flies wont be generated too close to the cake. Gives player extra time to react.
    int x2, y2;
    do 
    {
      x = int(random(width - imgSize));
      y = int(random(height - imgSize));
      x2 = x + imgSize;
      y2 = y + imgSize;
    }
    while ((x2>cake.x-bufferDist) && (x<cake.x+cake.size+bufferDist) &&(y2>cake.y-bufferDist)&&(y<cake.y+cake.size+bufferDist)); //fly is not inside the cake when it is created. and still with in the canvas
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
  void setDxDy()  //Set the dx and dy for fly to move. based on if fly is alive or dead.
  {
    int flyCenterX = x+(imgSize/2);
    int flyCenterY = y+(imgSize/2);
    int cakeCenterX = cake.x+(cake.size/2);
    int cakeCenterY = cake.y+(cake.size/2);
    int tx=0;
    int ty=0;

    if (alive)  //if fly is alive the target is the centre of the cake.
    {
      tx = cakeCenterX - flyCenterX;
      ty = cakeCenterY - flyCenterY;
    } else if (!alive) // if fly is dead the target is bottom of the canvas  
    {
      tx = 1;
      ty = height+50 - flyCenterY;
    }

    double dist = Math.sqrt((tx*tx)+(ty*ty));

    dx = int(Math.round(tx/dist*1)); 
    dy = int(Math.round(ty/dist*1));
  }

  void moveFly() //Moves fly based on the dy and dx set
  {
    int flySpeed;
    setDxDy();
    if (alive)
      flySpeed = speed[0]; //alive speed - currently set to 1
    else 
    flySpeed = speed[1]; //dead speed - currently set to 5
    x+=dx*flySpeed;
    y+=dy*flySpeed;
  }  

  void flyDieingAnimation() // second set of animation, performed when fly dies
  {
    if (counter2>=0 && counter2<5) {
      image(die1, x, y, imgSize, imgSize);
    } else if (counter2>=5 && counter2<10) {
      image(die2, x, y, imgSize, imgSize);
    } else if (counter2>=10 && counter2<15) {
      image(die3, x, y, imgSize, imgSize);
    } else if (counter2>=15 && counter2<20) {
      image(die4, x, y, imgSize, imgSize);
    } else if (counter2>=20 && counter2<25) {
      image(die5, x, y, imgSize, imgSize);
    } else if (counter2>=25 && counter2<30) {
      image(die6, x, y, imgSize, imgSize);
    } else if (counter2>30 && counter2<35) {
      image(die7, x, y, imgSize, imgSize);
    }
    counter2 +=1;
  }

  void flyClick(int mouseClickX, int mouseClickY) //Checks if fly is clicked or not. 
  {
    int swatterSize = swatter.imgSize;
    if ((mouseClickX+swatterSize>=x) && (mouseClickX<=x+imgSize )&& (mouseClickY+swatterSize>=y) && (mouseClickY<=y+imgSize) && (alive)) //check is mouse is in the hitbox range and if the fly is alive. player is not able to hit dead fly for points.
    {
      killFly();
    }
  }

  void killFly() // set fly alive to false (kills it) and increments the points.
  {
    alive = false;
    incrementPoints();
  }

  void incrementPoints()
  {
    points++;
  }

  boolean flyEatFood() // check if fly reached food
  {
    if ((x+50 >= cake.x) && (x <=cake.x+100))
      if ((y+50 >= cake.y) && (y <=cake.y+100))
      {
        return true;
      }
    return false;
  }

  void whenFlyEatFood()
  {
    if (flyEatFood())
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
    if (alive) //Does the following when fly is alive 
    {
      whenFlyEatFood();
      flyAnimation();
      moveFly();
    }
    if (!alive) // does the following when fly is dead
    {
      moveFly();
      flyDieingAnimation();
    }
    if (full) // does the following when fly is full, ie has eaten the cake.
    {
      flyFull();
    }
  }
}
