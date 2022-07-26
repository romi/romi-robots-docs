# Pan arm electronics


## Pan motor

We replaced the original z-axis stepper motor has been replaced by an hollow shaft stepper motor from _stepperonline_ `23HS18-2004H`.
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
* Drink a beer
* Try again
* Repeat as necessary.


### Testing with an Arduino

#### Wiring

* Encoder Pin 12 Z+ (blue) -> Arduino Pin 11
* Encoder Pin 13 Z- (blue & white) -> Arduino GND
* Encoder Pin 04 GND (green & Brown) -> Arduino GND
* Encoder Pin 06 +5V (red) -> Arduino +5

#### Test

1. Pull the Arduino script `libromi/firmware/Oquam/Oquam.ino` from the `encoder_z` branch of the `libromi` repository.
2. Then build / upload.
3. Then with `picocom` send:
    ```shell
    #h[-1,-1,2]
    #H
    ```
    The first one disables Axis 0, 1, and enables 2 (disable X, Y enable Z).
    Then while waiting for homing turn the encoder.
    You will see 3 homing complete messages.
4. Once this works, you can send:
    ```shell
    #h[0,1,2]
    #H
    ```
    The X-Carve should home as normal (X & Y axes) and then you turn the encoder and when it hits home it should stop the homing process.

### X-Carve controller wiring

Simply wire the rotary encoder Z+/Z- pins to the red/black Z-limit wires:

* Encoder Pin 12 Z+ (blue) -> red Z-limit wire of the X-Carve controller
* Encoder Pin 13 Z- (blue & white) -> black Z-limit wire of the X-Carve controller
* Encoder Pin 04 GND (green & Brown) -> black wire (-) of the 24/5V DC converter
* Encoder Pin 06 +5V (red) -> red wire (+) of the 24/5V DC converter
