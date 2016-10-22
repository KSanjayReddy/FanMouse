#include <Servo.h>
Servo myservo;
 char val; 
 int fan = 13; boolean toggle = false; 
 int reg= 12;
 int spd =0;
 int ang=0;
 bool start = false;
 
 
 void setup() {
 pinMode(fan, OUTPUT); 
 Serial.begin(9600);
 myservo.attach(3);
 myservo.write(90);
 Serial.flush();
 }
 
 void loop() {
 while (Serial.available()) {
  val = Serial.read();
 }
 if (val == 's')    { fanToggle(); start = true;}
 if (val == 'i')    { changeSpeed(1);}
 if (val == 'd')    { changeSpeed(2);}
 else{ ang = int(val);
 changeAngle(ang*2);}
 Serial.flush();
 }





 void fanToggle(){
  if(toggle == false){
    digitalWrite(fan, HIGH);
    toggle = true;
  }else{
    digitalWrite(fan, LOW); 
    toggle = false;
  }
  val = ' ';
 }

 void changeSpeed(int x){
  if(x == 1 && spd <255){
    spd+= 30;
    val = ' ';
 }
 else if( x==2 && spd>0){
  spd-= 30;
  val = ' ';
 }
 analogWrite(reg,spd);
 }

void changeAngle(int ang){
  myservo.write(ang);
  delay(10);
  }
