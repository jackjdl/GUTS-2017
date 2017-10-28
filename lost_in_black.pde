Player agentA;
Entity agentB;
PImage bg;
PImage agentADown, agentAUp, agentALeft, agentARight, agentBRight;

void setup(){
  size(1080,720);
  smooth(4);
  frameRate(60);
  cursor(CROSS);
  
  //Agent A - Ground
  int agentAx = 600;
  int agentAy = 92;
  agentADown = loadImage("assets/Agent-A/Agent-A-Down.png");
  agentAUp = loadImage("assets/Agent-A/Agent-A-Up.png");
  agentALeft = loadImage("assets/Agent-A/Agent-A-Left.png");
  agentARight = loadImage("assets/Agent-A/Agent-A-Right.png");
  agentA = new Player(agentAx, agentAy, 48, 4, agentADown); 
  
  //Agent B - Turret
  int agentBx = 60;
  int agentBy = 300;
  agentBRight = loadImage("assets/Agent-B/Agent-B-Right.png");
  agentB = new Entity(agentBx, agentBy, agentBRight);
  
  
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
  bg = loadImage("assets/Map/Room.png");
}


void draw(){
  background(bg);
  agentA.move();
  agentA.display();
  agentB.display();
}

void keyPressed() {
  agentA.setMove(keyCode, true);
}
 
void keyReleased() {
  agentA.setMove(keyCode, false);
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
}