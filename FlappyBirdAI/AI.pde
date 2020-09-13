class AI {
  double birdY, birdVel, pipeX, pipeH, speedF, yDif, xDif;

  AI(double _birdY, double _birdVel, double _pipeX, double _pipeH, double _speedF, double _yDif, double _xDif) {
    birdY = _birdY;
    birdVel = _birdVel;
    pipeX = _pipeX;
    pipeH = _pipeH;
    speedF = _speedF;
    yDif = _yDif;
    xDif = _xDif;
  }
  
  AI copy() {
    return new AI(birdY, birdVel, pipeX, pipeH, speedF, yDif, xDif);
  }

  boolean shouldJump(PVector pos, PVector vel) {    
    int score = 0;
    score+= pos.y * birdY;
    score+= vel.x * birdVel;
    score+= pPos.x * pipeX;
    score+= pPos.y * pipeH;
    score+= speed * speedF;
    score+= (pPos.y - pos.y) * yDif;
    score+= (pPos.x - pos.x) * xDif;
    if (score > 100)
      return true;
    return false;
  }

  void mutate() {
    int mutated = floor(random(7));
    double amountMutated = random(-0.1, 0.1);
    switch(mutated) {
    case 0:
      birdY+= amountMutated;
      break;
    case 1:
      birdVel+= amountMutated;
      break;
    case 2:
      pipeX+= amountMutated;
      break;
    case 3:
      pipeH+= amountMutated;
      break;
    case 4:
      speedF+= amountMutated;
      break;
    case 5:
      yDif+= amountMutated;
      break;
    case 6:
      xDif+= amountMutated;
      break;
    }
  }
}
