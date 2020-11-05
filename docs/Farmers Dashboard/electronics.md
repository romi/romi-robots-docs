
![](/assets/images/farmersDashboard/electronics-map.png)

The navigation control is managed by any Arduino compatible board. This board will receive direct instructions via RC control or commands through the Serial port sent by the _Raspberry pi_ in the [Camera Module.](camera.md)

![](/assets/images/farmersDashboard/cablebot-schematic.png)

!!! info ""
    General Mobile Carrier electronics schematic
    
For now an Arduino Nano (Atmega328) is used as the main microcontroller, the code has been kept easily portable to any Cortex M0 board like the Feather M0 basic used in the Camera module.

| **INPUTS**                                      | Notes                           |
| ---                                             | ---                             |
| Endstops                                        | 2 interrupts                    |
| Laser position encoder                          | SPI                             |
| Motor encoder                                   | 1 interrupt                     |
| Battery voltage                                 | from voltage divider            |
| RF speed channel                                | 1 interrupts per channel        |
| Control commands USB or UART Serial port        | via level shifter in case of 5v |
| IMU                                             | I2C                             |
| Temperature / Humidity sensor (Sensirion SHT35) | I2C bus (on the works)          |
| Charger connected signal                        | 1 interrupt                     |
| User button                                     | 1 interrupt                     |

| **Outputs**     | Notes           |
| ---             | ---             |
| Motor control   | PWM             |
| User led        | Addressable RGB |
| Navigation info | Serial Port     |

## Brushless DC Motor with Encoder

![](/assets/images/farmersDashboard/cablebot-brushless.png)

The carrier use this [brushless motor](https://wiki.dfrobot.com/FIT0441_Brushless_DC_Motor_with_Encoder_12V_159RPM) with an integrated encoder. The Torque in this motor is small but no external control electronics are needed, it is being tested to see if the torque is enough to handle the carrier weight on a big range of cable tensions.

|||
| --- | --- |
| Operating Voltage | 12V |
| Motor Rated Speed| 7100-7300rpm
|                    Torque |                                                    2.4kg*cm |
|                     Speed |                                                     159 rpm |
|           Reduction ratio |                                                        45:1 |
| Signal cycle pulse number |                           45*6 (Each cycle outputs 6 pulse) |
|              Control mode | PWM speed control, Direction control, Feedback pulse output |
|                    Weight |                                      65g with kitchen scale |

!!!info "A higher torque motor is going to be tested"
	This motor has shown a lack of torque on hight tension cables, research to find a suitable higher torque replacement is on the works
	
## Remote control

As a way to control the carrier when no camera module is present or when the user needs to do simple and direct control for maintenance tasks a standard PWM remote control control is used.

![](/assets/images/farmersDashboard/cablebot-rc.png)

!!! note ""
    Exponential smoothing is used to remove noise on the RC signal.

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
