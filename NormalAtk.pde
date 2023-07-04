class NormalAtk extends Attack{
  NormalAtk(int numBullets){
    super(false);
    this.numBullets = numBullets;
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
    int side = floor(random(0, 4)); // up, right, down, left
    if(side == 0){
      x = random(100, width - 100);
      y = -25;
    }
    else if(side == 2){
      x = random(100, width - 100);
      y = height + 25;
    }
    else if(side == 1){
      x = width + 25;
      y = random(100, height - 100);
    }
    else{
      x = -25;
      y = random(100, height - 100);
    }
    int spacing = 0;
    if(numBullets == 3){
      spacing = 200;
    }
    else if(numBullets == 5){
      spacing = 150;
    }
    else if(numBullets == 9){
      spacing = 100;
    }
    else{ //numBullets == 15
      spacing = 70;
    }
    initialPositions = new float[numBullets][2];
    directions = new float[numBullets];
    for(int i = 0; i < numBullets; i++){
      float tempx = x;
      float tempy = y;
      if(side == 0 || side == 2){
        tempx = x + (i - numBullets/2) * spacing;
      }
      else{
        tempy = y - (i - numBullets/2) * spacing;
      }
      
      initialPositions[i][0] = tempx;
      initialPositions[i][1] = tempy;
      direction = atan2(player.y - tempy, player.x - tempx);
      directions[i] = direction;
    }
  }
}
