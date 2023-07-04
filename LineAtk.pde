class LineAtk extends Attack{
  LineAtk(){
    super(true);
    numBullets = 5;
    delays = new int[numBullets];
    speeds = new float[numBullets];
    for(int i = 0; i < numBullets; i++){
      delays[i] = 0;
      speeds[i] = 10 + (10.0 / numBullets) * i;
    }
    createInitialStatus();
  }
  
  void createInitialStatus(){
    float x;
    float y;
    float direction;
    int side = floor(random(0, 4)); // up, right, down, left
    if(side == 0){
      x = random(100, width - 100);
      y = -100;
    }
    else if(side == 2){
      x = random(100, width - 100);
      y = height + 100;
    }
    else if(side == 1){
      x = width + 100;
      y = random(100, height - 100);
    }
    else{
      x = -100;
      y = random(100, height - 100);
    }
    initialPositions = new float[numBullets][2];
    directions = new float[numBullets];
    direction = atan2(player.y - y, player.x - x);
    for(int i = 0; i < numBullets; i++){
      initialPositions[i][0] = x;
      initialPositions[i][1] = y;
      directions[i] = direction;
    }
  }
}
