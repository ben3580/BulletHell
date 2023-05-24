class RandomText{
  int direction;
  float x;
  float y;
  float rotation;
  int timer;
  
  RandomText(){
    direction = floor(random(0, 2));
    x = direction * (width + 400) - 200;
    y = random(200, height - 200);
    rotation = 0;
    timer = 0;
  }
  
  void update(){
    if(direction == 0){
      x += 1;
    }
    else{
      x -= 1;
    }
    rotation += 0.01;
    timer += 1;
  }
  
  void display(){
    translate(x, y);
    rotate(rotation);
    fill(150);
    textSize(30);
    text("Skill issue", 0, 0);
    rotate(-rotation);
    translate(-x, -y);
  }
}
