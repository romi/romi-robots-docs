The navigation control is managed by any Arduino compatible board. This board will receive direct instructions via RC control or commands through the Serial port sent by the _Raspberry pi_ in the [Camera Module](camera.md)

![](/assets/images/cablebot-schematic.png)

## Inputs
- Two endstops (2 interrupts)
- Position encoder (SPI)
- Motor encoder (1 interrupt)
- Battery voltage (from voltage dividerconnected to batt)
- RF speed channel (1 interrupts) we have a second channel with no use for now.
- USB or TX/RX only Serial port (via level shifter in case of 5v).
- IMU (I2C bus)
- Possible temperature/humidity sensor (Sensirion SHT35) (I2C bus)
- Charger connected input signal (1 interrupt)
- User button (1 interrupt)

## Outputs
- Motor control (PWM)
- User led (Addressable RGB)
- Navigation info vis Serial Port

## Brushless DC Motor with Encoder

![](/assets/images/cablebot-brushless.png)

The carrier use this [brushless motor](https://wiki.dfrobot.com/FIT0441_Brushless_DC_Motor_with_Encoder_12V_159RPM) with an integrated encoder. The Torque in this motor is small but no external control electronics are needed, it is being tested to see if the torque is enough to handle the carrier weight on a big range of cable tensions.

* Operating Voltage: 12V
* Motor Rated Speed: 7100-7300rpm
* Torque: 2.4kg*cm
* Speed: 159 rpm approx.
* Reduction ratio: 45:1
* Signal cycle pulse number: 45*6 (Each cycle outputs 6 pulse)
* Control mode: PWM speed control, Direction control, Feedback pulse output
* Weight 65g with kitchen scale.

!!!info "A higher torque motor is going to be tested"
	This motor has shown a lack of torque on hight tension cables, research to find a suitable higher torque replacement is on the works
	
## Remote control

As a way to control the carrier when no camera module is present or when the user needs to do simple and direct control for maintenance tasks a standard PWM remote control control is used.

 <figure>
  <img src="/assets/images/cablebot-rc.png"/>
  <figcaption>Exponential smoothing is used to remove noise on the RC signal.</figcaption>
</figure>

## Mouse laser motion sensor

![](/assets/images/cablebot-laser.png)

As a way to get real closed loop navigation the [ADNS-9800 Laser Motion Sensor](https://www.tindie.com/products/jkicklighter/adns-9800-laser-motion-sensor/) is being used to track the movement over the cable.
This sensor is still to be integrated in the latest prototype, tests are being made to warranty that the cable is always visible to the sensor independently of the tension level.

 <figure>
  <img src="/assets/images/cablebot-laser-position.png"/>
  <figcaption>Optimal position of the laser sensor.</figcaption>
</figure>

