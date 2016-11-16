#include <Wire.h>
#include "Adafruit_ADS1015.h"
// RSJ
// Adafruit_ADS1115 ads;  /* Use this for the 16-bit version */
// Adafruit_ADS1015 ads;     /* Use thi for the 12-bit version */

#define LED RED_LED
#define RegConfig 0x01 // default reading of confi registers (UB,LB)is 0x8583 = 0d34179

unsigned char i2c_address = 72; // address of ADS1115 with ADR->GND = 0x84 = 0d72

void setup()
{
  pinMode(LED, OUTPUT);     
  Wire.begin();        // join i2c bus (address optional for master)
  Serial.begin(9600);  // start serial for output
  Serial.print("Setup complete");
}

void loop()
{
  Wire.beginTransmission(i2c_address);   // transmit to device
  Wire.write(RegConfig);                // sends instruction byte  
  Wire.endTransmission();              // stop transmitting
  Wire.requestFrom(i2c_address,2);    // request 2 bytes from slave device #2
  
  unsigned int ConfigRegister = 0;
  ConfigRegister = ((Wire.read()<<8) | (Wire.read())); // receive a byte as character
  Serial.println(ConfigRegister);

  digitalWrite(LED, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(500);               // wait for a second
  digitalWrite(LED, LOW);    // turn the LED off by making the voltage LOW
  delay(500);               // wait for a second
}
