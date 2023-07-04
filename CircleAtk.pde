class CircleAtk extends Attack{
  CircleAtk(){
    super(false);
    numBullets = 32;
    delays = new int[numBullets];
    speeds = new float[numBullets];
    for(int i = 0; i < numBullets; i++){
      delays[i] = 0;
      speeds[i] = 10;
    }
    createInitialStatus();
  }
  
  void createInitialStatus(){
    float x;
    float y;
    float direction;
    x = random(200, width - 200);
    y = random(200, height - 200);
    initialPositions = new float[numBullets][2];
    directions = new float[numBullets];
    for(int i = 0; i < numBullets; i++){
      float tempx = x;
      float tempy = y;
      direction = i / float(numBullets) * TWO_PI;
      tempx += 100 * cos(direction) - 1500 * cos(direction + HALF_PI);
      tempy += 100 * sin(direction) - 1500 * sin(direction + HALF_PI);
      initialPositions[i][0] = tempx;
      initialPositions[i][1] = tempy;
      directions[i] = direction + HALF_PI;
    }
  }
}
