Food cake;
Fly[] Fly = new Fly[6];
enum gameStatus {Play, GameOver, Pause, Stop, SplasScreen};
gameStatus currentGameStatus = gameStatus.Play;
int mouseClickX;
int mouseClickY;
void setup()
{
  size (800, 800);
  cake = new Food(300, 300, 10);
  
  for(int i=0; i<Fly.length; i++)
  {
    Fly[i] = new Fly();
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
      for (int i = 0; i<Fly.length; i++) // Generate 6 flies
      {
        Fly[i].render();
        Fly[i]. flyClick();
      }
    }
    case GameOver:
    {
    }
  }
}
void mouseClicked()
{
  mouseClickX = mouseX;
  mouseClickY = mouseY;
}
