import processing.sound.*;
SoundFile file;

boolean[] movement; // up, down, left, right / w, s, a, d
Player player;
ArrayList<Bullet> bullets;
ArrayList<PreviewLine> lines;
ArrayList<float[]> randomWaveNums;
ArrayList<float[]> focusWaveNums;
int timeAtHit;
int timeAtDash;
int score;
int highScore;
int nextRandomWave;
int nextFocusWave;
int nextRandomWave2;
int nextFocusWave2;
boolean menu;
Explosion explosion;
ArrayList<RandomText> randomText;

int timeStart;
int timeNow;

int musicTest;
int musicNext;
boolean musicPlaying;

void setup(){
  fullScreen();
  ellipseMode(CENTER);
  
  movement = new boolean[4];
  player = new Player(width/2, height/2);
  timeAtHit = 0;
  timeAtDash = 0;
  bullets = new ArrayList<>();
  lines = new ArrayList<>();
  randomWaveNums = new ArrayList<>();
  focusWaveNums = new ArrayList<>();
  menu = true;
  score = 0;
  highScore = 0;
  randomText = new ArrayList<>();
  
  timeStart = 0;
  timeNow = 0;
  
  musicTest = 0;
  musicNext = 0;
  musicPlaying = false;
  
  file = new SoundFile(this, "dog_nonstop_mix.wav");
  file.amp(0.3);
}

void draw(){
  background(0);
  timeNow = millis();
  fill(255);
  textSize(20);
  text("FPS:", width-70, 30);
  text(int(frameRate), width-20, 30);
  if(menu){
    textAlign(CENTER);
    fill(255);
    textSize(40);
    text("Score", width/2, 250);
    text(score, width/2, 300);
    text("High Score", width/2, 350);
    text(highScore, width/2, 400);
    textSize(40);
    text("Instructions", width/2, 500);
    stroke(255);
    strokeWeight(2);
    line(width/2 - 100, 515, width/2 + 100, 515);
    textSize(30);
    text("WASD / arrow keys to move", width/2, 570);
    text("Spacebar / x to dash. Dash gives you invulnerability. Recharges in 3 seconds", width/2, 620);
    text("You gain a rechargable shield if you don't get hit for 30 seconds", width/2, 670);
    
    textSize(40);
    text("Music", width/2, 750);
    line(width/2 - 40, 765, width/2 + 40, 765);
    textSize(30);
    text("DM Dokuro - Devourer of Gods Nonstop Mix", width/2, 820);
    text("Press Enter / Return to play", width/2, height - 100);
    // Title
    fill(#009FFF);
    textSize(80);
    int temp = timeNow;
    translate(width/2, 120);
    rotate(sin(temp/1000.0)/5.0);
    text("Ben's Bullet Hell", 0, 0);
    rotate(-sin(temp/1000.0)/5.0);
    translate(-width/2, -120);
    
    if(random(0, 1) > 0.997){
      randomText.add(new RandomText());
    }
    for(int i = randomText.size()-1; i >= 0; i--){
      RandomText rt = randomText.get(i);
      rt.update();
      rt.display();
      if(rt.timer >= 3000){
        randomText.remove(i);
      }
    }
  }
  else{
    if(timeNow >= nextRandomWave){
      addRandomLines();
    }
    
    if(timeNow >= nextRandomWave2){
      addRandomBullets();
    }
    
    if(timeNow >= nextFocusWave){
      addFocusLines();
    }
    
    if(timeNow >= nextFocusWave2){
      addFocusBullets();
    }
    
    if(timeNow >= musicNext){
      musicNext += 317;
      musicTest += 1;
    }
    
    float direction = calcDirection();
    boolean isMoving = true;
    if(direction < 0){
      isMoving = false;
    }
    
    player.update(direction, isMoving);
    player.display();
    boolean collision = player.checkCollision(bullets);
    if(collision){
      timeAtHit = timeNow;
      if(player.shield){
        player.shield = false;
      }
      else{
        player.lives -= 1;
        explosion = new Explosion(20 + player.lives * 30, 30);
        if(player.lives <= 0){
          player.lives = 5;
          if(score >= highScore){
            highScore = score;
          }
          menu = true;
          file.stop();
          musicPlaying = false;
          musicTest = 0;
          bullets.clear();
          lines.clear();
        }
      }
    }
    if(player.invulnerable){
      if(timeNow - timeAtHit >= 500){
        explosion = null;
      }
      if(timeNow - timeAtHit >= 2000){
        player.invulnerable = false;
      }
    }
    if(!player.shield && timeNow - timeAtHit >= 30000){
      player.shield = true;
    }
    if(player.isDashing && timeNow - timeAtDash >= 200){
      player.isDashing = false;
    }
    if(!player.hasDash && timeNow - timeAtDash >= 3000){
      player.hasDash = true;
    }
    
    displayStuff();
    
    score = (timeNow - timeStart)/1000;
    
    textAlign(RIGHT);
    fill(255);
    textSize(20);
    text("Score:", width-70, 55);
    text(score, width-20, 55);
    
    for(int i = 1; i <= player.lives; i++){
      noStroke();
      fill(230, 30, 30);
      rect(-10 + i * 30, 20, 20, 20);
    }
    
    if(explosion != null){
      explosion.display();
    }
    
    // Set up variables for the progress bar
    float progress = (timeNow - timeAtHit)/30000.0; // Change this value to update the progress
    if(progress > 1 || timeAtHit == 0){
      progress = 1;
    }
    float angle = map(progress, 0, 1, 0, TWO_PI); // Map progress to an angle
    
    // Draw the progress bar background
    fill(#233FD6, 50);
    strokeWeight(5);
    stroke(#233FD6, 100);
    arc(50, 100, 50, 50, 0, TWO_PI);
    
    // Draw the progress bar
    stroke(#233FD6);
    arc(50, 100, 50, 50, -HALF_PI, -HALF_PI + angle);
    
    progress = (timeNow - timeAtDash)/3000.0; // Change this value to update the progress
    if(progress > 1 || timeAtDash == 0){
      progress = 1;
    }
    
    if(timeAtDash != 0 && timeNow - timeAtDash <= 3200){
      // Draw the progress bar background
      strokeWeight(5);
      stroke(#8F00CE, 100);
      line(player.x - 50, player.y - 40, player.x + 50, player.y - 40);
      
      // Draw the progress bar
      if(timeNow - timeAtDash >= 3000){
        stroke(#8F00CE, 255 - (timeNow - timeAtDash - 3000));
      }else{
        stroke(#8F00CE);
      }
      line(player.x - 50, player.y - 40, player.x - 50 + progress * 100, player.y - 40);
    }
    
    //for(int i = 0; i < 4; i++){
    //  if(musicTest%4 == i){
    //    fill(255);
    //  }
    //  else{
    //    fill(100);
    //  }
    //  rect(width - 150 + i * 30, height - 40, 20, 20);
    //}
  }
}

void keyPressed(){
  if(menu){
    if(key == ENTER || key == RETURN){
      menu = false;
      timeStart = millis();
      nextRandomWave = timeNow + 1890;
      nextRandomWave2 = timeNow + 2390;
      nextFocusWave = timeNow + 1260;
      nextFocusWave2 = timeNow + 1760;
      musicNext = timeNow + 315;
      if(!musicPlaying){
        file.play();
        musicPlaying = true;
      }
      for(int i = 0; i < 4; i++){
        movement[i] = false;
      }
    }
  }
  else{
    if(key == 'w'){
      movement[0] = true;
    }
    else if(key == 's'){
      movement[1] = true;
    }
    else if(key == 'a'){
      movement[2] = true;
    }
    else if(key == 'd'){
      movement[3] = true;
    }
    else if(key == ' ' || key == 'x'){
      if(player.hasDash && player.isMoving){
        player.hasDash = false;
        player.isDashing = true;
        timeAtDash = timeNow;
      }
    }
    if(key == CODED){
      if(keyCode == UP){
        movement[0] = true;
      }
      else if(keyCode == DOWN){
        movement[1] = true;
      }
      else if(keyCode == LEFT){
        movement[2] = true;
      }
      else if(keyCode == RIGHT){
        movement[3] = true;
      }
    }
  }
}

void keyReleased(){
  if(!menu){
    if(key == 'w'){
      movement[0] = false;
    }
    else if(key == 's'){
      movement[1] = false;
    }
    else if(key == 'a'){
      movement[2] = false;
    }
    else if(key == 'd'){
      movement[3] = false;
    }
    if(key == CODED){
      if(keyCode == UP){
        movement[0] = false;
      }
      else if(keyCode == DOWN){
        movement[1] = false;
      }
      else if(keyCode == LEFT){
        movement[2] = false;
      }
      else if(keyCode == RIGHT){
        movement[3] = false;
      }
    }
  }
}

float calcDirection(){
  float direction = 0;
  if(movement[0] && movement[3]){
    direction = 1.75 * PI;
  }
  else if(movement[1] && movement[3]){
    direction = QUARTER_PI;
  }
  else if(movement[1] && movement[2]){
    direction = 0.75 * PI;
  }
  else if(movement[0] && movement[2]){
    direction = 1.25 * PI;
  }
  else if(movement[0]){
    direction = 1.5 * PI;
  }
  else if(movement[1]){
    direction = HALF_PI;
  }
  else if(movement[2]){
    direction = PI;
  }
  else if(movement[3]){
    direction = 0;
  }
  else{
    direction = -1.0;
  }
  return direction;
}

void addRandomLines(){
  nextRandomWave += int(1260 * 2 * floor(random(1, 3)));
  randomWaveNums.clear();
  float x;
  float y;
  float direction;
  int amount = score/50 + 5;
  for(int i = 0; i < amount; i++){
    int side = floor(random(4)); // up, right, down, left
    if(side == 0){
      x = random(-100, width + 100);
      y = -25;
      direction = randomGaussian() * HALF_PI + HALF_PI;
    }
    else if(side == 2){
      x = random(-100, width + 100);
      y = height + 25;
      direction = randomGaussian() * HALF_PI + 1.5 * PI;
    }
    else if(side == 1){
      x = width + 25;
      y = random(-100, height + 100);
      direction = randomGaussian() * HALF_PI + PI;
    }
    else{
      x = -25;
      y = random(-100, height + 100);
      direction = randomGaussian() * QUARTER_PI + QUARTER_PI;
      if(random(1) < 0.5){
        direction = -direction;
      }
    }
    float[] tuple = new float[3];
    tuple[0] = x;
    tuple[1] = y;
    tuple[2] = direction;
    randomWaveNums.add(tuple);
    lines.add(new PreviewLine(x, y, direction));
  }
}

void addRandomBullets(){
  nextRandomWave2 = nextRandomWave + 500;
  float speed = 5 + random(log(timeNow/1000));
  for(float[] nums: randomWaveNums){
    bullets.add(new Bullet(nums[0], nums[1], nums[2], speed));
  }
}

void addFocusLines(){
  if(timeNow - timeStart < 65500){
    nextFocusWave += 1260;
  }
  else{
    nextFocusWave += 630;
  }
  focusWaveNums.clear();
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
  int numLines = 0;
  int spacing = 0;
  if(score < 126){
    numLines = 5;
    spacing = 150;
  }
  else if(score < 177){
    numLines = 7;
    spacing = 120;
  }
  else if(score < 227){
    numLines = 9;
    spacing = 100;
  }
  else if(score < 288){
    numLines = 11;
    spacing = 90;
  }
  else{
    numLines = 21;
    spacing = 60;
  }
  for(int i = 0; i < numLines; i++){
    float tempx = x;
    float tempy = y;
    if(side == 0 || side == 2){
      tempx = x + (i - numLines/2) * spacing;
    }
    else{
      tempy = y + (i - numLines/2) * spacing;
    }
    direction = atan2(player.y - tempy, player.x - tempx);
    
    float[] tuple = new float[3];
    tuple[0] = tempx;
    tuple[1] = tempy;
    tuple[2] = direction;
    focusWaveNums.add(tuple);
    lines.add(new PreviewLine(tempx, tempy, direction));
  }
}

void addFocusBullets(){
  if(timeNow - timeStart < 65500){
    nextFocusWave2 += 1260;
  }
  else{
    nextFocusWave2 += 630;
  }
  float speed = 10;
  for(float[] nums: focusWaveNums){
    bullets.add(new Bullet(nums[0], nums[1], nums[2], speed));
  }
}

void displayStuff(){
  for(int i = lines.size() - 1; i >= 0; i--){
    PreviewLine thisLine = lines.get(i);
    thisLine.display();
    thisLine.update();
    if(thisLine.timer >= 60){
      lines.remove(i);
    }
  }
  
  for(int i = bullets.size() - 1; i >= 0; i--){
    Bullet bullet = bullets.get(i);
    bullet.display();
    bullet.update();
    if(bullet.timer >= 400){
      bullets.remove(i);
    }
  }
}
