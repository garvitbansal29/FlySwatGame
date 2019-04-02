//Add levels
flyswatter swatter;
Food cake;
mainFly[] Fly = new mainFly[5];
enum gameStatus {Play, SplashScreen, GameOver};
gameStatus currentGameStatus = gameStatus.Play;
enum gameLvl {lvl1, lvl2};
gameLvl currentLvl = gameLvl.lvl1;
boolean playBtnPressed = false;
int points=0;
int size = 0;
void setup()
{
  
  size (800, 800);
  cake = new Food(300, 300, 10);
  
  swatter = new flyswatter(500, 500);
  for(int i=0; i<Fly.length; i++)
  {
    if (i%2 == 0)
      Fly[i] = new Fly1();
    else
      Fly[i] = new Fly2();
  }
}

void draw()
{
  background(255);
  switch (currentGameStatus)
  {
    case Play:
    {
      cake.render();
      lifeDisplay();
      pointsDisplay();
      for (int i = 0; i<Fly.length; i++) // Generate 6 flies
      {
        Fly[i].render();
      }
      checkGameOver();
      swatter.render();
      break;
    }
    case SplashScreen:
    {
      splashScreen();
      break;
    }
    case GameOver:
    {
      textSize(50);
      text("Game Over",(width/2)-100,(height/2)-50);
      fill(0);
      break;
    }
  }
}

void splashScreen()
{
  int playBtnX, playBtnY;
  int playBtnLength = 300;
  int playBtnHeight = 75;
  playBtnX = (width-playBtnLength)/2;  //generate X-coordinate based on the canvas and btn size
  playBtnY = (height-playBtnHeight)/2; //generate Y-coordinate based on the canvas and btn size
  fill(0);
  textSize(70);
  text("Fly Swat",(width/2)-130,height/4);  //Display the name of the game
  
  fill(255);
  rect(playBtnX,playBtnY,playBtnLength,playBtnHeight);  //Create the rectangle which acts like a button
  if (mousePressed==true)
  {
    if (mouseX>=playBtnX && mouseX<=playBtnX+playBtnLength && mouseY>=playBtnY && mouseY<=playBtnY + playBtnHeight) //checks if user has clicked the play button
    {
      currentGameStatus = gameStatus.Play;
    }
  }
  fill(0);
  textSize(30);
  text("Play", playBtnX+120,playBtnY+50); // Display the text "Play" inside the button
}

void checkGameOver()
{
  if (cake.life==0)
  {
    currentGameStatus = gameStatus.GameOver;
  }
}

void lifeDisplay()
{
  textSize(30);
  text("Life: "+cake.life,500,50);
  fill(0);   
}

void mouseClicked()
{
  for (int i = 0; i<Fly.length; i++) // Generate 6 flies
  {
    Fly[i].flyClick(mouseX, mouseY);
  }
}

void pointsDisplay()
{
  textSize(30);
  text("Points: "+points,50,50);
  fill(0);   
}
