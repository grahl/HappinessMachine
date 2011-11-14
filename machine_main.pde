#include <Time.h>
#include <Servo.h>
#include "HT1632.h"

#define DATA 2
#define WR   3
#define CS   4
#define CS2  5

HT1632LEDMatrix matrix = HT1632LEDMatrix(DATA, WR, CS);

time_t starttime = now();

int values[1024];

int count = 0;
int sum = 0;

int goodState=0;
int badState=0;

Servo myservo; 

//StackArray int stack; 

const int buttonGood = 32;
const int buttonBad = 33;

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

  matrix.begin(HT1632_COMMON_16NMOS);  
  matrix.fillScreen();
  delay(500);

}

void loop() {
  
  goodState = digitalRead(buttonGood);
  badState  = digitalRead(buttonBad);

  if (goodState == HIGH || badState == HIGH) {
    //  to be completed with RTC
    if (goodState == HIGH) {
      values[count] = 1;
      count++;
    } else if (badState == HIGH) {
      values[count] = -1;
      count++;
    }
    
    computeMood();
    ActionTime();
    
    lightLED();
  }
  delay(15);
//  testLED();
 


matrix.clearScreen(); 
   // draw a pixel!
  //matrix.drawPixel(0, 0, 1);
  matrix.drawPixel(7, 6, 1);  
  matrix.drawPixel(7, 7, 1);  
  matrix.drawPixel(7, 8, 1);
  matrix.drawPixel(8, 5, 1);
  matrix.drawPixel(8, 9, 1);
  matrix.drawPixel(9, 4, 1);
  matrix.drawPixel(9, 10, 1);
  matrix.drawPixel(9, 13, 1);
  matrix.drawPixel(10, 4, 1);
  matrix.drawPixel(10,10, 1);
  matrix.drawPixel(10,12, 1);
  matrix.drawPixel(11, 3, 1);
  matrix.drawPixel(11,10, 1);
  matrix.drawPixel(12, 3, 1);
  matrix.drawPixel(12,10, 1);
  matrix.drawPixel(13, 3, 1);
  matrix.drawPixel(13,10, 1);
  matrix.drawPixel(14, 4, 1);
  matrix.drawPixel(14,10, 1);
  matrix.drawPixel(15, 5, 1);
  matrix.drawPixel(15,10, 1);
  
  
  matrix.writeScreen();
  
  delay(500);
   // clear a pixel!
  matrix.drawPixel(0, 0, 0);
  matrix.drawPixel(11, 3, 0);
  matrix.drawPixel(12, 3, 0);
  matrix.drawPixel(13, 3, 0);
  matrix.writeScreen();
  delay(2000);

}


void computeMood() {
  Serial.println("Starting calc");
  
  sum = 0;
  
  for (int j=0;(values[j]==1 || values[j] == -1);j++) {
    //d = ( now() - starttime ) / 3600;
    sum += values[j];
    Serial.println(sum);
  }
  
}


void lightLED() {
  float tcalc = (float(sum) / float(count) );

  Serial.print("Summe: ");
  Serial.println(sum);
  
  Serial.print("Anzahl: ");
  Serial.println(count);
  
    
  Serial.print("Divisor: ");
  Serial.println(tcalc);
    
  int calc = int(tcalc * 100);
  
  Serial.print("Divisor * 100: ");
  Serial.println(calc);
  
  if (calc<24 && calc > -24) {
  
    resetLED();
    
  } else if (calc >= 24) {
    Serial.print(">24");
    digitalWrite(5,HIGH);
  
    if (calc >= 49) {
    Serial.print(">49");
      digitalWrite(6,HIGH);
      
      if (calc >= 74) {
            Serial.print(">74");
        digitalWrite(7,HIGH);
      }
      
    } 
    
  } else if (calc <= -24 ) {
    
    digitalWrite(4,HIGH);
    Serial.print("<24");
    if (calc <= -49) {
      Serial.print("<49");
      digitalWrite(3,HIGH);
      
      if (calc <= -74) {
        Serial.print("<74");
        digitalWrite(2,HIGH);
      }
      
    }
  } 

}

void ActionTime() {
  myservo.attach(10);
  myservo.write(60);
  flowLEDs(); 
  delay(2000);
  flowLEDs();
  delay(2000);
  resetLED();
  myservo.detach();
}

void flowLEDs() {
  resetLED();
  for (int j=2;j<=8;j++) {
    digitalWrite(j,HIGH);  
    delay(50);
  }
}


void resetLED() {
for (int j=2;j<=8;j++) {

    digitalWrite(j,LOW);  
  }
}

void testLED() {
for (int j=2;j<=8;j++) {

    digitalWrite(j,HIGH);  
}
}
