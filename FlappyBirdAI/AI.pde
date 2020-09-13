class Bird {
  PVector pos, vel;
  float distance;
  int score;
  boolean alive;
  
  Bird() {
    reset();
  }

  void show() {
    if (alive) {
      stroke(255);
      noFill();
      square(pos.x - size/2, pos.y - size/2, size);

      fill(255, 255, 0);
      stroke(0);
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
    }
  }

  void updateScore() {
    if (alive) score++;
  }

  void jump() {
    vel = new PVector(0, -jumpForce);
  }

  void reset() {
    pos = new PVector(birdX, height/2);
    vel = new PVector(0, 0);
    alive = true;
    score = 0;
    distance = 0;
  }
}
