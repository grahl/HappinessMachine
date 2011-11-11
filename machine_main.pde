#include <Time.h>
#include <Servo.h>
//#include <StackArray.h>

time_t starttime = now();

int values[1024];

int count = 0;
int sum = 0;

int goodState=0;
int badState=0;

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
    lightAction();
    
    lightLED();
  }
  delay(15);
//  testLED();
  
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

void lightAction() {
  for (int j=2;j<=8;j++) {

    digitalWrite(j,HIGH);  
  }
  delay(600);
  resetLED();
/*  delay(600);

for (int j=2;j<=8;j++) {

    digitalWrite(j,HIGH);  
  }
  delay(600);
  resetLED();
  delay(600);

for (int j=2;j<=8;j++) {

    digitalWrite(j,HIGH);  
  }
  delay(600);
  resetLED(); */
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
