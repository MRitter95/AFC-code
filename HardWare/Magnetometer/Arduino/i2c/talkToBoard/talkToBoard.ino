// Distributed with a free-will license.
// Use it any way you want, profit or free, provided it fits in the licenses of its associated works.
// MLX90393
// This code is designed to work with the MLX90393_I2CS I2C Mini Module available from ControlEverything.com.
// https://www.controleverything.com/products
#include<Wire.h>
 
// MLX90393 I2C Address is 0x0C(12)
#define Addr1 0x0C
#define Addr2 0x0D
#define Addr3 0x0E
#define Addr4 0x0F
 
void setup(){
// Initialise I2C communication as MASTER
Wire.begin();
// Initialise serial communication, set baud rate = 9600
Serial.begin(9600);
}

void loop()
{
unsigned int data[7];

///////////////////////////////////////////////////////////////
//SENSOR 1
///////////////////////////////////////////////////////////////
// Start I2C Transmission
Wire.beginTransmission(Addr1);
// Start single meaurement mode, ZYX enabled
Wire.write(0x3E);
// Stop I2C Transmission
Wire.endTransmission();
 
// Request 1 byte of data
Wire.requestFrom(Addr1, 1);
 
// Read status byte
if(Wire.available() == 1)
{
unsigned int c = Wire.read();
}
delay(100);

// Start I2C Transmission
Wire.beginTransmission(Addr1);
// Send read measurement command, ZYX enabled
Wire.write(0x4E);
// Stop I2C Transmission
Wire.endTransmission();
 
// Request 7 bytes of data
Wire.requestFrom(Addr1, 7);
 
// Read 7 bytes of data
// status, xMag msb, xMag lsb, yMag msb, yMag lsb, zMag msb, zMag lsb
if(Wire.available() == 7);
{
data[0] = Wire.read();
data[1] = Wire.read();
data[2] = Wire.read();
data[3] = Wire.read();
data[4] = Wire.read();
data[5] = Wire.read();
data[6] = Wire.read();
}
 
// Convert the data
int xMag = data[1] * 256 + data[2];
int yMag = data[3] * 256 + data[4];
int zMag = data[5] * 256 + data[6];
 
// Output sensor 1 measurements to serial port
//Serial.println("Sensor 1");
Serial.println(xMag);
Serial.println(yMag);
Serial.println(zMag);
///////////////////////////////////////////////////////////////
//SENSOR 1
///////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////
//SENSOR 2
///////////////////////////////////////////////////////////////
// Start I2C Transmission
Wire.beginTransmission(Addr2);
// Start single meaurement mode, ZYX enabled
Wire.write(0x3E);
// Stop I2C Transmission
Wire.endTransmission();
 
// Request 1 byte of data
Wire.requestFrom(Addr2, 1);
 
// Read status byte
if(Wire.available() == 1)
{
unsigned int c = Wire.read();
}
delay(100);

// Start I2C Transmission
Wire.beginTransmission(Addr2);
// Send read measurement command, ZYX enabled
Wire.write(0x4E);
// Stop I2C Transmission
Wire.endTransmission();
 
// Request 7 bytes of data
Wire.requestFrom(Addr2, 7);
 
// Read 7 bytes of data
// status, xMag msb, xMag lsb, yMag msb, yMag lsb, zMag msb, zMag lsb
if(Wire.available() == 7);
{
data[0] = Wire.read();
data[1] = Wire.read();
data[2] = Wire.read();
data[3] = Wire.read();
data[4] = Wire.read();
data[5] = Wire.read();
data[6] = Wire.read();
}
 
// Convert the data
xMag = data[1] * 256 + data[2];
yMag = data[3] * 256 + data[4];
zMag = data[5] * 256 + data[6];
 
// Output sensor 2 measurements to serial port
//Serial.println("Sensor 2");
Serial.println(xMag);
Serial.println(yMag);
Serial.println(zMag);
///////////////////////////////////////////////////////////////
//SENSOR 2
///////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////
//SENSOR 3
///////////////////////////////////////////////////////////////
// Start I2C Transmission
Wire.beginTransmission(Addr3);
// Start single meaurement mode, ZYX enabled
Wire.write(0x3E);
// Stop I2C Transmission
Wire.endTransmission();
 
// Request 1 byte of data
Wire.requestFrom(Addr3, 1);
 
// Read status byte
if(Wire.available() == 1)
{
unsigned int c = Wire.read();
}
delay(100);

// Start I2C Transmission
Wire.beginTransmission(Addr3);
// Send read measurement command, ZYX enabled
Wire.write(0x4E);
// Stop I2C Transmission
Wire.endTransmission();
 
// Request 7 bytes of data
Wire.requestFrom(Addr3, 7);
 
// Read 7 bytes of data
// status, xMag msb, xMag lsb, yMag msb, yMag lsb, zMag msb, zMag lsb
if(Wire.available() == 7);
{
data[0] = Wire.read();
data[1] = Wire.read();
data[2] = Wire.read();
data[3] = Wire.read();
data[4] = Wire.read();
data[5] = Wire.read();
data[6] = Wire.read();
}
 
// Convert the data
xMag = data[1] * 256 + data[2];
yMag = data[3] * 256 + data[4];
zMag = data[5] * 256 + data[6];
 
// Output sensor 3 measurements to serial port
//Serial.println("Sensor 3");
Serial.println(xMag);
Serial.println(yMag);
Serial.println(zMag);
///////////////////////////////////////////////////////////////
//SENSOR 3
///////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////
//SENSOR 4
///////////////////////////////////////////////////////////////
// Start I2C Transmission
Wire.beginTransmission(Addr4);
// Start single meaurement mode, ZYX enabled
Wire.write(0x3E);
// Stop I2C Transmission
Wire.endTransmission();
 
// Request 1 byte of data
Wire.requestFrom(Addr4, 1);
 
// Read status byte
if(Wire.available() == 1)
{
unsigned int c = Wire.read();
}
delay(100);

// Start I2C Transmission
Wire.beginTransmission(Addr4);
// Send read measurement command, ZYX enabled
Wire.write(0x4E);
// Stop I2C Transmission
Wire.endTransmission();
 
// Request 7 bytes of data
Wire.requestFrom(Addr4, 7);
 
// Read 7 bytes of data
// status, xMag msb, xMag lsb, yMag msb, yMag lsb, zMag msb, zMag lsb
if(Wire.available() == 7);
{
data[0] = Wire.read();
data[1] = Wire.read();
data[2] = Wire.read();
data[3] = Wire.read();
data[4] = Wire.read();
data[5] = Wire.read();
data[6] = Wire.read();
}
 
// Convert the data
xMag = data[1] * 256 + data[2];
yMag = data[3] * 256 + data[4];
zMag = data[5] * 256 + data[6];
 
// Output sensor 4 measurements to serial port
//Serial.println("Sensor 4");
Serial.println(xMag);
Serial.println(yMag);
Serial.println(zMag);
///////////////////////////////////////////////////////////////
//SENSOR 4
///////////////////////////////////////////////////////////////
delay(1000);
}
