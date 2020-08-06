Wiring the CNC
==============

If you have the recent version, follow the official wiring instrucions [here](http://x-carve-instructions.inventables.com/1000mm/step6/).


Here is [link](http://x-carve-instructions.inventables.com/xcarve2015/step10/) to the post 2015 version of the "wiring" instructions.

Here is [link](http://x-carve-instructions.inventables.com/xcarve2015/step14/) to the post 2015 version of the "electronic assembly" instructions.

## BOM

If you are familiar with the Arduino world, the electronic is pretty straightforward:

* Arduino UNO (official buy [here](https://store.arduino.cc/arduino-uno-rev3))
* Synthetos gShield (buy [here](https://synthetos.com/project/grblshield))
* Power converter 220V ac. - 24V dc. (buy @[Farnell](https://fr.farnell.com/mean-well/uhp-350r-24/alimentation-ac-dc-24v-14-6a/dp/3002726))
* Emergency stop button (buy @[Farnell](https://fr.farnell.com/idec/xw1e-lv411q4m-r/switch-emergency-stop-1no-1nc/dp/2787256))

Optional:

* 24V fan
* 220V power cord

!!! note
    Before 2017 X-Carve shipped 400W power units, now they use a 320W unit. The link is for a 350W unit.

## Wiring instructions

### Wire the Stepper Cable to the gShield

Once you’ve determined which stepper cable belongs to which axis you can wire them into the gShield.
First loosen all of the screws on the gShield (they will jump a thread when they are fully loose, but they won’t come out of the terminal blocks.)

The gShield is marked "X," "Y," and "Z".
Wire the stepper cable according to the markings on the shield and order your wires (from left to right) black, green, white, red.

![gShield motor wire](https://dzevsq2emy08i.cloudfront.net/paperclip/project_instruction_image_uploaded_images/718/original/1096.jpg?1424475165)

Check out this diagram for clarification.

![gShield wiring diagram](http://x-carve-instructions.inventables.com/xcarve2015/step14/wiring-diagram2_copy.jpg)


### Mount the gShield

Now push the gShield onto the Arduino.
There are pins on the gShield that go into the headers of the Arduino.

![gShield Arduino mount](https://dzevsq2emy08i.cloudfront.net/paperclip/project_instruction_image_uploaded_images/722/original/1117.jpg?1424475531)

### 24V Fan mount (optional)

If you want, you can add a 24V fan to cool the shield.
Uses the 24V pins on the gShield as shown in the picture below:

![Optional fan mount](https://dzevsq2emy08i.cloudfront.net/paperclip/project_instruction_image_uploaded_images/727/original/1129.jpg?1424475663)

Loosen the screws in the power terminal of the gShield and insert the red twisted pair into `Vmot` and the black twisted pair into `GND`.

### Connect Limit Switches to gShield

Crimp the white ends of each limit switch wire pair. **The order of the white wires from left to right is X, Y, Z. The first, sixth, and eighth slots are left EMPTY.**

![Limit switches wiring diagram](http://x-carve-instructions.inventables.com/xcarve2015/step14/wiring-diagram-limit-switches.jpg)

Pin mapping:

* `D9`: x-limit (red)
* `D10`: y-limit (red)
* `D12`: z-limit (red)
* `GND`: ground (all 3)

### Power the gShield

Loosen the screws in the power terminal of the gShield and insert the red twisted pair into `Vmot` and the black twisted pair into `GND`. This is similar to the optional 24V fan.

!!! note
    This will also power the Arduino.
