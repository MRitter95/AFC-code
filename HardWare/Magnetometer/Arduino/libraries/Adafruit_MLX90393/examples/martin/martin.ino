#include <Wire.h>

#include "Adafruit_MLX90393.h"

#define Addr1 0x0C
#define Addr2 0x0D
#define Addr3 0x0E
#define Addr4 0x0F

Adafruit_MLX90393 sensor  = Adafruit_MLX90393();
Adafruit_MLX90393 sensor1 = Adafruit_MLX90393();
Adafruit_MLX90393 sensor2 = Adafruit_MLX90393();
Adafruit_MLX90393 sensor3 = Adafruit_MLX90393();


void setup(void)
{
  Serial.begin(9600);

  /* Wait for serial on USB platforms. */
  while(!Serial) {
      delay(10);
  }

  //Serial.println("Starting Adafruit MLX90393 Demo");
  if (sensor.begin(Addr1)&&sensor1.begin(Addr2)&&sensor2.begin(Addr3)&&sensor3.begin(Addr4))
  {
    //Serial.println("Found all MLX90393 sensors");
  }
  else
  {
    Serial.println("No sensor found ... check your wiring?");
    while (1);
  }
}

void outputdat(Adafruit_MLX90393 sensor){
    float x,y,z;
    sensor.readData(&x,&y,&z);
    Serial.println(x);
    Serial.println(y);
    Serial.println(z);
    return;
}
    
void loop(void)
{
    float x, y, z;
/*
    if(sensor.readData(&x, &y, &z)) {
        Serial.print("X: "); Serial.print(x, 4); Serial.println(" uT");
        Serial.print("Y: "); Serial.print(y, 4); Serial.println(" uT");
        Serial.print("Z: "); Serial.print(z, 4); Serial.println(" uT");
    } else {
        Serial.println("Unable to read XYZ data from the sensor.");
    }

    if(sensor1.readData(&x, &y, &z)) {
        Serial.print("X1: "); Serial.print(x, 4); Serial.println(" uT");
        Serial.print("Y1: "); Serial.print(y, 4); Serial.println(" uT");
        Serial.print("Z1: "); Serial.print(z, 4); Serial.println(" uT");
    } else {
        Serial.println("Unable to read XYZ data from the sensor.");
    }

    if(sensor2.readData(&x, &y, &z)) {
        Serial.print("X2: "); Serial.print(x, 4); Serial.println(" uT");
        Serial.print("Y2: "); Serial.print(y, 4); Serial.println(" uT");
        Serial.print("Z2: "); Serial.print(z, 4); Serial.println(" uT");
    } else {
        Serial.println("Unable to read XYZ data from the sensor.");
    }

    if(sensor3.readData(&x, &y, &z)) {
        Serial.print("X3: "); Serial.print(x, 4); Serial.println(" uT");
        Serial.print("Y3: "); Serial.print(y, 4); Serial.println(" uT");
        Serial.print("Z3: "); Serial.print(z, 4); Serial.println(" uT");
    } else {
        Serial.println("Unable to read XYZ data from the sensor.");
    }
*/
    outputdat(sensor);
    outputdat(sensor1);
    outputdat(sensor2);
    outputdat(sensor3);
    delay(500);
}
