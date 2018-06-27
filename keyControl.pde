char keys[] = {'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']'};
int tonePressed;

void keyPressed(){
  gameControl();
  effectKeyControl(); // for testing only
  
  // Keypad Control
  if(acceptingKeypress){
    if(keyPressed){
      // choose which type of keyboard input we are looking for
      switch(scene){
        case 4:
          // not a human immediately ends the game
          oneChoice();
          break;
        case 6:
          // accepting all 9 keys
          nineChoices();
          break;
        case 9:
          // looking for the pound key
          poundEnter();
          break;
        default:
          // all others accept "1" or "2"
          basicSceneInput();
          break;
      }
    }
  }
  
  
  //basicSceneInput();
  keypadSounds();
     
}

void gameControl(){
  // Start/Stop Game via Hangup
  if(key == 'a'){
    if(!gameRunning){
      gameRunning = true;
    } else {
      reset = false;
      gameRunning = false;
    }
  }
}

void basicSceneInput(){
  if(key == 'w'){
    // Pressed 1
    scene++;
    score++;
    acceptingKeypress = false;
  } else if(key == 'e'){
    // Pressed 2
    scene++;
    score--;
    acceptingKeypress = false;
  } else {
    // Pressed Something Else
    acceptingKeypress = false;
    //error();
  }
}

void nineChoices(){
  if(key == 'q' || 
      key == 'w' || 
      key == 'e' || 
      key == 'r' || 
      key == 't' || 
      key == 'y' || 
      key == 'u' || 
      key == 'i' || 
      key == 'o' || 
      key == 'p'){
    vocals[scene].pause();
    scene++;
    score++;
    acceptingKeypress = false;
  }
}

void poundEnter(){
  if(key == ']'){
    scene ++;
    score++;
    acceptingKeypress = false;
  }
}

void oneChoice(){
  if(key == 'w'){
    // Pressed 1
    scene++;
    score++;
    acceptingKeypress = false;
  } else if(key == 'e'){
    // Pressed 2
    scene = 15;
    acceptingKeypress = false;
  } else {
    // Pressed Something Else
    acceptingKeypress = false;
    //error();
  }
}

void keypadSounds(){
  // Keypad Trigger Sounds
  if(keyPressed){
    for(int i=0; i < keys.length; i++){
      if(key == keys[i]){
        playTone(i);
      }
    }
  }  
}

void effectKeyControl(){
    if(key == 'z'){
    crushing = true;
  }
  if(key == 'x'){
    delaying = true;
  }
  if(key == 'c'){
    filtering = true;
  }
}

void keyReleased(){
  phoneTones.pause();
}
