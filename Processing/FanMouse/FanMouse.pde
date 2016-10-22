/**
 * Mouse Functions. 
 * 
 * Click on the box and drag it across the screen. 
 */
 import processing.serial.*;

Serial myPort; 
int inix=200,iniy=200;
int diffx,diffy;
int mousepress = 0;
float angle; 
int lastAngle = 5;
int test;
 
int bx;
int boxSize = 50;
boolean overBox = false;
boolean locked = false;
int xOffset = 0; 

void setup() {
  size(700, 360);
  bx = width/2;
  rectMode(RADIUS); 
    String portName = Serial.list()[0]; 
  myPort = new Serial(this, portName, 9600);
}

void draw() { 
  background(0);
  
  /////////////////////////////////////////////////////////////////////
   if(mousePressed==true && (mouseButton== RIGHT) && mousepress==1)
   {
     myPort.write('s');
     print("toggle");
     mousepress=0;
     delay(50);
     myPort.write(45);
     
   }    
   else if(mousePressed==false && mousepress==0)
   {
     mousepress=1;
   }
   ////////////////////////////////////////////////////////////////////

  else if (mouseX > bx-boxSize && mouseX < bx+boxSize ) {
    overBox = true;  
    if(!locked) { 
      stroke(255); 
      fill(153);
    } 
  } else {
    stroke(153);
    fill(153);
    overBox = false;
  }
  
  // Draw the box
  rect(bx,0, 30, 360);
}

void mousePressed() {
  if(overBox) { 
    locked = true; 
    fill(255, 255, 255);
  } else {
    locked = false;
  }
  xOffset = mouseX-bx; 

}

void mouseDragged() {
  if(mouseButton== LEFT){
  if(locked) {
    bx = mouseX-xOffset;
    angle= map(bx,0,700,0,90); 
  
  if(lastAngle != int(angle)){
    myPort.write(int(angle));
  print(byte(angle));
  print(" ");
  }
  }
  }
  
}

void mouseReleased() {
  locked = false;
}



void mouseWheel(MouseEvent event) 
{
  int e = event.getCount();
  if(e==1){
    myPort.write('i');
  }
  else if(e==-1){
    myPort.write('d');
  }
  
}