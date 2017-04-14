

float move = 0;
int black = 255;
boolean TITLE;
boolean blackOut = false;



ObjectMoner moner;
ObjectStage stage;

int score = 0,highscore = 0;


void setup() {
  imageMode(CENTER);   
  frameRate(30);
  size(450, 300, JAVA2D);
  noCursor();

  TITLE = true;
  stage = new ObjectStage();
  
}

void title() {


  final PImage title   = loadImage("title.png");
  final PImage cts = loadImage("cts.png");


  /*
  if(move > 100)blackOut = true;
   
   if(blackOut == true){
   black--;
   background(black, black, black , 10);
   }
   */



  image(title, 225, 100);
  if (frameCount % 50 > 10)image(cts, 225, 200);
  if(highscore < score)highscore = score; 
  textSize(16);
  fill(230, 230, 230); 
  text("HighScore: ", 10, 20);
  for (int i = 10; i >= 0; i--) {
    if (highscore >= pow(10, i)) {
      text(highscore, 100 + i * 1, 20);
      break;
    }
  }

  if (mousePressed) {
    move = 0;
    score = 0;
    moner = new ObjectMoner();
    stage = new ObjectStage();
    TITLE = false;
  }
}

void game() {
  score++;
  stage.go(moner);
  moner.go(stage);
  
  textSize(16);
  fill(230, 230, 230); 
  text("Score: ", 10, 20);
  for (int i = 10; i >= 0; i--) {
    if (score >= pow(10, i)) {
      text(score, 60 + i * 1, 20);
      break;
      
    }
  }
  
  if (moner.loca_floor >= stage.data_floor.length - 10) {
    stage = new ObjectStage(); 
    moner.x = 0;
  }
}


void draw() {
  final PImage cursor  = loadImage("cursor.png");
  background(10, 10, 10);

  
  if (TITLE) {
    title();
  } else if (!TITLE) {
    game();
    tint(255, 255, 255, 150);
  }

  image(cursor, mouseX, mouseY);
  noTint();
}

void stop()
{
  super.stop();
}