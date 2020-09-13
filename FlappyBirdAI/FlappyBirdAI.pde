PVector pos, vel, pPos;
float speed, maxSpeed, distance;
int pHeight, score;
boolean givenScore;
final PVector gravity = new PVector(0, 0.8);
final int size = 50, gap = 200, pSize = 100;
final float jumpForce = 13;

void setup() {
  size(1000, 800);
  textAlign(TOP, CENTER);
  textSize(30);
  restart();
}

void draw() {
  background(100, 200, 255);

  vel.add(gravity);
  pos.add(vel);
  pPos.x -= speed;
  
  distance+= speed;

  if (pPos.x < -pSize) {
    pPos = new PVector(width/2, 0);
    pHeight = generateHeight();
    givenScore = false;
    if (speed < maxSpeed)
      speed+= 0.1;
  }

  if (!givenScore && pos.x - size/2 > pPos.x + pSize) {
    score++;
    givenScore = true;
  }

  stroke(0);
  fill(20, 130, 30);
  rect(pPos.x, 0, pSize, pHeight);
  rect(pPos.x, pHeight + gap, pSize, height - pHeight - gap);

  stroke(255);
  noFill();
  square(pos.x - size/2, pos.y - size/2, size);

  fill(255, 255, 0);
  stroke(0);
  circle(pos.x, pos.y, size);

  fill(255);
  text(score, width/4, 10);

  if (pos.x + size/2 > pPos.x && pos.x - size/2 < pPos.x + pSize)
    if (pos.y - size/2 < pHeight || pos.y + size/2 > pHeight + gap)
      restart();
  if (pos.y > height)
    restart();

  fill(57);
  rect(width/2, 0, width/2, height);
}

void mousePressed() {
  jump();
}

void jump() {
  vel = new PVector(0, -jumpForce);
}

int generateHeight() {
  return (int) random(100, height - 100 - gap);
}

void restart() {
  pos = new PVector(80, height/2);
  vel = new PVector(0, 0);
  pPos = new PVector(width/2, 0);
  speed = 3;
  maxSpeed = 7;
  score = 0;
  givenScore = false;
  distance = 0;
  pHeight = generateHeight();
}
