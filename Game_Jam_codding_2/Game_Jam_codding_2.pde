import processing.video.*;
import processing.sound.*;

//Player and ball Positions
PVector playerPos = new PVector(400, 200);
PVector ballPos= new PVector (-1000, -1000);
//image of player, ball, background, rophy
PImage ball;
PImage player;
PImage background;
PImage trophy;
//score 
int score = 0;
//direction
PVector dir = new PVector (0, 0);
//sound1
SoundFile sound;
String path;
//sound3
SoundFile winning;
String path1;
//screen
int screen = 1;
//video
Movie myMovie;
//speed
int speed = 4;
void setup()
{
  //size
  size (600, 600);
  //images
  ball = loadImage("ball.png");
  player = loadImage("Player.png");
  background = loadImage("Background.png");
  trophy = loadImage("winner.png");
  //sound
  path = sketchPath("sound.mp3");
  sound = new SoundFile(this, path);
  path1 = sketchPath("winning.mp3");
  winning = new SoundFile(this, path1);
  winning.loop();
  winning.amp(0);
  //video
  myMovie = new Movie(this, "basket.mp4"); 
}


void draw()
{
  if (screen == 1)
  {
    //background basket ball court
    background.resize(600, 600);
    image(background, 0, 0);
    //score 
    textSize(30);
    text(score, 500, 40);
    //ball
    ball.resize(30, 30);
    image(ball, ballPos.x, ballPos.y);
    // Basket ball player 
    player.resize(150, 250);
    image(player, playerPos.x, playerPos.y);
    //ball direction
    ballPos.add(dir);
    dir.add(new PVector(0, 0.03));

    //player movement
    if (keyPressed)
    {
      if (key == 'a')
      {
        playerPos.x = playerPos.x -2;
      }
      if (key == 'd')
      {
        playerPos.x = playerPos.x +2;
      }
    }
    if (playerPos.x > 450)
    {
      playerPos.x = playerPos.x -2;
    }
    if (playerPos.x < 200)
    {
      playerPos.x = playerPos.x +2;
    }    
    //
    if (ballPos.x < 170)
    {
      if (ballPos.x > 130)
      {
        if (ballPos.y < 150)
        {
          if (ballPos.y > 120)
          {
            sound.play();
            print("basket");
            ballPos.x = 10000;
            score = score +1;
          }
        }
      }
    }
    //rect(60, 50, 70, 100);
    //backboard
    if (ballPos.x > 60)
    {
      if (ballPos.x < 130)
      {
        if (ballPos.y > 50)
        {
          if (ballPos.y < 150)
          {
            print("backboard");
            dir.mult(-0.3);
            ballPos.x = ballPos.x +5;
          }
        }
        
      }
    }
    //score 
    if (score == 5)
    {
      screen = 2;
    }
  } 
  //winning screen
  if (screen == 2)
  {
    winning.amp(1);
    background (255,255,255);
    fill(255,0,0);
    textSize(60);
    text ("YOU WON!!!", 100, 70);
   //video,loop and play
   image(myMovie, 100, 250);
    myMovie.loop();
    //image
    trophy.resize(100,200);
    image(trophy, 350, 150);
  }
}

void mouseReleased()
{
  //ball speed, gravity, making it so that the ball go at the mouses position,
  //direction, etc
  ballPos = playerPos.copy();
  PVector mouse = new PVector(mouseX, mouseY);
  dir = mouse.sub(playerPos);
  dir.normalize();
  dir.mult(speed);
}
void movieEvent(Movie m) 
{
  m.read();
}
