class Bullet{
  float x;
  float y;
  float pointX1;
  float pointX2;
  float pointY1;
  float pointY2;
  float LENGTH;
  float WIDTH;
  float speed;
  float direction;
  int timer;
  
  Bullet(float initX, float initY, float initDir, float initSpeed){
    LENGTH = 50;
    WIDTH = 5;
    speed = initSpeed;
    timer = 0;
    pointX1 = -100;
    pointX2 = -100;
    pointY1 = -100;
    pointY2 = -100;
    x = initX;
    y = initY;
    direction = initDir;
  }
  
  void display(){
    strokeWeight(WIDTH);
    stroke(#23E1F5);
    pointX1 = x - (LENGTH * cos(direction) / 2);
    pointX2 = x + (LENGTH * cos(direction) / 2);
    pointY1 = y - (LENGTH * sin(direction) / 2);
    pointY2 = y + (LENGTH * sin(direction) / 2);
    line(pointX1, pointY1, pointX2, pointY2);
  }
  
  void update(){
    x += speed * cos(direction);
    y += speed * sin(direction);
    timer++;
  }
  
  boolean collision(float playerX, float playerY, float playerSize){
    float threshold = playerSize * 0.6;
    if(dist(x, y, playerX, playerY) <= threshold ||
       dist(pointX1, pointY1, playerX, playerY) <= threshold ||
       dist(pointX2, pointY2, playerX, playerY) <= threshold){
      return true;
    }
    else{
      return false;
    }
  }
}
