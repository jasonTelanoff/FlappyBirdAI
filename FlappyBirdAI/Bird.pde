class Bird {
  PVector pos, vel;
  float distance, prevDistance;
  int score;
  boolean alive, mutate;
  AI ai;

  Bird() {
    double[] initFacs = {0, 0, 0, 0, 0, 0, 0, 0};
    ai = new AI(initFacs);
    mutate = true;
    reset();
  }

  void show() {
    if (alive) {
      //stroke(255);
      //noFill();
      //square(pos.x - size/2, pos.y - size/2, size);

      if (mutate)
        fill(255, 255, 0);
      else
        fill(255, 0, 0);
      stroke(0);
      strokeWeight(1);
      circle(pos.x, pos.y, size);
    }
  }

  void update() {
    if (alive) {
      vel.add(gravity);
      pos.add(vel);
      distance+= speed;

      if (pos.x + size/2 > pPos.x && pos.x - size/2 < pPos.x + pSize)
        if (pos.y - size/2 < pHeight || pos.y + size/2 > pHeight + gap)
          alive = false;
      if (pos.y > height)
        alive = false;

      if (ai.shouldJump(pos, vel)) jump();
    }
  }

  void updateScore() {
    if (alive) score++;
  }

  void jump() {
    vel = new PVector(0, -jumpForce);
  }

  void reset() {
    prevDistance = distance;
    pos = new PVector(birdX, height/2);
    vel = new PVector(0, 0);
    alive = true;
    score = 0;
    distance = 0;
  }

  void mutate() {
    ai.mutate();
  }
}
