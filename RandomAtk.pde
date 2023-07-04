class RandomAtk extends Attack{
  RandomAtk(int numBullets){
    super(false);
    this.numBullets = numBullets;
    delays = new int[numBullets];
    speeds = new float[numBullets];
    for(int i = 0; i < numBullets; i++){
      delays[i] = 0;
      speeds[i] = random(5, 10);
    }
    createInitialStatus();
  }
  
  void createInitialStatus(){
    float x;
    float y;
    float direction;
    int amount = delays.length;
    initialPositions = new float[amount][2];
    directions = new float[amount];
    for(int i = 0; i < amount; i++){
      int side = floor(random(4)); // up, right, down, left
      if(side == 0){
        x = random(-100, width + 100);
        y = -25;
        direction = randomGaussian() * HALF_PI + HALF_PI;
      }
      else if(side == 2){
        x = random(-100, width + 100);
        y = height + 25;
        direction = randomGaussian() * HALF_PI + 1.5 * PI;
      }
      else if(side == 1){
        x = width + 25;
        y = random(-100, height + 100);
        direction = randomGaussian() * HALF_PI + PI;
      }
      else{
        x = -25;
        y = random(-100, height + 100);
        direction = randomGaussian() * QUARTER_PI + QUARTER_PI;
        if(random(1) < 0.5){
          direction = -direction;
        }
      }
      initialPositions[i][0] = x;
      initialPositions[i][1] = y;
      directions[i] = direction;
    }
  }
}
