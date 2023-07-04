import processing.sound.*;
import bpm.library.*;
import java.util.PriorityQueue;

SoundFile file;
BeatsPerMinute bpm;

boolean[] movement; // up, down, left, right / w, s, a, d
Player player;
AttackScheduler scheduler;
PriorityQueue<BulletWrapper> queuedBullets;
ArrayList<Bullet> activeBullets;
ArrayList<PreviewLine> lines;
int timeAtHit;
int timeAtDash;
int score;
int highScore;
int nextFocusWave;
boolean menu;
ArrayList<RandomText> randomText;

int timeStart;
int timeNow;

int beat;
int totalBeat;
boolean beatFlag;
boolean musicPlaying;

void setup(){
  fullScreen();
  ellipseMode(CENTER);
  
  movement = new boolean[4];
  player = new Player(width/2, height/2);
  scheduler = new AttackScheduler();
  timeAtHit = 0;
  timeAtDash = 0;
  queuedBullets = new PriorityQueue<>();
  activeBullets = new ArrayList<>();
  lines = new ArrayList<>();
  menu = true;
  score = 0;
  highScore = 0;
  randomText = new ArrayList<>();
  
  timeStart = 0;
  timeNow = 0;
  
  beat = 0;
  totalBeat = 0;
  beatFlag = true;
  musicPlaying = false;
  
  file = new SoundFile(this, "dog_nonstop_mix.wav");
  file.amp(0.3);
  
  bpm = new BeatsPerMinute(this, 380);
  bpm.showInfo = false;
}

void draw(){
  background(0);
  timeNow = millis();
  fill(255);
  textSize(20);
  text("FPS:", width-70, 30);
  text(int(frameRate), width-20, 30);
  if(menu){
    displayMenu();
  }
  else{
    
    beatFlag = bpm.every_once[1];
    if(beatFlag){
      beat++;
      totalBeat++;
      beatFlag = true;
      if(beat > 8){
        beat = 1;
      }
    }
    if(beatFlag){
      Attack atk = scheduler.query(totalBeat);
      if(atk != null){
        PreviewLine[] tempLines = atk.generateLines();
        for(int i = 0; i < tempLines.length; i++){
          lines.add(tempLines[i]);
        }
        BulletWrapper[] tempBullets = atk.generateBullets(timeNow);
        for(int i = 0; i < tempBullets.length; i++){
          queuedBullets.add(tempBullets[i]);
        }
      }
    }
    
    boolean flag = true;
    while(flag && queuedBullets.size() > 0){
      BulletWrapper tempBullet = queuedBullets.peek();
      if(timeNow >= tempBullet.time){
        activeBullets.add(queuedBullets.poll().bullet);
      }
      else{
        flag = false;
      }
    }
    
    float direction = calcDirection();
    boolean isMoving = true;
    if(direction < 0){
      isMoving = false;
    }
    
    player.update(direction, isMoving);
    player.display();
    boolean collision = player.checkCollision(activeBullets);
    if(collision){
      timeAtHit = timeNow;
      if(player.shield){
        player.shield = false;
      }
      else{
        player.lives -= 1;
        if(player.lives <= 0){
          player.lives = 5;
          if(score >= highScore){
            highScore = score;
          }
          menu = true;
          file.stop();
          musicPlaying = false;
          activeBullets.clear();
          queuedBullets.clear();
          lines.clear();
          bpm = new BeatsPerMinute(this, 193);
          beat = 0;
          totalBeat = 0;
        }
      }
    }
    if(player.invulnerable){
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
    
    bpm.run();
  }
}

void keyPressed(){
  if(menu){
    if(key == ENTER || key == RETURN){
      menu = false;
      timeStart = millis();
      nextFocusWave = timeNow + 1260;
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

void displayStuff(){
  for(int i = lines.size() - 1; i >= 0; i--){
    PreviewLine thisLine = lines.get(i);
    thisLine.display();
    thisLine.update();
    if(thisLine.timer >= 60){
      lines.remove(i);
    }
  }
  
  for(int i = activeBullets.size() - 1; i >= 0; i--){
    Bullet bullet = activeBullets.get(i);
    bullet.display();
    bullet.update();
    if(bullet.timer >= 400){
      activeBullets.remove(i);
    }
  }
}

void displayMenu(){
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
}
