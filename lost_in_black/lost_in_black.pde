Player agentA;
Entity agentB;
Turret turret;
Entity door;
Alien alienA;
Light flashlight;
PImage bg;
PImage agentADown, agentAUp, agentALeft, agentARight, agentBRight, turretNormal, turretFire, doorNormal, alienADown, flashlightNormal, heartNormal, bulletNormal, instructionsMovement, instructionsLight, laserImage;

ArrayList<Laser> lasers = new ArrayList<Laser>();

int VP = 725;
int HP = 1080;

boolean tutorial = true;
boolean tutorialDone = false;
boolean pickedUpLight = false;
boolean movedLight = false;
boolean killedAliens = false;

void setup(){
  size(1080,720);
  smooth(4);
  frameRate(60);
  cursor(ARROW);
  
  
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
  
  
  //Flashlight
  int flashlightx = 400;
  int flashlighty = 500;
  flashlightNormal = loadImage("../assets/Objects/Flashlight.png");
  flashlightNormal.resize(flashlightNormal.width/2, flashlightNormal.height/2);
  flashlight = new Light(flashlightx, flashlighty, 0, 0, flashlightNormal);
  
  
  //Heart
  heartNormal = loadImage("../assets/Objects/Heart.png");
  heartNormal.resize(heartNormal.width/16, heartNormal.height/16);
  
  
  //Bullet
  bulletNormal = loadImage("../assets/Objects/Bullet.png");
  bulletNormal.resize(bulletNormal.width/16, bulletNormal.height/16);
  
  
  //Instructions
  instructionsMovement = loadImage("../assets/Map/Instructions-Movement.png");
  instructionsLight = loadImage("../assets/Map/Instructions-Light.png");
  
  //Laser
  laserImage = loadImage("../assets/Objects/Laser2.png");
  
  
  //Background
  bg = loadImage("../assets/Map/Room.png");
  background(bg);
}

void setup2() {
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
  
  
  //Alien
  int alienAx = 200;
  int alienAy = 150;
  alienADown = loadImage("../assets/Aliens/Alien-B.png");
  alienADown.resize(alienADown.width/2, alienADown.height/2);
  alienA = new Alien(alienAx, alienAy, 24, 4, alienADown);
  
  //Background
  bg = loadImage("../assets/Map/Room.png");
  background(bg);
}


void draw(){
  
  if (!tutorial && !tutorialDone) {
    setup2();
    tutorialDone = true;
  }

  background(bg);
  
  agentA.move();
  agentA.rotate();
  
  if (tutorialDone) {
    alienA.display();
  }
  
  door.display();
  
  if (!pickedUpLight) {
    agentA.display();
    blackWithFlashlight();
  } else {
    paintScreenBlack();
    agentA.display();
  }
  
  if (tutorial && !pickedUpLight) {
    flashlight.display();
  }
  
  if (!pickedUpLight) {
    image(instructionsMovement, 750, 500);
  } else {
    if (!movedLight) {
      image(instructionsLight, 750, 500);
    }
  }
  
  if (tutorialDone) {
    alienA.move();
    alienA.rotate();
  }

  
  agentB.display();
  turret.display();

  agentA.detectCollision();
  
  if (tutorialDone && !killedAliens) {
    alienA.detectCollision();
  }
  
  for (Laser laser: lasers) {
  
    laser.move();
    laser.display();
    laser.detectCollision();
  }
  

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

void blackWithFlashlight() {
  
     for (int pixelY = 0; pixelY < VP; pixelY= pixelY + 6) {
     for (int pixelX = 0; pixelX < HP; pixelX = pixelX + 6) {
        PVector flashlightToPoint = new PVector(pixelX-(flashlight.x+30), pixelY-(flashlight.y+30));
          float angleBetween = PVector.angleBetween(flashlight.facingDirection, flashlightToPoint);
          if (angleBetween > PI) {
              angleBetween = 2*PI - angleBetween;
          }
          if (angleBetween > PI/16 && pixelX > 167) {
            
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

void paintScreenBlack() {
     
   for (int pixelY = 0; pixelY < VP; pixelY= pixelY + 6) {
     for (int pixelX = 0; pixelX < HP; pixelX = pixelX + 6) {
        PVector playerToPoint = new PVector(pixelX-(agentA.x+30), pixelY-(agentA.y+30));
          float angleBetween = PVector.angleBetween(agentA.facingDirection, playerToPoint);
          if (angleBetween > PI) {
              angleBetween = 2*PI - angleBetween;
          }
          if (angleBetween > PI/16 && pixelX > 167) {
            
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
 int bullets;
 PVector facingDirection;
 
 Turret(int xx, int yy, PImage i) {
   super(xx, yy, i);
   location = new PVector(x, y);
   bullets = 15;
   facingDirection = new PVector(1,0);

 }
 
 void rotate() {
     facingDirection.set(mouseX - x, mouseY - y);
 }
 
 void display() {
   image(img,x,y);
   for (int i = 0; i < bullets; i++) {
     image(bulletNormal, (6 + (7 * i)), (height - bulletNormal.height - 50));
   }
 }
 
 void fire() {
   if (bullets > 0) {
     rotate();
     img = turretFire;
     lasers.add(new Laser(x + 40, y + 25, facingDirection));
   }
   bullets--;
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
  int lives;
 
  Player(int xx, int yy, int dd, int vv, PImage i) {
    super(xx, yy, i);
    d = dd;
    v = vv;
    lives = 3;
    rotationSpeed = 5;
    bearing = 0;
    facingDirection = new PVector(1,-3);
  }
 
 void rotate() {
   float changeInBearing = rotationSpeed*(int(isRotatingClockwise) - int(isRotatingAnticlockwise));
   facingDirection.rotate((changeInBearing/360)*2*PI);
 }
 
  void move() {
    int r = d>>1;
    x = constrain(x + v*(int(isRight) - int(isLeft)), r, width  - r);
    y = constrain(y + v*(int(isDown)  - int(isUp)),   r, height - r);
    if (isLeft) img = agentALeft;
    else if (isRight) img = agentARight;
    else if (isUp) img = agentAUp;
    else if (isDown) img = agentADown;
  }
  
   void display() {
     image(img,x,y);
     fill(100);
     rect(0, height - heartNormal.height - 70, 145, 200);
     for (int i = 0; i < lives; i++) {
       image(heartNormal, (15 + (40 * i)), (height - heartNormal.height - 10));
     }
     
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
      movedLight = true;
      return isRotatingAnticlockwise = b;
 
    case RIGHT :
      movedLight = true;
      return isRotatingClockwise = b;
 
    default:
      return b;
    }
  }
  
  void detectCollision() {
    
    //Collision with door
    if (y > 680 && x > 500 && x < 630) {
        tutorial = false;
        movedLight = true;
    }
    
    //Collision with flashlight
    if (y > 500 && y < 500 + flashlight.img.height && x > 350 && x < 400 + flashlight.img.width) {
      pickedUpLight = true;
    }
    
    //Collision with Alien
    if (alienA != null) {
      if ((y > alienA.y) && (y < alienA.y + alienA.img.height) && (x > alienA.x) && (x < alienA.x + alienA.img.width)) {
        alienA.x -= 30;
        alienA.y -= 30;
        lives--;
        fill(209, 38, 38);
        rect(0, 0, width, height);
        if (lives == 0) {
           exit();
        }
      }
    }
    
    //Collision with walls
    if(y > height - 40) {
      y = height - 40;
    }
    if(x > width - 40) {
      x = width - 40;
    }
    if(x < 150) {
      x = 150;
    }
  }
}

class Light extends Player {
   Light(int xx, int yy, int dd, int vv, PImage i) {
     super(xx, yy, dd, vv, i);
    bearing = 0;
    facingDirection = new PVector(1,-3);
   }
   
   void rotate() {
      // 
   }
   
   void move() {
     //
   }
}

class Alien extends Player {
  
  Alien(int xx, int yy, int dd, int vv, PImage i) {
    super(xx, yy, dd, vv, i);
  }
  
  void rotate() {
    facingDirection.set(agentA.x - x, agentA.y - y);
  }
  
  void move() {
    rotate();
    PVector v = new PVector(facingDirection.x, facingDirection.y);
    System.out.println(v.div(v.mag()));
    x += (v.x) * 2;
    y += (v.y) * 2;
  }
  
}

class Laser extends Entity {  
  
  PVector facingDirection;
  
  public Laser(int xx, int yy, PVector facingDirection) {
      super(xx, yy, laserImage);
      this.facingDirection = facingDirection;
  }
      
  void move() {
    PVector v = new PVector(facingDirection.x/facingDirection.mag(), facingDirection.y/facingDirection.mag());
    
    
    x += (v.x) * 50;
    y += (v.y) * 50;
    System.out.println("x:" + facingDirection.x);
    System.out.println("y:" + facingDirection.y);

  }
  
  void detectCollision() {
    if (alienA != null) {
      if ((y > alienA.y) && (y < alienA.y + alienA.img.height) && (x > alienA.x) && (x < alienA.x + alienA.img.width)) {
      
          alienA = new Alien(170 + (int)Math.round(random(HP - 200)), (int)Math.round(random(VP)), 24, 4, alienADown);

      
      }
    }
    
  }
}