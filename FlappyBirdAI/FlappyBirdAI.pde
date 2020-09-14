Bird[] birds;
AI bestAI;
PVector pPos;
float speed, maxSpeed;
int pHeight, gScore, generation = 0;
boolean givenScore;
final PVector gravity = new PVector(0, 0.8);
final int size = 50, gap = 200, pSize = 100, birdX = 80, facNum = 8;
final float jumpForce = 13;

void setup() {
  size(1000, 800);
  frameRate(1200);

  birds = new Bird[100];
  
  for (int i = 0; i < birds.length; i++)
    birds[i] = new Bird();
    
  bestAI = new AI(new double[facNum]);
  
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
  strokeWeight(1);
  fill(20, 130, 30);
  rect(pPos.x, 0, pSize, pHeight);
  rect(pPos.x, pHeight + gap, pSize, height - pHeight - gap);

  for (Bird b : birds)
    b.show();

  fill(255);
  textAlign(TOP, CENTER);
  textSize(30);
  text(gScore, width/4, 10);

  fill(57);
  rect(width/2, 0, width/2, height);

  textAlign(BOTTOM, LEFT);
  textSize(30);
  fill(255);
  text("Generation : " + generation, 550, 50);

  fill(255);
  rect(510, 90, 480, 500);
  for (int i = 0; i < bestAI.factors.length; i++) {
    strokeWeight(abs((int) bestAI.factors[i]));
    stroke(bestAI.factors[i] > 0?#0000ff:#ff0000);
    if (bestAI.factors[i] > 0)
      line(550, 150 + i * 50, 950, 300);
  }


  boolean over = true;
  for (Bird b : birds) 
    if (b.alive)
      over = false;
  if (over)
    restart();
}

void mousePressed() {
  for (int i = 0; i < bestAI.factors.length; i++) {
    print(bestAI.factors[i] + ", ");
  }
  println();
}

int generateHeight() {
  return (int) random(100, height - 100 - gap);
}

void restart() {
  float[] bestDists = new float[10];
  int[] bestBirds = new int[10];
  AI[] bestAIs = new AI[10];
  for (int i = 0; i < bestBirds.length; i++) {
    bestDists[i] = 0;
    bestBirds[0] = -1;
  }
  for (int i = 0; i < bestBirds.length; i++) {
    float bestDist = 0;
    int bestBird = 0;

    for (int b = 0; b < birds.length; b++) {
      if (birds[b].distance > bestDist) {
        boolean good = true;
        for (int j = 0; j < bestBirds.length; j++) {
          if (bestBirds[j] == b)
            good = false;
        }
        if (good) {
          bestDist = birds[b].distance;
          bestBird = b;
        }
      }
    }

    bestDists[i] = bestDist;
    bestBirds[i] = bestBird;
    bestAIs[i] = birds[bestBird].ai.copy();
  }
  bestAI = birds[bestBirds[0]].ai.copy();

  for (int i = 0; i < 90; i++) {
    birds[i].ai = bestAIs[i/9].copy();
    birds[i].reset();
    birds[i].mutate();
    birds[i].mutate = true;
  }

  for (int i = 0; i < 10; i++) {
    birds[i].ai = bestAIs[i];
    birds[i].reset();
    birds[i].mutate = false;
  }

  pPos = new PVector(width/2, 0);
  speed = 3;
  maxSpeed = 7;
  gScore = 0;
  givenScore = false;
  pHeight = generateHeight();
  generation++;
}
