import java.util.Arrays;

class AttackScheduler{
  
  int specialDelay;
  
  AttackScheduler(){
    specialDelay = 0;
  }
  
  Attack query(int totalBeat){
    specialDelay--;
    Attack atk = null;
    if(totalBeat < 9){
      atk = null;
    }
    else if(totalBeat < 289){
      if( totalBeat % 8 == 1){
        atk = new NormalAtk(5);
      }
    }
    else if(totalBeat < 353){
      if(totalBeat % 4 == 1){
        atk = new StraightAtk(1);
      }
    }
    else if(totalBeat < 385){
      if(totalBeat % 2 == 1){
        atk = new StraightAtk(1);
      }
    }
    else if(totalBeat < 409){
      atk = new StraightAtk(1);
    }
    else if(totalBeat < 417){
      if(totalBeat % 2 == 1){
        atk = new StraightAtk(2);
      }
    }
    else if(totalBeat < 801){
      if(totalBeat % 4 == 1){
        atk = new NormalAtk(5);
      }
    }
    else if(totalBeat < 1057){
      if(totalBeat % 4 == 1){
        if(specialDelay < 0 && random(0, 1) < 0.1){
          specialDelay = 10;
          atk = new SkyAtk();
        }
        else{
          atk = new LineAtk();
        }
      }
    }
    else if(totalBeat < 1121){
      if(totalBeat % 8 == 1){
        atk = new NormalAtk(5);
      }
    }
    else if(totalBeat < 1377){
      if(totalBeat % 16 == 1){
        if(random(0, 1) < 0.7){
          atk = new CircleAtk();
        }
        else{
          atk = new CircleAtk2();
        }
      }
    }
    else if(totalBeat < 1441){
      if(totalBeat % 8 == 1){
        atk = new NormalAtk(5);
      }
    }
    else if(totalBeat < 1505){
      if(totalBeat % 8 == 2){
        atk = new StraightAtk(1);
      }
      else if(totalBeat % 8 == 4){
        atk = new StraightAtk(2);
      }
      else if(totalBeat % 8 == 6){
        atk = new StraightAtk(3);
      }
      else if(totalBeat % 8 == 0){
        atk = new StraightAtk(4);
      }
    }
    else if(totalBeat < 1697){
      if(totalBeat % 8 == 1){
        if(specialDelay < 0 && random(0, 1) < 0.33){
          specialDelay = 10;
          atk = new StraightAtk(10);
        }
        else{
          atk = new StraightAtk(5);
        }
      }
    }
    else if(totalBeat < 1825){
      if(totalBeat % 8 == 1){
        atk = new NormalAtk(1);
      }
    }
    else if(totalBeat < 1889){
      if(totalBeat % 4 == 1){
        atk = new NormalAtk(5);
      }
    }
    // CHIMES
    else if(totalBeat < 1953){
      int[] beatList = {1889, 1895, 1897, 1903, 1905, 1911, 1912, 1913, 1915, 1917, 1919, 1921, 1927, 1929, 1935, 1937, 1941, 1943, 1945, 1947, 1949, 1951};
      for(int beat: beatList){
        if(beat == totalBeat){
          atk = new TopDownAtk(3);
          break;
        }
      }
    }
    else if(totalBeat < 2657){
      if(totalBeat % 4 == 1){
        if(specialDelay < 0 && random(0, 1) < 0.1){
          specialDelay = 20;
          atk = new RandomAtk(50);
        }
        else{
          atk = new NormalAtk(9);
        }
      }
    }
    else if(totalBeat < 2785){
      if(totalBeat % 8 == 1){
        atk = new NormalAtk(1);
      }
    }
    // CHIMES
    else if(totalBeat < 2945){
      int[] beatList = {2785, 2793, 2801, 2813, 2817, 2825, 2833, 2849, 2857, 2865, 2873, 2877, 2881, 2889, 2895, 2896, 2897, 2905, 2909, 2913, 2929};
      for(int beat: beatList){
        if(beat == totalBeat){
          atk = new TopDownAtk(3);
          break;
        }
      }
    }
    else if(totalBeat < 3073){
      if(totalBeat % 8 == 1){
        atk = new NormalAtk(5);
      }
    }
    // CHIMES
    else if(totalBeat < 3201){
      int[] beatList = {3073, 3081, 3089, 3097, 3105, 3113, 3121, 3129, 3137, 3153, 3161, 3169, 3185, 3193};
      for(int beat: beatList){
        if(beat == totalBeat){
          atk = new TopDownAtk(3);
          break;
        }
      }
    }
    else if(totalBeat < 3329){
      if(totalBeat % 8 == 1){
        atk = new NormalAtk(1);
      }
    }
    else if(totalBeat < 3585){
      int[] beatList = {3333, 3335, 3337, 3343, 3345, 3351, 3352, 3353, 3355, 3357, 3359, 3361, 3365, 3369, 3373, 3377, 3387, 3389, 3391, 3393, 3399, 3401, 3407, 3409, 3415, 3416, 3417, 3419, 3421, 3423, 3425, 3429, 3431, 3433, 3436, 3439, 3441, 3449};
      int[] beatList2 = Arrays.copyOf(beatList, beatList.length);
      for(int i = 0; i < beatList.length; i++){
        if(i == 0){
          beatList2[i] += 124;
        }
        else{
          beatList2[i] += 128;
        }
      }
      for(int i = 0; i < beatList.length; i++){
        if(totalBeat == beatList[i]){
          atk = new NormalAtk(1);
          break;
        }
        if(totalBeat == beatList2[i]){
          atk = new NormalAtk(3);
          break;
        }
      }
    }
    else if(totalBeat < 3729){
      int[] beatList = {3609, 3612, 3615, 3617, 3641, 3644, 3647, 3649, 3655, 3657, 3663, 3665, 3671, 3672, 3673, 3675, 3677, 3679, 3681, 3687, 3689, 3695, 3697, 3701, 3703, 3705, 3707, 3709, 3711};
      for(int beat: beatList){
        if(beat == totalBeat){
          atk = new TopDownAtk(3);
          break;
        }
      }
    }
    else if(totalBeat < 3857){
      if(totalBeat % 8 == 1){
        atk = new CircleAtk();
      }
    }
    else if(totalBeat < 3985){
      if(totalBeat % 4 == 1){
        float randomNum = random(0, 1);
        if(randomNum < 0.25){
          atk = new NormalAtk(5);
        }
        else if(randomNum < 0.5){
          atk = new StraightAtk(5);
        }
        else if(randomNum < 0.75){
          atk = new LineAtk();
        }
        else{
          atk = new CircleAtk();
        }
      }
    }
    else if(totalBeat < 4177){
      atk = null;
    }
    else if(totalBeat < 5000){
      if(totalBeat % 4 == 1){
        if(specialDelay < 0 && random(0, 1) < 0.3){
          specialDelay = 50;
          atk = new GeometryAtk();
        }
        else{
          atk = new NormalAtk(15);
        }
      }
    }
    return atk;
  }
}
