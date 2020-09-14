class AI {
  double[] factors = new double[facNum];

  AI(double[] _factors) {
    factors = _factors;
  }

  AI copy() {
    return new AI(factors.clone());
  }

  boolean shouldJump(PVector pos, PVector vel) {    
    int score = 0;
    score+= pos.y * factors[0];
    score+= vel.x * factors[1];
    score+= pPos.x * factors[2];
    score+= pPos.y * factors[3];
    score+= speed * factors[4];
    score+= (pPos.y - pos.y) * factors[5];
    score+= (pPos.x - pos.x) * factors[6];
    score+= (pos.y/height) * factors[7];
    if (score > 100)
      return true;
    return false;
  }

  void mutate() {
    for (int i = 0; i < 10; i++)
      factors[floor(random(factors.length))]+= random(-.5, .5);
  }
}
