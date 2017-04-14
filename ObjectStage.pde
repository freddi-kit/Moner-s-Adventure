public class ObjectStage {
  int data_floor[] = new int[250];
  float x = 0;

  class Status {
    void status(ObjectMoner moner) {
      stroke(50, 250, 250);
      for (int i = 0; i < data_floor.length; i++) {
        if (stage.data_floor[i] == 0)line(i + 10, 20 + 250, i + 10, 15 + 250);
        else if (stage.data_floor[i] == 2)line(i + 10, 20 + 250, i + 10, 10 + 250);
      }
      stroke(250, 10, 10);
      line(moner.loca_floor + 10, 20 + 250, moner.loca_floor + 10, 5 + 250);
      noStroke();
    }
  }

  class Object {
    PImage Hashira = loadImage("Hashira.png");
    PImage pid;

    void go(float x, float y) {
      pid = Hashira;
      image(pid, x, y);
    }
  }

  PImage pid;
  PImage floor[] = {
    loadImage("floor.png"), 
    loadImage("floor2.png")
    };

    Status Status_go = new Status();
    Object Hashira = new Object();

    ObjectStage() {
      

      for (int i = 0; i < data_floor.length; i++) {

        if (i > 10) {
          data_floor[i] = (int)random(0, 3);

          if (data_floor[i - 1] == 1 && data_floor[i] == 2
            || data_floor[i - 2] == 1 && data_floor[i - 1] == 1)data_floor[i] = 0;

          if (data_floor[i - 3] == 2 && data_floor[i - 2] == 0 && data_floor[i - 1] == 1 && data_floor[i] == 1) {
            data_floor[i - 3] = 0;
          }
        } else data_floor[i] = 0;
      }
      
      for (int i = data_floor.length - 20; i < data_floor.length; i++) {
          data_floor[i] = 0;
      }
    }


  void go(ObjectMoner moner) {
    x++;
    for (int i = 0; i < 100; i++) {
      Hashira.go(i * 90 - x * 1.5, 220);
    }

    for (int i = 0; i < data_floor.length; i++) {
      if (data_floor[i] == 0)pid = floor[0];
      else if (data_floor[i] == 2)pid = floor[1];
      if (data_floor[i] != 1)image(pid, 22.5 + 45 * i - moner.x * 2, 150);
    }
    Status_go.status(moner);
  }
}

