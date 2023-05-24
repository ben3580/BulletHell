class Particle{
  float x;
  float y;
  float vx;
  float vy;
  int size;
  
  Particle(float x, float y){
    this.x = x;
    this.y = y;
    float speed = random(3);
    float direction = random(TWO_PI);
    this.vx = speed * cos(direction);
    this.vy = speed * sin(direction);
    this.size = int(random(1, 6));
  }
  
  void show(){
    noStroke();
    fill(230, 30, 30);
    rect(x + size/2, y + size/2, size, size);
  }
  
  void update(){
    x += vx;
    y += vy;
  }
}
