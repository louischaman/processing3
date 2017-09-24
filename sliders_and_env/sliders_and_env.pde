/**
 *    This example shows how to use the event sending / callback mechanism.
 */

 import de.bezier.guido.*;
 
 Slider slider, attack, release, sustain, decay;
 
 float arcRadius = 100;
 
 Envelope env;
 
 void setup ()
 {
     size( 500, 500 );
     frameRate(30);
     Interactive.make(this);
     
     env = new Envelope();
    
     attack = new Slider ( 10, height-100, width-20, 10 );
     decay = new Slider ( 10, height-200, width-20, 10 );
     sustain = new Slider ( 10, height-300, width-20, 10 );
     release = new Slider ( 10, height-400, width-20, 10 );
     
     // set radiusChanged method as listener to valueChanged event from slider
     Interactive.on( attack, "valueChanged", this, "attackChanged" );
     Interactive.on( decay, "valueChanged", this, "decayChanged" );
     Interactive.on( sustain, "valueChanged", this, "sustainChanged" );
     Interactive.on( release, "valueChanged", this, "releaseChanged" );
    
 }
 
 void draw ()
 {
    background( 0 );
    env.step(0.1);
     ellipse ( width/2, height/2, env.get_level()*200, env.get_level()*200);
 }
 
 void radiusChanged ( float v )
 {
     arcRadius = map( v, 0, 1, 1, width/2-20 );
 }

  
 void attackChanged ( float v )
 {   
     v = 1/(v*5);
     print("Attack = ");
     println(v);
     env.set_attack(v);
 }
 void decayChanged ( float v )
 {
     v = 1/(v*5);
     print("Decay = ");
     println(v);
     env.set_decay(v);
 }
 void sustainChanged ( float v )
 {
     print("Sustain = ");
     println(v);
     env.set_sustain(v);
 }
 void releaseChanged ( float v )
 {
     v  = 1/(v*5);
     print("Release = ");
     println(v);
     env.set_release(v);
 }
 
 
void mousePressed(){
  env.note_on();
}

void mouseReleased(){
  
  env.note_off();
  
}

 
public class Envelope{
  float attack = 0.05;
  float decay = 0.1;
  float release = 0.1;
  float sustain = 0.8;
  
  Envelope (  ){ }
  
  
  int state = 4;
  // 0 = attack
  // 1 = decay
  // 2 = sustain
  // 3 = release
  // 4 = off
  
  float level = 0;
  
  void step(float dt){

    if(state == 0 & level + attack*dt >= 1){
      state = 1;
    }
    if(state == 1 & level  - decay*dt <sustain){
      state = 2;
    }
    if(state == 3 & level - release*dt <0){
      state = 4;
    }   
    
    
    if(state == 0){
      level = level + attack*dt;
    }
    else if(state == 1){
      level = level - decay*dt;
    }    
    else if(state == 2){
      level = sustain;
    }
    else if(state == 3){  
      level = level - release*dt;
    }    
    else if(state == 4){
      level = 0;
    }
    print("state = ");
    println(state);
    print("level = ");
    println(level);
    
    
    
  }
  
  float get_level(){
    return(level);
  }
  void set_attack(float attack_level){
    attack = attack_level;
  }
  void set_decay(float decay_level){
    decay = decay_level;
  } 
  void set_sustain(float sustain_level){
    sustain = sustain_level;
    if(sustain >1){
      sustain = 1;
    }
  }
  void set_release(float release_level){
    release = release_level;
  }
  
  
  void note_on(){
    state = 0;
  }
  void note_off(){
    state = 3;
  }
}