#include <Time.h>
#include <Servo.h>

time_t systime = 0;
int i = 0;
int d = 0;
int values[1024];
int times[1024];
int total;

Servo myservo;

int goodState=0;
int badState=0;

const int buttonGood = 30;
const int buttonBad = 31;

void setup() {

  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(7, OUTPUT);

  pinMode(buttonGood,INPUT);
  pinMode(buttonBad,INPUT);

  Serial.begin(9600);
  values[0] = 1;
  values[1] = -1;
  values[2] = 1;
  values[3] = -1;
  values[4] = 1;
  values[5] = -1;
  values[6] = 1;
  values[7] = -1;
  values[8] = 1;
  values[9] = -1;
  times[0]  = 1000;
  times[1]  = 1000;
  times[2]  = 2000;
  times[3]  = 3000;
  times[4]  = 4000;
  times[5]  = 4100;
  times[6]  = 4200;
  times[7]  = 4300;
  times[8]  = 4400;
  times[9]  = 4500;
  i=9;

  myservo.attach(10);  

}

void loop() {
  goodState = digitalRead(buttonGood);
  badState  = digitalRead(buttonBad);

  if (goodState == HIGH || badState == HIGH) {
    computeMood();
    total+=1;
    lightLED(total);
  }
  //Serial.println(myservo.read());
  //myservo.write(2);
  delay(15); 
}


void computeMood() {
  Serial.println("Starting calc");
  for (int j=0;j<i;j++) {
    int d = (systime - times[j])/3600;
    total += values[j] / d;
    Serial.println(total);
  }
}


void lightLED(int value) {

  for (int j=2;j<7;j++) {

    digitalWrite(j,LOW);  
  }

  for (int j=1;j<=value;j++) {

    digitalWrite(j+1,HIGH);
  }

}

