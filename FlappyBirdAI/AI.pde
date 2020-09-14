class AI {
  double[] factors = new double[7];

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
    if (score > 100)
      return true;
    return false;
  }

  void mutate() {
    factors[floor(random(7))]+= random(-0.1, 0.1);
  }
}
