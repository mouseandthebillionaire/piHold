import ddf.minim.*;
import ddf.minim.effects.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput output;

FilePlayer holdMusic;
AudioPlayer jazzyMusic;
AudioPlayer ambientMusic;
AudioPlayer phoneTones;

Summer dialTone = new Summer();

// Effects
Delay delay;
BitCrush bitCrush;
LowPassSP lpf;

//Control
float localBitCrush;
float localDelayTime;
float localDelayFreq;
float localCutoffFreq;

boolean hungUp;

void loadMusic(){
  println("Loading Music");
  output = minim.getLineOut();
  
  holdMusic = new FilePlayer(minim.loadFileStream("music/holdMusic_1.wav"));
  jazzyMusic = minim.loadFile("music/jazzy.wav");
  ambientMusic = minim.loadFile("music/ambient.wav");
    
  // Effects 
  delay = new Delay(0.1, 0, true, true);
  bitCrush = new BitCrush(16, output.sampleRate());
  lpf = new LowPassSP(2000, output.sampleRate());
   
  phoneTones = minim.loadFile("music/phoneTones.wav");
  
  holdMusic.loop();  
  holdMusic.patch(delay).patch(bitCrush).patch(lpf).patch(output);

  
  // Load the Dial Tone
  Oscil wave = new Oscil( Frequency.ofPitch("A4"), 0.3f, Waves.SINE );
  wave.patch( dialTone );
  wave = new Oscil( Frequency.ofPitch("C#5"), 0.3f, Waves.SINE );
  wave.patch( dialTone );
  wave = new Oscil( Frequency.ofPitch("E5"), 0.3f, Waves.SINE );
  wave.patch( dialTone );  
}

void playTone(int tonePressed){
  int cuePoint = tonePressed * 2000;
  phoneTones.cue(tonePressed * 2000);
  phoneTones.setLoopPoints(cuePoint, cuePoint + 500);
  phoneTones.loop();
}
      

void holdMusicPlayer(){
  if (musicSetting == 1){
    output.setGain(0);
  }
}

void effectControl(){
  //if(crushing){
  //    addCrusher();
  //}
  //if(filtering){
  //    addFilter();
  //}
  if(delaying){
      addDelay();
  }
} 

void addFilter(){
  float cutoff = (sin(localCutoffFreq) * 1000) + 1200;
  localCutoffFreq += 0.01;
  println(cutoff);
  lpf.setFreq(cutoff);
}
  

void addDelay(){
  float delayer = (sin(localDelayTime) + 1) /2;
  float freaker = (sin(localDelayFreq) + 1) /2;
  localDelayTime += 0.001;
  localDelayFreq += 0.0001;
  delay.setDelTime(delayer);
  delay.setDelAmp(freaker);
}

void addCrusher(){
  float crusher = 4 - (sin(localBitCrush) * 4) + 4;
  localBitCrush += 0.0001;
  println(crusher);
  
  bitCrush.setBitRes(crusher);
}

void getJazzy(){
  output.setGain(-60);
  holdMusic.pause();
  jazzyMusic.play();
}

void getAmbient(){
  jazzyMusic.pause();
  ambientMusic.play();
}

void hangUp(){
  if(!hungUp){
    dialTone.patch(output);
    output.setGain(-5);
    hungUp = true;
  } 
}

void resetHoldMusic(){
  println("Resetting Hold Music");
  dialTone.unpatch(output);
  bitCrush.setBitRes(16);
  delay.setDelTime(0.1);
  delay.setDelAmp(0);
  lpf.setFreq(2000);
  delaying = false;
  filtering = false;
  crushing = false; 
  holdMusic.loop();
}

void stopHoldMusic(){
  if(holdMusic.isPlaying()){
    println("Stopping Hold Music");
    holdMusic.pause();
  }
}

void resetAudio(){
  output.setGain(-60);
  jazzyMusic.cue(0);
  jazzyMusic.pause();
  ambientMusic.cue(0);
  ambientMusic.pause();
  stopHoldMusic();
  resetHoldMusic();
  println(output.getGain());
}
