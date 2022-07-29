# Control electronics

The entire motion system is controlled by a low-cost and low-power microcontroller (Microchip SAMD21) that interfaces with the camera module. The much powerful computer in the camera module runs the main logics and communication subsystem based on the software and hardware stack used in the Rover, ensuring modularity and scalability.  As both the camera module and the Rover run the Raspberry PI ARM based Linux architecture our software stack is portable across each one of the robots. Those ensuring the Rover and the carrier use the same remote management interfaces. Following that approach the carrier can be managed using the same standard RC remote controller for on-site  maintenance operations.

![](/assets/images/farmersDashboard/electronics.png)

The Carrier module electronics is compossed by three main PCB's: the _control PCB_ that holds the man microcontroller on charge of the navigation, the Odrvie motor driver and the power ditribution PCB.

![](/assets/images/farmersDashboard/Cablebot-schematic.png)


## Control PCB

The navigation control is managed by any Arduino SAMD21 compatible board. This board will receive direct instructions via RC control or commands through the Serial port sent by the _Raspberry pi_ in the [Camera Module.](camera.md)

![](/assets/images/farmersDashboard/cablebot_controller_components.png)

### Inputs
- Two endstops (2 interrupts)
- Position encoder (SPI)
- Motor encoder (1 interrupt)
- Battery voltage (from voltage dividerconnected to batt)
- RF speed channel (1 interrupts) we have a second channel with no use for now.
- USB or TX/RX only Serial port (level converter?).
- IMU (I2C)
- Charger connected input (1 interrupt)
- User button (1 interrupt)

### Outputs
- Motor control (PWM)
- User led (Addressable RGB)

### Feather Pinout

| Feather M0 Pin | | Function | |Int|
|---|---|---|---|---|
| 0 - RX (Serial1) (yellow) | PA11 | _Odrive Serial_ GPIO1 → TX  | SERCOM0.3 |
| 1 - TX (Serial1) (green) | PA10 | _Odrive Serial_ GPIO2 → RX | SERCOM0.2 |
| 5 | PA15 | Addressable Led → DIN |||
| 6 | PA20 | Endstop Front or right (was Back ¹) | |🟢|
| 9 | PA07 | Endstop Back or left (was Front ¹) | |🟢|
| 10 - TX0 (green) | PA18 | Camera Module → RX | SERCOM1.2 |
| 11 | PA16 | RC → STR (Optional Gimbal control)| | 🟢 |
| 12 - RX0 (yellow) | PA19 | Camera Module → TX | SERCOM1.3 |
| 13 | PA17 | RC Throttle → THR ||🟢|
| 15 - A1 | PB08 | _Odrive Reset_ nRST (in J2) |
| 16 - A2 | PB09 | User Button | | 🟢|
| 17 - A3 | PA04 | Charging station home int | | 🟢|
| 18 - A4 | PA05 | ADNS → MOT |   |
| 19 - A5 | PB02 | ADNS → SS |   |
| 20 - SDA | PA22 | I2C → SDA | SERCOM3.0 |
| 21 - SCL | PA23 | I2C → SCL | SERCOM3.1 |
| 22 - MISO | PA12 | ADNS → MI | SERCOM_ALT4.0  |
| 23 - MOSI | PB10 | ADNS → MO | SERCOM_ALT4.2  |
| 24 - SCK | PB11 | ADNS → SC | SERCOM_ALT4.3 |
| RST | | Reset Button |


## Mouse laser motion sensor

![](/assets/images/farmersDashboard/cablebot-laser.png){: style="width:300px"}

As a way to get real closed loop navigation the [ADNS-9800 Laser Motion Sensor](https://www.tindie.com/products/jkicklighter/adns-9800-laser-motion-sensor/) is being used to track the movement over the cable.
This sensor is still to be integrated in the latest prototype, tests are being made to warranty that the cable is always visible to the sensor independently of the tension level.

![](/assets/images/farmersDashboard/cablebot-laser-position.png){: style="width:500px"}

!!! note ""
    Optimal position of the laser sensor.

## IMU

![](/assets/images/farmersDashboard/ISM330.png){: style="width:400px"}

An Inertial measurement unit is used to give feedback to the microcontroller about balance and vibrations, acceleration and speed algorithms to take advantage of this data are still under development.
The [ISM330](https://www.st.com/resource/en/datasheet/ism330dhcx.pdf) Adafruit QWIIC [breakout board](https://www.adafruit.com/product/4502) is being used through I2C bus.

[Compatible Adafruit library](https://github.com/adafruit/Adafruit_LSM6DS)
[Arduino library](https://github.com/stm32duino/ISM330DLC)

## Endstops

![](/assets/images/farmersDashboard/endStops.gif)

To detect collisions [OMRON D3V-013-1C23](https://www.components.omron.com/product-detail?partNumber=D3V) miniature switches are used as end stops on both sides of the cablebot. A 3d printed cover protects the electronic parts and trigers the switch when an obstacle is found. Cabling is routed through the structure to avoid any damage on the lines.

![](/assets/images/farmersDashboard/endstop-cable.png)

 The cabling is routed trough machined channels between the aluminum sandwich sheets keeping it protected and organized.


## Remote Control
Any radio frequency remote control with at least one channel can be used with the CARM. We use one PWM channel to control the speed along the cable. A second PWM channel is already wired to be used in the future, for example to control camera orientation.

We have used [HK-GT2B](https://hobbyking.com/en_us/hobbykingr-tmhk-gt2b-3ch-2-4ghz-transmitter-and-receiver-w-rechargable-li-ion-battery-1.html) model with good results.

* 2.4GHz AFHDS signal operation
* 3CH operation
* 3.7v 800mAh Rechargeable li-ion transmitter battery
* RF Power: 20dBm (100mW) max
* Modulation: GFSK
* Sensitivity: 1024
* Transmitter Weight: 270g
* Receiver power: 4.5~6.5 VDC

Depending on the RF hardware sometimes adjusting the signal top/down limits with the remote potentiometers is not enough, this values can be adjusted on firmware changing the `RC_CALIBRATION` constant values for Min, Middle and Max values [here](https://github.com/romi/romi-cablebot/blob/main/motor-controller/src/motor-controller.ino#L88).

To find out the values of your remote print to the console the value of the `rcSpeed` variable, some where in your `loop()` function and check the serial output while the trigger is at rest, top and bottom positions.

To minimize vibrations of the carrier module while operated with the RF remote control, the noise on the signal is cleaned, applying exponential smoothing to it.

![](/assets/images/farmersDashboard/cablebot-rc.png)
