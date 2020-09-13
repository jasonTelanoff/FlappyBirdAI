Bird[] birds = new Bird[1];
PVector pPos;
float speed, maxSpeed;
int pHeight, gScore;
boolean givenScore;
final PVector gravity = new PVector(0, 0.8);
final int size = 50, gap = 200, pSize = 100, birdX = 80;
final float jumpForce = 13;

void setup() {
  size(1000, 800);
  textAlign(TOP, CENTER);
  textSize(30);
  for (int i = 0; i < birds.length; i++)
    birds[i] = new Bird();
  restart();
}

void draw() {
  background(100, 200, 255);

  for (Bird b : birds) {
    b.update();
  }
  pPos.x -= speed;

  if (pPos.x < -pSize) {
    pPos = new PVector(width/2, 0);
    pHeight = generateHeight();
    givenScore = false;
    if (speed < maxSpeed)
      speed+= 0.1;
  }

  if (!givenScore && birdX - size/2 > pPos.x + pSize) {
    for (Bird b : birds)
      b.updateScore();
    gScore++;
    givenScore = true;
  }

  stroke(0);
  fill(20, 130, 30);
  rect(pPos.x, 0, pSize, pHeight);
  rect(pPos.x, pHeight + gap, pSize, height - pHeight - gap);

  for (Bird b : birds)
    b.show();

  fill(255);
  text(gScore, width/4, 10);

  fill(57);
  rect(width/2, 0, width/2, height);

  boolean over = true;
  for (Bird b : birds) 
    if (b.alive)
      over = false;
  if(over)
    restart();
}

void mousePressed() {
  birds[0].jump();
}

int generateHeight() {
  return (int) random(100, height - 100 - gap);
}

void restart() {
  for (Bird b : birds)
    b.reset();
  pPos = new PVector(width/2, 0);
  speed = 3;
  maxSpeed = 7;
  gScore = 0;
  givenScore = false;
  pHeight = generateHeight();
}
