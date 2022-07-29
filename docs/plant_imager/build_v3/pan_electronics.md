# Pan arm electronics


## Pan motor

We replaced the original z-axis stepper motor by an hollow shaft stepper motor from _stepperonline_ `23HS18-2004H`.
Full specifications can be accessed [here](https://www.omc-stepperonline.com/fr/biaxial-nema-23-arbre-creux-moteur-pas-a-pas-bipolar-0-78-nm-110-5oz-in-2-0a-57x57x45mm-23hs18-2004h).

Wiring of `23HS18-2004H`:

| A+  |    A-     |     B+      |  B-   |
|:---:|:---------:|:-----------:|:-----:|
| red | red/white | green/white | green |

The original motor was `KL23H251-28-4AP` from Automation Technology.
Full specifications can be accessed [here](KL23H251-28-4AP).

Wiring of `KL23H251-28-4AP`:

| Phase |  A+   | A-  |  B+   |  B-   |
|:-----:|:-----:|:---:|:-----:|:-----:|
|  Pin  |   A   |  C  |   B   |   D   |
| Color | white | red | green | black |


Thus, the re-wiring looks like this:

- X-Carve white wire -> HS stepper red wire
- X-Carve red wire -> HS stepper red/white wire
- X-Carve green wire -> HS stepper green/white wire
- X-Carve black wire -> HS stepper green wire


## Incremental rotary encoder

The encoder has 4800 steps and this is too fine for the arduino to see.
From our tests, it seems very stable at 360.

### Change the steps resolution

- get the AMT Cable & the AMT Viewpoint Programming Cable (parts 16 & 17 from the BOM list)
- load the [ATM Viewpoint software](https://www.cuidevices.com/amt-viewpoint) (Windows only)
- set the resolution to `360`.
- make sure you then align the `0` again after you change resolution.

If that does not work:

- Drink a beer
- Try again
- Repeat as necessary.


### Testing with an Arduino

#### Wiring

To test the encoder with an Arduino UNO, wire the encoder a follows:

* Encoder Pin 12 Z+ (blue) -> Arduino Pin 11
* Encoder Pin 13 Z- (blue & white) -> Arduino GND
* Encoder Pin 04 GND (green & Brown) -> Arduino GND
* Encoder Pin 06 +5V (red) -> Arduino +5

You can also wire two switches to PIN9 & GND and to PIN10 and GND of the UNO.
It is also possible to wire just one switch and swap PINs during the homing procedure, but beware of shortcuts.


#### Test

To test the encoder, we recommend to use the _serial monitor_ of the Arduino IDE as you can select `Both NL & CR` as EOL.

1. Pull the Arduino script `libromi/firmware/Oquam/Oquam.ino` from the `encoder_z` branch of the `libromi` repository.
2. Then build / upload, refers to the detailed flashing [instructions](flashing_oquam.md#flash-the-firmware).
3. Using the _serial monitor_ of the Arduino IDE, deactivate the X & Y axes (disables axes `0` & `1`, and enables `2`) by sending:
    ```shell
    #h[-1,-1,2]:xxxx
    ```
4. Then test the homing procedure for the theta axis by sending:
    ```shell
    #H:xxxx
    ```
    While the board is _waiting for homing_, turn the encoder, once you hit the `0` you will see a "homing complete" message.
5. Now, let's try to home all axis. So activate all of them with:
    ```shell
    #h[0,1,2]:xxxx
    ```
6. Then test the homing procedure for all axes by sending:
    ```shell
    #H:xxxx
    ```
    While the board is _waiting for homing_, press the X switch, then the Y switch and finally turn the encoder.
    When you release the switches you will see a "homing complete" message.
    Again, with the encoder, once you hit the `0` you will see a "homing complete" message.

!!! important
    The `RomiSerial` expect both "newline" (NL) AND "carriage return" (CR)!
    So you have to select `Both NL & CR` instead of the default `Newline` in the serial monitor of the Arduino IDE.


### X-Carve controller

#### Wiring

Simply wire the rotary encoder Z+/Z- pins to the red/black Z-limit wires:

* Encoder Pin 12 Z+ (blue) -> red Z-limit wire of the X-Carve controller
* Encoder Pin 13 Z- (blue & white) -> black Z-limit wire of the X-Carve controller
* Encoder Pin 04 GND (green & Brown) -> black wire (-) of the 24/5V DC converter
* Encoder Pin 06 +5V (red) -> red wire (+) of the 24/5V DC converter

#### Test

With the `Oquam` firmware flashed on the X-Controller (instructions [here](flashing_oquam.md)) and the correct wiring:

1. Open the Arduino IDE
2. Plug the USB from the X-Controller to your computer
3. Select the right USB port (assume `ttyUSB0`)
4. Open the _serial monitor_ of the Arduino IDE, select `Both NL & CR`, send:
    ```shell
    #h[0,1,2]:xxxx
    #H:xxxx
    ```
    The X-Carve should home X & Y axes, then you turn the encoder and when it hits home it should stop the homing process.
