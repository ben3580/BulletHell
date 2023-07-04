class CircleAtk2 extends Attack{
  CircleAtk2(){
    super(false);
    numBullets = 20;
    delays = new int[numBullets];
    speeds = new float[numBullets];
    for(int i = 0; i < numBullets; i++){
      delays[i] = i * 1000 / numBullets;
      speeds[i] = 15;
    }
    createInitialStatus();
  }
  
  void createInitialStatus(){
    float x;
    float y;
    float direction;
    x = player.x;
    y = player.y;
    initialPositions = new float[numBullets][2];
    directions = new float[numBullets];
    for(int i = 0; i < numBullets; i++){
      float tempx = x;
      float tempy = y;
      direction = i / float(numBullets) * TWO_PI;
      tempx -= 1500 * cos(direction);
      tempy -= 1500 * sin(direction);
      initialPositions[i][0] = tempx;
      initialPositions[i][1] = tempy;
      directions[i] = direction;
    }
  }
}
