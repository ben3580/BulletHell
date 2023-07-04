class TopDownAtk extends Attack{
  TopDownAtk(int numBullets){
    super(false);
    this.numBullets = numBullets;
    delays = new int[numBullets];
    speeds = new float[numBullets];
    for(int i = 0; i < numBullets; i++){
      delays[i] = 0;
      speeds[i] = 12;
    }
    createInitialStatus();
  }
  
  void createInitialStatus(){
    float x = player.x;
    float spacing = 75;
    initialPositions = new float[numBullets][2];
    directions = new float[numBullets];
    for(int i = 0; i < numBullets; i++){
      initialPositions[i][0] = x + (i - numBullets/2.0 + 0.5) * spacing;
      initialPositions[i][1] = -50;
      directions[i] = HALF_PI;   
    }
  }
}
