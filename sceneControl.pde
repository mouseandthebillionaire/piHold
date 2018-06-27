int startTime;
boolean timerStatus;

AudioPlayer[] vocals = new AudioPlayer[18];

void loadVocals(){
  println("Loading Vocals");
  
  minim = new Minim(this);
  
  // load vocals
  for(int i = 0; i < vocals.length; i++){
    String ftl = "vocalStings/" + i + ".wav";
    vocals[i] = minim.loadFile(ftl);
  }
}

void playVocal(int _scene, boolean automatic){
  
  // Play the Vocal
  if(!vocals[_scene].isPlaying()){
    // If we're passed the initial welcome
    if(scene > 2){
        // Turn Music Down
        output.setGain(-10);
      }
    vocals[_scene].play();
    // if this is scene 6, we can accept user input at any time
    if(scene == 6) acceptingKeypress = true;
  } 
  
  // Vocal has finished
  if(vocals[_scene].position() >= vocals[_scene].length()){
    if(!automatic){
      // if we're passed the initial welcome screen
      if(_scene > 2){
        // Turn Music Back Up
        output.setGain(0);
      }
      if(_scene > 6){
        output.setGain(-10);
      }
      // Wait for a KeyPress
      acceptingKeypress = true;
    } else {
      if(_scene == 15 || _scene == 16){
        scene = 17;
      } else {
      scene++;
      }
    }
  }
}

void stopVocals(){
  for(int i=0; i < vocals.length; i++){
    if(vocals[i] != null){
      if(vocals[i].isPlaying()){
        vocals[i].pause();
      }
      // make sure all vocal starts from the beginning  
      vocals[i].cue(0);
    }
  }
}

void holdTimer(int _holdTime){
  int holdTime = _holdTime * 1000;
  if(timerStatus){
    startTime = millis();
    timerStatus = false;
  }
  int timeElapsed = millis() - startTime;
  if(timeElapsed > holdTime){
    scene++;
    timerStatus = true;
  }
}
