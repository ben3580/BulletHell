class Explosion{
  Particle[] particles;
  int timer;
  
  Explosion(float x, float y){
    particles = new Particle[100];
    for(int i = 0; i < 100; i++){
      particles[i] = new Particle(x, y);
    }
    timer = 0;
  }
  
  void display(){
    for(int i = 0; i < 100; i++){
      particles[i].update();
      particles[i].show();
    }
    timer += 1;
  }
}
