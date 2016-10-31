# solar-cell-profiling using a raspberry pi
Hardware and software for power profiling a solar cell over a range of irradiances using cheap/easy to use hardware and software e.g. low power ADC/op-amps and raspberry pi/arduino 

## Introduction

A raspberry pi can be set up to measure voltages over time as a simple datalogger.  An ADC is connected to the IO pins of the pi and configured to take measurements and return the data to the Pi.  Data can then be sent to a remote server or stored locally or processed further.

## Guides
Mathworks [1] have a simple tutorial for setting this up with an LCD screen.	This uses the MCP3004 ADC [2] connected to the raspberry pi.

## Impedance
The input impedance of the ADC determines the current sunk by the ADC from the source which it is measuring.  When the input impedance is low compared to the output impedance of the source then there will be a voltage drop due to the ADC sinking current.  There are guides that show examples of this and address ways to counter it [3,4].	

## Hardware
The hardware used here is selecte for ease of use and availability, including the procesor, sensors and other peripherals.

## Software
Simpel software running on a low power procesosr is to be created to read sensors and then save data in a remote server.  This is expeacted to be run upon an arduino or raspberry pi.

## References
[1](http://makerzone.mathworks.com/resources/build-a-digital-voltmeter-using-raspberry-pi/) Mathworks, "Build a Digital Voltmeter Using Raspberry Pi" (2005)
[2](https://cdn-shop.adafruit.com/datasheets/MCP3008.pdf), Microchip, MCP3004 Datasheet (2008)
[3](http://www.ti.com/lit/an/spna088/spna088.pdf)
[4](http://www.ti.com/lit/an/sbaa090/sbaa090.pdf)
