class SkyAtk extends Attack{
  SkyAtk(){
    super(false);
    numBullets = 50;
    delays = new int[numBullets];
    speeds = new float[numBullets];
    for(int i = 0; i < numBullets; i++){
      if(i % 2 == 0){
        delays[i] = 0;
      }
      else{
        delays[i] = 400;
      }
      
      speeds[i] = 12;
    }
    createInitialStatus();
  }
  
  void createInitialStatus(){
    float x;
    x = random(0, (float(width) / numBullets));
    initialPositions = new float[numBullets][2];
    directions = new float[numBullets];
    for(int i = 0; i < numBullets; i++){
      initialPositions[i][0] = x + (float(width) / numBullets) * i;
      initialPositions[i][1] = -50;
      directions[i] = HALF_PI;   
    }
  }
}
