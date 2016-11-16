// Wire Master Reader
// by Nicholas Zambetti <http://www.zambetti.com>

// Demonstrates use of the Wire library
// Reads data from an I2C/TWI slave device
// Refer to the "Wire Slave Sender" example for use with this

// Created 29 March 2006

// This example code is in the public domain.


#include <Wire.h>
#define LED RED_LED
#define VCC 3572  // vcc in mV
#define ADC 3

unsigned char i2c_address = 35;

void setup()
{
    pinMode(LED, OUTPUT);     

  Wire.begin();        // join i2c bus (address optional for master)
  Serial.begin(9600);  // start serial for output
  Serial.print("Setup complete");
}

void loop()
{
  Wire.beginTransmission(i2c_address); // transmit to device #35 (0x23)
                              // device address is specified in datasheet
  Wire.write(byte(0x10));            // sends instruction byte  
  Wire.endTransmission();    // stop transmitting

  Wire.requestFrom(i2c_address,2);    // request 2 bytes from slave device #2

//  while(Wire.available())    // slave may send less than requested
//  { 
//    char c = Wire.read(); // receive a byte as character
//    Serial.print(c);         // print the character
//  }
    unsigned int light = 0;
    light = ((Wire.read()<<8) | (Wire.read())); // receive a byte as character
    Serial.print(light);
    Serial.print("," );
  unsigned long sensorValue = analogRead(A3);
  sensorValue = (sensorValue * VCC)>>10;
  Serial.println(sensorValue);

  // digitalWrite(LED, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(500);               // wait for a second
  digitalWrite(LED, LOW);    // turn the LED off by making the voltage LOW
  delay(500);               // wait for a second
}
