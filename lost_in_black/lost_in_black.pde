Player agentA;
Entity agentB;
Turret turret;
Entity door;
PImage bg;
PImage agentADown, agentAUp, agentALeft, agentARight, agentBRight, turretNormal, turretFire, doorNormal;

int VP = 720;
int HP = 1080;
void setup(){
  size(1080,720);
  smooth(4);
  frameRate(60);
  cursor(CROSS);
  
  //Agent A - Ground
  int agentAx = 600;
  int agentAy = 92;
  agentADown = loadImage("../assets/Agent-A/Agent-A-Down.png");
  agentAUp = loadImage("../assets/Agent-A/Agent-A-Up.png");
  agentALeft = loadImage("../assets/Agent-A/Agent-A-Left.png");
  agentARight = loadImage("../assets/Agent-A/Agent-A-Right.png");
  agentA = new Player(agentAx, agentAy, 48, 4, agentADown); 
  
  //Agent B - Turret
  int agentBx = 60;
  int agentBy = 300;
  agentBRight = loadImage("../assets/Agent-B/Agent-B-Right.png");
  agentB = new Entity(agentBx, agentBy, agentBRight);
  
  //Turret
  int turretx = 90;
  int turrety = 310;
  turretNormal = loadImage("../assets/Objects/Turret-Normal.png");
  turretFire = loadImage("../assets/Objects/Turret-Fire.png");
  turret = new Turret(turretx, turrety, turretNormal);
  
  //Door
  int doorx = width / 2 + 30;
  int doory = height - 20;
  doorNormal = loadImage("../assets/Objects/Door-Normal.png");
  door = new Entity(doorx, doory, doorNormal);
  
  
  /*Turret
  turret = loadImage("assets/Objects/Turret-Normal.png");
  turretx = 130;
  turrety = (height - agentA.height)/2;
  
  //Agent B - Ground
  agentB = loadImage("assets/Agent-B/Agent-B-Down.png");
  agentBx = (width - agentA.width)/2;
  agentBy = (height - agentA.height)/2;
  */
  
  //Background
  bg = loadImage("../assets/Map/Room.png");
}


void draw(){
  
  if ((agentA.isLeft || agentA.isRight || agentA.isUp || agentA.isDown)) {
      background(bg);
      agentB.display();
      turret.display();
      door.display();
  }
  
  agentA.move();
  agentA.display();
  agentA.detectCollision();
  
  paintScreenBlack();

}

void keyPressed() {
  agentA.setMove(keyCode, true);
}
 
void keyReleased() {
  agentA.setMove(keyCode, false);
}

void mousePressed() {
   turret.fire();
}

void mouseReleased() {
   turret.stop(); 
}

void paintScreenBlack() {
   
  
    PVector facingDirection;
    if (agentA.isLeft) {
        facingDirection = new PVector(-1,0);
                      System.out.println("l");

    } else if (agentA.isDown) {
        facingDirection = new PVector(0,1);
                              System.out.println("d");

    } else if (agentA.isUp) {
        facingDirection = new PVector(0,-1);
                              System.out.println("u");

    } else if (agentA.isRight) {
        facingDirection = new PVector(1,0);
                                      System.out.println("r");

    } else {
        return;
    }
 
   for (int pixelY = 0; pixelY < VP; pixelY= pixelY + 6) {
     for (int pixelX = 0; pixelX < HP; pixelX = pixelX + 6) {
        PVector playerToPoint = new PVector(pixelX-agentA.x, pixelY-agentA.y);
          float angleBetween = PVector.angleBetween(facingDirection, playerToPoint);
          if (angleBetween > PI) {
              angleBetween = 2*PI - angleBetween;
          }
          if (angleBetween > PI/4) {
            
            color black = color(0);
            for (int surroundX = pixelX - 3; surroundX < pixelX + 3; surroundX++) {
              for (int surroundY = pixelY - 3; surroundY < pixelY + 3; surroundY++) {
                 if (surroundX >= 0 && surroundX < HP && surroundY >= 0 && surroundY < VP) {
                     set(surroundX, surroundY, black);
                 }
              }
           }
        } 
     }
  }
}


/*
Classes
*/



class Entity {
  
 int x, y;
 PImage img;
 
 Entity(int xx, int yy, PImage i) {
   x = xx;
   y = yy;
   img = i;
 }
 
 void display() {
   image(img,x,y);
 }
 
}


class Turret extends Entity {
  
 float bearing;
 PVector location;
 boolean isFiring;
 
 Turret(int xx, int yy, PImage i) {
   super(xx, yy, i);
   location = new PVector(x, y);
 }
 
 void turn() {
    //TODO
 }
 
 void fire() {
   img = turretFire;
 }
 
 void stop() {
   img = turretNormal;
 }

}



class Player extends Entity {

  boolean isLeft, isRight, isUp, isDown;
  final int d, v;
 
  Player(int xx, int yy, int dd, int vv, PImage i) {
    super(xx, yy, i);
    d = dd;
    v = vv;
  }

 
  void move() {
    int r = d>>1;
    x = constrain(x + v*(int(isRight) - int(isLeft)), r, width  - r);
    y = constrain(y + v*(int(isDown)  - int(isUp)),   r, height - r);
  }
 
  boolean setMove(int k, boolean b) {
    switch (k) {
    case UP:
      img = agentAUp;
      return isUp = b;
 
    case DOWN:
      img = agentADown;
      return isDown = b;
 
    case LEFT:
      img = agentALeft;
      return isLeft = b;
 
    case RIGHT:
      img = agentARight;
      return isRight = b;
 
    default:
      return b;
    }
  }
  
  void detectCollision() {
    //Collision with door
    
    float doortl = door.x;
    float doortr = doortl + door.img.width;
    float doorbl = door.x + door.img.height;
    float doorbr = doorbl + door.img.width;
    
    //Collision with walls
    if(y > height - 80) {
      y = height - 80;
    }
    if(x > width - 80) {
      x = width - 80;
    }
    if(x < 150) {
      x = 150;
    }
  }
}