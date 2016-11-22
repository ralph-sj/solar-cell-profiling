#include <Wire.h>
#include <Adafruit_ADS1015.h>

 Adafruit_ADS1115 ads;  /* Use this for the 16-bit version */
// Adafruit_ADS1015 ads;     /* Use thi for the 12-bit version */

unsigned char bh1750_address = 35;

unsigned int current_gain = 4;

void setup(void)
{
  Serial.begin(9600);
  Serial.println("Hello!");

  Wire.begin();        // join i2c bus (address optional for master)
  
  Serial.println("Getting differential reading from AIN0 (P) and AIN1 (N)");
  //Serial.println("ADC Range:  +/- 1.024V  1 bit = 0.015625mV");
  
  // The ADC input range (or gain) can be changed via the following
  // functions, but be careful never to exceed VDD +0.3V max, or to
  // exceed the upper and lower limits if you adjust the input range!
  // Setting these values incorrectly may destroy your ADC!
  //                                                                ADS1015  ADS1115
  //                                                                -------  -------
   ads.setGain(GAIN_TWOTHIRDS);  // 2/3x gain +/- 6.144V  1 bit = 3mV      0.1875mV (default)
  // ads.setGain(GAIN_ONE);        // 1x gain   +/- 4.096V  1 bit = 2mV      0.125mV
  // ads.setGain(GAIN_TWO);        // 2x gain   +/- 2.048V  1 bit = 1mV      0.0625mV
  // ads.setGain(GAIN_FOUR);       // 4x gain   +/- 1.024V  1 bit = 0.5mV    0.03125mV
  // ads.setGain(GAIN_EIGHT);      // 8x gain   +/- 0.512V  1 bit = 0.25mV   0.015625mV
  // ads.setGain(GAIN_SIXTEEN);    // 16x gain  +/- 0.256V  1 bit = 0.125mV  0.0078125mV
  
  ads.begin();
}

void loop(void)
{
  
  Wire.beginTransmission(bh1750_address); // transmit to device #35 (0x23)
  Wire.write(byte(0x10));            // sends instruction byte  
  Wire.endTransmission();    // stop transmitting
  Wire.requestFrom(bh1750_address,2);    // request 2 bytes from slave device #2
  unsigned int light = 0;
  light = ((Wire.read()<<8) | (Wire.read())); // receive a byte as character
  Serial.print(light);
  Serial.print("," );

  int16_t results, results1;
  float multiplier;
  
  /* Be sure to update this value based on the IC and the gain settings! */
  // float   multiplier = 3.0F;    /* ADS1015 @ +/- 6.144V gain (12-bit results) */
  //float multiplier = 0.1875F; /* ADS1115  @ +/- 6.144V gain (16-bit results) */
  //  float   multiplier = 0.0078125F;    /* ADS1115 @ +/- 0.256V gain (16-bit results) */
  // float   multiplier = 0.015625F;    /* ADS1115 @ +/- 0.512V gain (16-bit results) */

  // read current
 switch (current_gain) {
    case 2:
      ads.setGain(GAIN_TWO);      // 2x gain   +/- 2.048V  1 bit = 0.0625mV
      multiplier = 0.0625F;      // 2x gain   +/- 2.048V  1 bit = 0.0625mV
      break;
    case 4:
      ads.setGain(GAIN_FOUR);       // 4x gain   +/- 1.024V  1 bit = 0.03125mV
      multiplier = 0.03125F;  // 4x gain   +/- 1.024V  1 bit = 0.03125mV
      break;
    case 8:
      ads.setGain(GAIN_EIGHT);      // 8x gain   +/- 0.512V  1 bit = 0.015625mV
      multiplier = 0.015625F;    // 8x gain   +/- 0.512V  1 bit = 0.015625mV
      break;
    case 16:
      ads.setGain(GAIN_SIXTEEN);    // 16x gain  +/- 0.256V  1 bit = 0.0078125mV
      multiplier = 0.0078125F;    // 16x gain  +/- 0.256V  1 bit = 0.0078125mV
      break;
    default:
      ads.setGain(GAIN_TWOTHIRDS);       // 2/3x gain +/- 6.144V  1 bit = 0.1875mV (default)
      multiplier = 0.03125F;    // 2/3x gain +/- 6.144V  1 bit = 0.1875mV (default)
      break;
  }
  results = ads.readADC_Differential_0_1();  
  
  // Read voltage
  ads.setGain(GAIN_TWO);  // 2x gain   +/- 2.048V  1 bit = 0.0625mV
  float   multiplier1 = 0.0625F;    // 2x gain   +/- 2.048V  1 bit = 0.0625mV
  results1 = ads.readADC_Differential_2_3();  

    
  //Serial.print("Differential: "); Serial.print(results); Serial.print("("); Serial.print(results * multiplier); Serial.println("mV)");
  //Serial.println(results);
  Serial.print(results * multiplier); // current
  Serial.print(",");
  Serial.println(results1 * multiplier1); // voltage
  delay(5000);
}
