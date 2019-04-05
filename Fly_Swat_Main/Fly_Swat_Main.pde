//Master
flyswatter swatter;
Food cake;
mainFly[] Fly = new mainFly[10];
// 4 Different game status 
enum gameStatus {                            
  Play, SplashScreen, GameOver, WinScreen
};
gameStatus currentGameStatus = gameStatus.SplashScreen; // Defaults to splash screen when the game is first started

enum gameLvl {
  lvl1, lvl2, lvl3, lvl4
};
int [] lvlWaveSize = {0, 1, 3, 6, 10}; //an array to initialise number of flies in a lvl. 1st lvl has 1 enemy, second has 2 and so on...
gameLvl currentLvl = gameLvl.lvl1;    //Defaults start at level 1
int points=0; //Keeps tracks of points player gets during the game. 1 point = 1 enemy dead
int waveSize = 0; // initialise wave size at 0

void setup()
{
  size (800, 800);
  cake = new Food(300, 300, 5);  //cake(x, y, NumberofLives) - Player has 5 lives.
  swatter = new flyswatter();

  for (int i=0; i<Fly.length; i++) //All even flies are fly 1 (small flies) and all odd flies are fly 2 (big flies)
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
      noCursor();         //Removes cursor when playing the game. cursor turns into a swatter.    
      cake.render();      //Render cake
      lifeDisplay();      //Displays remaining life of the player
      pointsDisplay();    //Displays points gained by the player
      switch (currentLvl) //Level system based on enums.
      {
      case lvl1:                                   
        {
          displayText("lvl1", 20, width/2, 50);
          waveSize = lvlWaveSize[1];
          if (aliveFlies (waveSize) == 0 && cake.life>0)  //Checks if all flies are dead and player still has a life.
          {
            currentLvl = gameLvl.lvl2;
          }
          break;
        }
      case lvl2:
        {
          displayText("lvl2", 20, width/2, 50);
          waveSize = lvlWaveSize[2];
          if (aliveFlies (waveSize) == 0 && cake.life>0)
          {
            currentLvl = gameLvl.lvl3;
          }
          break;
        }
      case lvl3:
        {
          displayText("lvl3", 20, width/2, 50);
          waveSize = lvlWaveSize[3];
          if (aliveFlies (waveSize) == 0 && cake.life>0)
          {
            currentLvl = gameLvl.lvl4;
          }
          break;
        }
      case lvl4:
        {
          displayText("lvl4", 20, width/2, 50);
          waveSize = lvlWaveSize[4];
          if (aliveFlies (waveSize) == 0 && cake.life>0)
          {
            currentLvl = gameLvl.lvl4;
            currentGameStatus = gameStatus.WinScreen; //If player beats lvl 4, they win the game.
          }
          break;
        }
      }
      for (int i = 0; i<waveSize; i++) // only Render the necessary number of flies. 
      {
        Fly[i].render();
      }
      checkGameOver(); //Game over when all lives are lost
      swatter.render(); //
      break;
    }

  case SplashScreen:
    {
      splashScreen();
      break;
    }
  case GameOver:          // Displays "GAME OVER" on the screen
    {
      cursor();
      displayText("GAME OVER", 50, height/2, width/2);
      break;
    }
  case WinScreen:        //Displays "You Win!!!" on the screen
    {
      cursor();
      displayText("You Win!!!", 50, width/2, height/2);
    }
  }
}

void displayText(String textToDisplay, int size, int x, int y)
{
  fill(0);
  textSize(size);
  textAlign(CENTER);
  text(textToDisplay, x, y);
}

void splashScreen()      //Makes the splash screen
{
  int playBtnX, playBtnY;
  int playBtnLength = 300;
  int playBtnHeight = 75;
  playBtnX = (width-playBtnLength)/2;  //generate X-coordinate based on the canvas and btn size
  playBtnY = (height-playBtnHeight)/2; //generate Y-coordinate based on the canvas and btn size
  displayText("Fly Swat", 70, (width/2), height/4); //Display the name of the game
  fill(255);
  if (createBtn(playBtnX, playBtnY, playBtnLength, playBtnHeight, "Play", 30, width/2, playBtnY+50)) //creates a btn and triggers play game when it is pressed.
    currentGameStatus = gameStatus.Play;
}

boolean createBtn(int x, int y, int btnLength, int btnHeight, String textToDisplay, int textSize, int textX, int textY ) //Simple funciton to create a btn. 
{
  rect(x, y, btnLength, btnHeight);
  displayText(textToDisplay, textSize, textX, textY);
  if (mousePressed==true)
  {
    if (mouseX>=x && mouseX<=x+btnLength && mouseY>=y && mouseY<=y + btnHeight) //checks if user has clicked the play button
    {
      return true;
    }
  }
  return false;
}

int aliveFlies (int waveSize)           //Checks how many flies are alive any moment in the game. Helps to progress to further levels.
{
  int fullFlies = 0;  
  int deadFlyCount = 0;
  for (int i = 0; i<this.waveSize; i++) // Generate 6 flies
  {
    if (Fly[i].full)
      fullFlies++;
    if (!Fly[i].alive)
      deadFlyCount++;
  }
  int totalFlies = waveSize - fullFlies - deadFlyCount;
  return totalFlies;
}

void checkGameOver()  //Checks if game is over when player loses all the lives
{
  if (cake.life==0)
  {
    currentGameStatus = gameStatus.GameOver;
  }
}

void lifeDisplay()  //Displays how many lives player has left
{
  textSize(30);
  textAlign(RIGHT);
  text("Life: "+cake.life, width*3/4, 50);
  fill(0);
}

void mouseClicked() //When mouse click is triggered it checks if the player clied the enemy flies to kill them.
{
  for (int i = 0; i<waveSize; i++) // Generate 6 flies
  {
    Fly[i].flyClick(mouseX, mouseY);
  }
}

void pointsDisplay()
{
  textSize(30);
  textAlign(LEFT);
  text("Points: "+points, width/6, 50);
  fill(0);
}
