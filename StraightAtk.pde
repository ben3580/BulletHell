class StraightAtk extends Attack{
  StraightAtk(int numBullets){
    super(false);
    this.numBullets = numBullets;
    delays = new int[numBullets * 2];
    speeds = new float[numBullets * 2];
    for(int i = 0; i < numBullets * 2; i++){
      delays[i] = 0;
      speeds[i] = 15;
    }
    createInitialStatus();
  }
  
  void createInitialStatus(){
    float direction;
    int spacing = 75;
    initialPositions = new float[numBullets * 2][2];
    directions = new float[numBullets * 2];
    
    for(int i = 0; i < numBullets; i++){
      float tempx = -30;
      float tempy = height / 2;
      direction = atan2(player.y - tempy, player.x - tempx);
      tempx += (i - numBullets/2.0 + 0.5) * spacing * sin(direction);
      tempy -= (i - numBullets/2.0 + 0.5) * spacing * cos(direction);
      
      initialPositions[i][0] = tempx;
      initialPositions[i][1] = tempy;
      directions[i] = direction;
    }
    for(int i = 0; i < numBullets; i++){
      float tempx = width + 30;
      float tempy = height / 2;
      direction = atan2(player.y - tempy, player.x - tempx);
      tempx += (i - numBullets/2.0 + 0.5) * spacing * sin(direction);
      tempy -= (i - numBullets/2.0 + 0.5) * spacing * cos(direction);
      
      initialPositions[i + numBullets][0] = tempx;
      initialPositions[i + numBullets][1] = tempy;
      directions[i + numBullets] = direction;
    }
  }
}
