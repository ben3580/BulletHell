class DashTrail{
  ArrayList<float[]> trail;
  
  DashTrail(){
    trail = new ArrayList<>();
  }
  
  void addTrail(float x, float y){
    float[] temp = {x, y, 0};
    trail.add(temp);
  }
  
  void update(){
    for(int i = trail.size()-1; i >= 0; i--){
      float[] temp = trail.get(i);
      temp[2] += 1;
      if(temp[2] >= 60){
        trail.remove(i);
      }
    }
  }
  
  void display(){
    if(trail.size() > 0){
      float[] temp1 = trail.get(0);
      float[] temp2 = trail.get(trail.size()-1);
      strokeWeight(20);
      stroke(#8F00CE, int(150 - temp1[2] * 2));
      line(temp1[0], temp1[1], temp2[0], temp2[1]);
    }
  }
}
