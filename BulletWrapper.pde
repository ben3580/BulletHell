class BulletWrapper implements Comparable<BulletWrapper>{
  int time;
  Bullet bullet;
  
  BulletWrapper(int time, Bullet bullet){
    this.time = time;
    this.bullet = bullet;
  }
  
  public int compareTo(BulletWrapper other){
    if(this.time == other.time){
      return 0;
    }
    else if(this.time < other.time){
      return -1;
    }
    else{
      return 1;
    }
  }
}
