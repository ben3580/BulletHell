class PreviewLine{
  float x1;
  float y1;
  float x2;
  float y2;
  float timer;
  float alpha;
  
  PreviewLine(float initX, float initY, float initDir){
    alpha = 100;
    timer = 0;
    x1 = initX;
    y1 = initY;
    x2 = initX + (2500 * cos(initDir));
    y2 = initY + (2500 * sin(initDir));
  }
  
  void display(){
    strokeWeight(5);
    stroke(160, 229, 255, alpha);
    line(x1, y1, x2, y2);
  }
  
  void update(){
    if(timer < 10){
      alpha += 5;
    }
    else{
      alpha -= 5;
    }
    timer++;
  }
}
