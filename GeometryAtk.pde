class GeometryAtk extends Attack{
  GeometryAtk(){
    super(false);
    numBullets = 59;
    delays = new int[numBullets];
    speeds = new float[numBullets];
    for(int i = 0; i < numBullets; i++){
      if(i < 38){
        delays[i] = 0;
      }
      else{
        delays[i] = 1000;
      }
      
      speeds[i] = 10;
    }
    createInitialStatus();
  }
  
  void createInitialStatus(){
    float x;
    float y;
    x = random(0, 50);
    y = random(0, 50);
    initialPositions = new float[numBullets][2];
    directions = new float[numBullets];
    for(int i = 0; i < numBullets; i++){
      if(i < 38){
        initialPositions[i][0] = x + 50 * i;
        initialPositions[i][1] = y - 100;
        directions[i] = HALF_PI;   
      }
      else{
        initialPositions[i][0] = x - 100;
        initialPositions[i][1] = y + 50 * (i - 38);
        directions[i] = 0;   
      }
    }
  }
}
