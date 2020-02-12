void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

//set timings
const int readPeriod= 100; //read every second
const int numToAvg= 60; //every 60 data points, average and print result.

int j= 0;
float buf[numToAvg];
float sum= 0.0;

void loop() {
  // read the input on analog pin 0:
  float sensorValue = analogRead(A0)*5.0/1024.0;
  buf[j]= sensorValue;

  // reset counter, print to serial port
  j= j+1;
  if(j==numToAvg){
    j= 0;
    sum= 0;
    for(int k=0;k<numToAvg;k++){
      sum+= buf[k];
    }
    
    Serial.println(sum/numToAvg);
  }

  delay(readPeriod);
  
}
