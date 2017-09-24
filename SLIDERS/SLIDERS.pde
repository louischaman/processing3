/*
 The GCustomSlider control replaces the GWSlider, a control
 created as part of the Processing library `gwoptics' 
 http://www.gwoptics.org/processing/gwoptics_p5lib/

 The GCustomSlider has all the capabilities of the original
 control but also has the capabilities of the GSlider in that
 it can be rotated to any angle and user controllable text
 orientation.
 
 This sketch simply demonstrates some of the features and 
 skins available with this library.
 
 To try out different configurations trye the example
 G4P_CustomSlider_Config.
 
 for Processing V2 and V3
 (c) 2015 Peter Lager
 
 */

import g4p_controls.*;

GCustomSlider sdr1, sdr2, sdr3, sdr4, sdr5, sdr6, sdr7;

void setup() {
  size(600, 280);  

  //=============================================================
  // Simple default slider,
  // constructor is `Parent applet', the x, y position and length
  sdr1 = new GCustomSlider(this, 20, 20, 260, 50, null);
  // show          opaque  ticks value limits
  sdr1.setShowDecor(false, true, true, true);
  sdr1.setNbrTicks(5);
  sdr1.setLimits(40, 0, 100);
  
  
  sdr2 = new GCustomSlider(this, 20, 100, 260, 50, null);
  // show          opaque  ticks value limits
  sdr2.setShowDecor(false, true, true, true);
  sdr2.setNbrTicks(5);
  sdr2.setLimits(40, 0, 100);
  
  
 
}

void draw() {
  background(200, 200, 255);
  
}

void handleSliderEvents(GSlider slider) {
  println("integer value:" + slider.getValueI() + " float value:" + slider.getValueF());
}