# solar-cell-profiling using a low power micro-computer
Hardware and software for power profiling a solar cell over a range of irradiances using cheap/easy to use hardware and software e.g. low power ADC/op-amps and raspberry pi/arduino 

## Introduction

A raspberry pi can be set up to measure voltages over time as a simple datalogger.  An ADC is connected to the IO pins of the pi and configured to take measurements and return the data to the Pi.  Data can then be sent to a remote server or stored locally or processed further.

## Guides
Mathworks [1] have a simple tutorial for setting this up with an LCD screen.	This uses the MCP3004 ADC [2] connected to the raspberry pi.

## Impedance
The input impedance of the ADC determines the current sunk by the ADC from the source which it is measuring.  When the input impedance is low compared to the output impedance of the source then there will be a voltage drop due to the ADC sinking current.  There are guides that show examples of this and address ways to counter it [3,4].	

## Hardware

The hardware used here is selected for ease of use and availability, including the procesor, sensors and other peripherals. It consists of: 
- MSP430G2553 Launchpad.  This is the demo board for the G2553 variant of the popular MSP430 MCU.
- LT1920 instrumentation amplifier.

### MCU
### Trans-Impedance Amplifier
This is used decrease the voltage drop imposed by the use of an ammeter in series within the monitoring circuit.  This allows a 1 Ohmm resistor to be used rather than the higher burden 1k.  As the currents measured here are typically low (uA - mA), to e.g. resolve a 1uA current without gain (i.e. to convert a 1uA current to 1mA - the maximum resolution of the 10-bit ADC used with a 1V reference) a 1K resistor would be needed.  This would then drop the voltage in the circuit by that amount.  By using a 1 Ohm resistor, that burden is reduced to an almost immeasurable 1 uA.

### Instrumentation amplifier
The **LT2910** instrumentation amplifier is used to amplify the signal from the trans-impedance amplifier.  The gain is variable from 1 to 10,00 and is determined by the value of the gain resistor, RG, connected across pins 1-8.  The gain for a given value of RG is given by
G = 1 + 49.4/RG
i.e. for a gain of 100, RG = 49.4 Ohms
An alternative is the AD8428 ^[6] which has a fixed gain of 2000

## Software
Simpel software running on a low power procesosr is to be created to read sensors and then save data in a remote server. It is designed to run on  the MSP-EXP430G2 launchpad ^[7],[8],[10].  This is used due to their availability, ease of use and low power operation
 
### Development environment
The Arduino-like Energia ^[9] development environment was used here due to the ease of use and the widespread availability of libraries.

## References
[1](http://makerzone.mathworks.com/resources/build-a-digital-voltmeter-using-raspberry-pi/) Mathworks, "Build a Digital Voltmeter Using Raspberry Pi" (2005)
[2](https://cdn-shop.adafruit.com/datasheets/MCP3008.pdf), Microchip, MCP3004 Datasheet (2008)
[3](http://www.ti.com/lit/an/spna088/spna088.pdf)
[4](http://www.ti.com/lit/an/sbaa090/sbaa090.pdf)
[5](http://cds.linear.com/docs/en/datasheet/1920f.pdf), LT21920 Datasheet
[6](http://www.analog.com/media/en/technical-documentation/data-sheets/AD8428.PDF), AD8428
[7](http://www.ti.com/tool/MSP-EXP430G2), MSP-EXP430G2 homepage
[9](http://energia.nu/pin-maps/guide_msp430g2launchpad/), Energia for launchpad
[10](http://www.ti.com/lsds/ti/tools-software/launchpads/launchpads.page), TI Launchpad Homepage
