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
  agentADown.resize(agentADown.width/2, agentADown.height/2);
  agentAUp.resize(agentAUp.width/2, agentAUp.height/2);
  agentALeft.resize(agentALeft.width/2, agentALeft.height/2);
  agentARight.resize(agentARight.width/2, agentARight.height/2);

  agentA = new Player(agentAx, agentAy, 48, 4, agentADown); 
  
  //Agent B - Turret
  int agentBx = 60;
  int agentBy = 300;
  agentBRight = loadImage("../assets/Agent-B/Agent-B-Right.png");
  agentBRight.resize(agentBRight.width/2, agentBRight.height/2);
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
  
  //Background
  bg = loadImage("../assets/Map/Room.png");
  background(bg);
}


void draw(){

  if ((agentA.isLeft || agentA.isRight || agentA.isUp || agentA.isDown || agentA.isRotatingClockwise || agentA.isRotatingAnticlockwise)) {
      background(bg);
      door.display();
  }
  
  agentA.move();
  agentA.rotate();
      paintScreenBlack();

  agentA.display();
  agentB.display();
  turret.display();


  agentA.detectCollision();
  

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
     
   for (int pixelY = 0; pixelY < VP; pixelY= pixelY + 6) {
     for (int pixelX = 0; pixelX < HP; pixelX = pixelX + 6) {
        PVector playerToPoint = new PVector(pixelX-(agentA.x+30), pixelY-(agentA.y+30));
          float angleBetween = PVector.angleBetween(agentA.facingDirection, playerToPoint);
          if (angleBetween > PI) {
              angleBetween = 2*PI - angleBetween;
          }
          if (angleBetween > PI/8 && pixelX > 167) {
            
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

  boolean isLeft, isRight, isUp, isDown, isRotatingClockwise, isRotatingAnticlockwise;
  final int d, v, rotationSpeed;
  float bearing;
  PVector facingDirection;
 
  Player(int xx, int yy, int dd, int vv, PImage i) {
    super(xx, yy, i);
    d = dd;
    v = vv;
    rotationSpeed = 5;
    bearing = 0;
    facingDirection = new PVector(1,1);
  }
 
 void rotate() {
   float changeInBearing = rotationSpeed*(int(isRotatingClockwise) - int(isRotatingAnticlockwise));
   facingDirection.rotate((changeInBearing/360)*2*PI);
 }
 
  void move() {
    int r = d>>1;
    x = constrain(x + v*(int(isRight) - int(isLeft)), r, width  - r);
    y = constrain(y + v*(int(isDown)  - int(isUp)),   r, height - r);
  }
 
  boolean setMove(int k, boolean b) {
    switch (k) {
    case 'W':
      img = agentAUp;
      return isUp = b;
 
    case 'S':
      img = agentADown;
      return isDown = b;
 
    case 'A':
      img = agentALeft;
      return isLeft = b;
 
    case 'D':
      img = agentARight;
      return isRight = b;
      
    case LEFT :
      return isRotatingAnticlockwise = b;
 
    case RIGHT :
      return isRotatingClockwise = b;
 
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