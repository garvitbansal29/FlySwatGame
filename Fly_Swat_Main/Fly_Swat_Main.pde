//3.0

Food cake;
Fly[] Fly = new Fly[5];
Fly2[] Fly2 = new Fly2[5];
enum gameStatus {Play, SplashScreen, GameOver};
gameStatus currentGameStatus = gameStatus.SplashScreen;
boolean playBtnPressed = false;
void setup()
{
  size (800, 800);
  cake = new Food(300, 300, 10);
  
  for(int i=0; i<Fly.length; i++)
  {
    Fly[i] = new Fly();
  }  
  for(int i=0; i<Fly2.length; i++)
  {
    Fly2[i] = new Fly2();
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
      for (int i = 0; i<Fly.length; i++) // Generate 6 flies
      {
        Fly[i].render();
      }
      for(int i=0; i<Fly2.length; i++)
      {
        Fly2[i].render();
      }
      checkGameOver();
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
  for(int i=0; i<Fly2.length; i++)
  {
    Fly2[i].flyClick(mouseX, mouseY);
  }
}
