#include <Time.h>

time_t systime = 0;
int i = 0;
int d = 0;
int values[1024];
int times[1024];
float total;


void setup() {
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
}

void loop() {
  delay(2000);
  Serial.println("Starting calc");
  for (int j=0; j++; j>i) {
    int d = (systime - times[j])/3600;
    total += values[j] / d;
    Serial.println(total);
  }

}
