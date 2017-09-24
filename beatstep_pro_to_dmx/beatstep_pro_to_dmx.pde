import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

import dmxP512.*;
import processing.serial.*;

DmxP512 dmxOutput;
int universeSize=128;

boolean LANBOX=false;
String LANBOX_IP="192.168.1.77";

boolean DMXPRO=true;
String DMXPRO_PORT="COM11";//case matters ! on windows port must be upper cased.
int DMXPRO_BAUDRATE=115000;


void setup() {
  size(400, 400);
  background(0);

  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  // Either you can
  //                   Parent In Out
  //                     |    |  |
  //myBus = new MidiBus(this, 0, 1); // Create a new MidiBus using the device index to select the Midi input and output devices respectively.

  // or you can ...
  //                   Parent         In                   Out
  //                     |            |                     |
  //myBus = new MidiBus(this, "IncomingDeviceName", "OutgoingDeviceName"); // Create a new MidiBus using the device names to select the Midi input and output devices respectively.

  // or for testing you could ...
  //                 Parent  In        Out
  //                   |     |          |
  myBus = new MidiBus(this, 2, -1); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
 
  dmxOutput=new DmxP512(this,universeSize,false);
  
  if(LANBOX){
    dmxOutput.setupLanbox(LANBOX_IP);
  }
  
  if(DMXPRO){
    dmxOutput.setupDmxPro(DMXPRO_PORT,DMXPRO_BAUDRATE);
  }

    dmxOutput.set(1,255);
    
    dmxOutput.set(2,255);
    
    dmxOutput.set(3,255);
}

void draw() {
  int channel = 0;
  int pitch = 64;
  int velocity = 127;

  myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
  delay(200);
  myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff

  int number = 0;
  int value = 90;

  myBus.sendControllerChange(channel, number, value); // Send a controllerChange
  delay(2000);
}

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
  
  if(pitch == 24){
    dmxOutput.set(1,255);
  }
  if(pitch == 25){
    dmxOutput.set(7,255);
  }
    
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
    if(pitch == 24){
    dmxOutput.set(1,0);
  }
      if(pitch == 25){
    dmxOutput.set(7,0);
  }
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
  
  if(number == 10){
    dmxOutput.set(1,value*2);
  }
  if(number == 114){
    dmxOutput.set(2,value*2);
  }
  if(number == 74){
    dmxOutput.set(3,value*2);
  }
  if(number == 18){
    dmxOutput.set(4,value*2);
  }
  
  int j = 6;
    if(number == 10){
    dmxOutput.set(1+j,value*2);
  }
  if(number == 114){
    dmxOutput.set(2+j,value*2);
  }
  if(number == 74){
    dmxOutput.set(3+j,value*2);
  }
  if(number == 18){
    dmxOutput.set(4+j,value*2);
  }
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}