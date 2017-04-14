public class ObjectMoner {

  boolean KUCHU, FALL, DIE;
  float scrx, scry;
  float x, y;


  float speed, fall_speed;
  int loca_floor;
  float yGround;

  PImage pid;

  final PImage moner_walk[]   = {
    loadImage("walk_01.png"), 
    loadImage("walk_02.png")
  }; 


  ObjectMoner() {
      FALL = false;
      KUCHU = false;
      DIE = false;
      
      scrx = 225;
      speed = 20;
      x = 0;
      y = 0;
      
  }

  private void fly() {

    if (frameCount % 1 == 0) {
      y = y - speed;
      speed -= 1.5;
    }
    if (speed < 0) {
      fall_speed = speed;
      FALL = true;
      KUCHU = false;

      speed = 20;
    }

    pid = moner_walk[1];
  }


  private void fall() {

    if (frameCount % 1 == 0) {
      y = y - fall_speed;
      fall_speed -= 1.5;

      if (y > yGround) {
        FALL= false;
      }
    }

    pid = moner_walk[0];
  }

  private void getLocation() {
    for (int i = 0; i < stage.data_floor.length; i++) {
      if (scrx >= 22.5 + 45 * i - x * 2 - 22.5 && scrx < 22.5 + 45 * i - x * 2 + 22.5) {
        loca_floor = i;
      }
    }
  }


  private void getGround() {
    if (stage.data_floor[loca_floor] == 0)yGround = 0;
    else if (stage.data_floor[loca_floor] == 2)yGround = -72;
    else yGround = 500;
  }

  private void changeMove() {
    if (KUCHU)fly();
    else if (FALL)fall();

    else if (y < yGround && !FALL) {
      fall();
    } 
    
    else if (!DIE) {
      fall_speed = 0;
      
      y = yGround;

      if (frameCount % 5 == 0) pid = moner_walk[1];
      else pid = moner_walk[0];

    }
  }

  private void getMouse() {
    if (mousePressed && !KUCHU && !FALL && stage.data_floor[loca_floor] != 1){
      KUCHU = true;
 
    }
    
    if (mouseX != scrx) {
      if (mouseX < scrx)scrx-= 3;
      if (mouseX > scrx)scrx+= 3;
    }
  }
  
  private void getGimic(){
    if(loca_floor < stage.data_floor.length - 1)
    if ((stage.data_floor[loca_floor] == 1 && stage.data_floor[loca_floor + 1] == 0 && y >= 0)
      || (stage.data_floor[loca_floor] != 2 && stage.data_floor[loca_floor + 1] == 2 && y >= -72) ) {
      if (scrx > 22.5 + 45 * loca_floor - x * 2 + 5) {
        scrx = 22.5 + 45 * loca_floor - x * 2 + 5;
      }
    }
  }
  
  private void goImage(){
    scry = y + 200;

    if (!KUCHU && frameCount % 5 == 0)scry = y + 210 -4;

    image(pid, scrx, scry);
  
  }
  
  private void checkDie(){
    if(scrx < -20 || y > 300){
      DIE = true;
      TITLE = true;
    }
  }

  void go(ObjectStage stage) {
    getGround();
    
    if(!DIE){
      x = x + 4.5;
      getMouse();  

    }
    
    getLocation();
    changeMove();
    getGimic();
    checkDie();
    
    goImage();
    
  }
}


