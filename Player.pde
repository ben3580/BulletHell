class Player{
  float x;
  float y;
  float SIZE;
  float direction;
  boolean isMoving;
  boolean invulnerable;
  int lives;
  ArrayList<float[]> trail;
  boolean shield;
  boolean hasDash;
  boolean isDashing;
  DashTrail dashTrail;
  
  Player(float initX, float initY){
    x = initX;
    y = initY;
    SIZE = 20;
    direction = 0;
    isMoving = false;
    invulnerable = false;
    lives = 5;
    trail = new ArrayList<>();
    float[] temp = {x, y};
    for(int i = 0; i < 10; i++){
      trail.add(temp);
    }
    shield = true;
    hasDash = true;
    isDashing = false;
    dashTrail = new DashTrail();
  }
  
  void display(){
    noStroke();
    for(int i = 0; i < 10; i++){
      float[] point = trail.get(i);
      fill(255, 255, 50, 200 - 15 * i);
      ellipse(point[0], point[1], SIZE - 5 - i, SIZE - 5 - i);
    }
    if(invulnerable){
      fill(100);
    }
    else{
      fill(255);
    }
    ellipse(x, y, SIZE, SIZE);
    if(shield){
      strokeWeight(3);
      stroke(#233FD6);
      fill(#233FD6, 100);
      ellipse(x, y, SIZE*2, SIZE*2);
    }
    dashTrail.update();
    dashTrail.display();
  }
  
  void update(float newDirection, boolean newMoving){
    if(isDashing){
      dashTrail.addTrail(x, y);
      x += 20 * cos(direction);
      y += 20 * sin(direction);
    }
    else{
      direction = newDirection;
      isMoving = newMoving;
      if(isMoving){
        x += 5 * cos(direction);
        y += 5 * sin(direction);
      }
    }
    if(x < SIZE){
      x = SIZE;
    }
    else if(x > width - SIZE){
      x = width - SIZE;
    }
    if(y < SIZE){
      y = SIZE;
    }
    else if(y > height - SIZE){
      y = height - SIZE;
    }
    
    trail.remove(9);
    float[] temp = {x, y};
    trail.add(0, temp);
  }
  
  boolean checkCollision(ArrayList<Bullet> bullets){
    boolean collision = false;
    if(invulnerable || isDashing){
      return false;
    }
    for(int i = 0; i < bullets.size() && !collision; i++){
      collision = bullets.get(i).collision(x, y, SIZE);
    }
    if(collision){
      invulnerable = true;
    }
    return collision;
  }
}
