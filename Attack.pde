abstract class Attack{
  int[] delays;
  float[] speeds;
  float[][] initialPositions;
  float[] directions;
  boolean justOne;
  int numBullets;
  
  Attack(boolean justOne){
    this.justOne = justOne;
  }
  
  abstract void createInitialStatus();
  
  PreviewLine[] generateLines(){
    if(justOne){
      PreviewLine[] lineArray = new PreviewLine[1];
      lineArray[0] = new PreviewLine(initialPositions[0][0], initialPositions[0][1], directions[0]);
      return lineArray;
    }
    else{
      PreviewLine[] lineArray = new PreviewLine[delays.length];
      for(int i = 0; i < delays.length; i++){
        lineArray[i] = new PreviewLine(initialPositions[i][0], initialPositions[i][1], directions[i]);
      }
      return lineArray;
    }
    
  }
  
  BulletWrapper[] generateBullets(int timeNow){
    BulletWrapper[] bulletArray = new BulletWrapper[delays.length];
    for(int i = 0; i < delays.length; i++){
      Bullet temp = new Bullet(initialPositions[i][0], initialPositions[i][1], directions[i], speeds[i]);
      bulletArray[i] = new BulletWrapper(timeNow + delays[i] + 500, temp);
    }
    return bulletArray;
  }
  
}
