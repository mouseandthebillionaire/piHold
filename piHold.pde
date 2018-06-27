int score;
int scene;
int musicSetting;
boolean acceptingKeypress;
boolean awaitingResponse;
boolean gameRunning, reset;
boolean crushing, delaying, filtering;

void setup(){
  loadVocals();
  loadMusic();
  resetGame();
}

void draw(){
  if(gameRunning){
    gameLoop();
  }
  if (!gameRunning){
    if(!reset){
      resetGame();
    }
  }
}

void gameLoop(){
  effectControl();
  switch(scene){
    case 0:
       // waiting for response
       break;
    case 1:
      // intro
      playVocal(scene, false);
      break;
    case 2:
      // intro
      playVocal(scene, true);
      break;
    case 3:
      // Hold Music
      output.setGain(0);
      holdTimer(20); // seconds
      break;
    case 4:
      // Are you a human person
       playVocal(scene, false);
      break;
    case 5: 
      // Are you from Earth?
       playVocal(scene, false);
      break;
    case 6:
      // Continent of your inception
      playVocal(scene, false);
      break;
    case 7:
      // Name or number
      delaying = true;
      playVocal(scene, false);
      break;
    case 8:
      // At the tone, state your name or number, first ramble and farmer question
      playVocal(scene, false);
      break;
    case 9:
      // positive / negative thoughts
      playVocal(scene, false);
      break;
    case 10:
      // is it jazzy enough?
      playVocal(scene, true);
      break;
    case 11:
      // Jazzy hold music
      crushing = false;
      filtering = false;
      delaying = false;
      getJazzy();
      holdTimer(20);
      break;
    case 12: 
      // Too much?
      playVocal(scene, true);
      break;
    case 13:
      // Ambient Music
      getAmbient();
      holdTimer(20);
      break;
    case 14:
      // Whistful
      playVocal(scene, false);
      break;
    case 15:
      // Goodbye
      stopHoldMusic();
      int ending;
      println(score);
      if(score > 5){
        ending = 15; 
      } else {
        ending = 16;
      }
      playVocal(ending, true);
      break;  
    case 17: 
      // Dial Tone
      hangUp();
      break;
  } 
}

void resetGame(){
  score = 0;
  acceptingKeypress = false;
  gameRunning = false;
  timerStatus = true;
  stopVocals();
  resetAudio();
  hungUp = false;
  scene = 1;
  reset = true;
}
