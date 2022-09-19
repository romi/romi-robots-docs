Hardware Documentation
======================

This document describes the hardware, both the mechanical parts and
the electronics, of the Romi Rover for weeding. This document is
detailing the third version of the prototype.

# The main structure   

The figure below gives an overview of the main components.

<img src="/assets/images/rover/manual/rover-overview.png">

The documentation is split into two main parts: [the
rover](#the-rover) and [the weeding tool](#the-weeding-tool).

For the rover, you will find the detailed drawings of frame in the
[next section](#the-frame). The mechanical components that we use are
listed in the [follow-up section](#the-mechanical-components). Then,
we discuss [the electronics and wiring](#the-electronics-and-wiring).

The weeding tool consists of [a CNC](#the-cnc), for which we use the
[1000 mm XCarve](https://www.inventables.com/). We replace the z-axis
of the original CNC with a [new arm](#the-z-axis) adapted for the
weeding task.

You can find the discussion of the software in a [dedicated
page](../software/md) of the rover documentation.


# The rover

## The frame

The drawings of the frame are available as PDF files. The current
version is prototype V3:


| File                 | Description  |
| -------------------- | --------------------------- |
| [![Rover](/assets/images/rover/hardware/Rover.png)](https://github.com/romi/romi-rover-design/blob/main/frame/Rover.pdf) | Overview of the components |
| [![Frame](/assets/images/rover/hardware/Frame.png)](https://github.com/romi/romi-rover-design/blob/main/frame/Frame.pdf)  | The main frame. (fr: Châssis) |
| [![Left-Wheel-Module](/assets/images/rover/hardware/Left-Wheel-Module.png)](https://github.com/romi/romi-rover-design/blob/main/frame/Left-Wheel-Module.pdf)  | The left wheel module (fr: Roue motrice gauche) |
| [![Right-Wheel-Module](/assets/images/rover/hardware/Right-Wheel-Module.png)](https://github.com/romi/romi-rover-design/blob/main/frame/Right-Wheel-Module.pdf)  | The right wheel module. It is a mirror of the left wheel module. (fr: Roue motrice droite) |
| [![Cover](/assets/images/rover/hardware/Cover.png)](https://github.com/romi/romi-rover-design/blob/main/frame/Cover.pdf)  | The arches for the rain and light cover. (fr: Toit) |
| [![Caster](/assets/images/rover/hardware/Caster.png)](https://github.com/romi/romi-rover-design/blob/main/frame/Caster.pdf)  | The caster wheel. (fr: Roue folle) |
| [![Fork-Caster](/assets/images/rover/hardware/Fork-Caster.png)](https://github.com/romi/romi-rover-design/blob/main/frame/Fork-Caster.pdf) | In it's latest version, the caster wheel now has a straight fork. This drawing updates and replaces the fork in the previous drawing. |

## The mechanical components

The list of additional components to get the rover up on its feet are
as follows. For the back wheels:


| File                 | Description  |
| -------------------- | --------------------------- |
| <img src="/assets/images/rover/hardware/TD-317-000_1_1920x1920.jpg" width="128px"> | [Brushed DC motors](https://en.wikipedia.org/wiki/Brushed_DC_electric_motor), 24 V, minimum 200 W We are using wheel chair motors for now. We bought a set at [Superdroid Robots](https://www.superdroidrobots.com/store/robot-parts/mechanical-parts/gear-motors/wheelchair-motors/product=3171). You may find similar motors elsewhere, such as on Aliexpress. |
| <img src="/assets/images/rover/hardware/e2_webproduct_01.jpg" width="128px"> | [Incremental encoders](https://en.wikipedia.org/wiki/Incremental_encoder): The motors from Superdroid Robots can be purchased with encoders already added to them. If you want to buy them separately, we use the [US Digital E2](https://www.usdigital.com/products/encoders/incremental/kit/e2/). |
| <img src="/assets/images/rover/hardware/TD-266-000_1_1920x1920.jpg" width="128px"> | Wheel shaft: Still from Superdroid Robots we use the [wheel shaft](https://www.superdroidrobots.com/store/robot-parts/mechanical-parts/wheels-shafts/all-terrain-wheel-shafts/product=2234) that is adapted to the motors. |
| <img src="/assets/images/rover/hardware/rca08-400-4t100-vel01-v8803-3-4-bis-bis.jpg" width="128px"> | For the back wheels we use wheels with traction lugs for farming equipment with a total diameter of roughly 41 cm diameter or 49 cm. Browsing the catalogs of farming wheels can be confusing because of the different standards and naming conventions, and because the tire and rim are often sold separately. We are using these [4.00-10 tires](https://www.malbert.fr/agraire-quad/roue-agraire-quad/roue-400x10-rm400104100) or [4.00-8 tires](https://www.keiyama.eu/roue-complete-agraire-veloce-v-8803-4-00-8-tl-4pr-jante-250x8-4-trous-et0-60x100x14-gauche-2.html). The "4" indicates the width of the tire in inch, and the 8 or 10 indicates the diameter of the wheel rim in inch.   |

You'll notice that the our wheel rim has 4 holes while the wheel shaft
has 5 holes... We ended up drilling new holes in the wheel shaft that
aligned with those of the rim.

For the front wheels:

| File                 | Description  |
| -------------------- | --------------------------- |
| <img src="/assets/images/rover/hardware/front-wheel-1.jpg" width="128px"> | The [front wheel](https://www.caujolle.fr/en/inflatable-wheels/741-dumper-wheel-305-mm-diameter25-mm-bore.html) |
| <img src="/assets/images/rover/hardware/front-wheel-axis.jpg" width="128px"> | The [25 mm axis](https://www.caujolle.fr/en/caujolle-hardware/1011-axle-25-mm-diameter.html). |
| <img src="/assets/images/rover/hardware/front-wheel-ring.jpg" width="128px"> | The [adjusting rings](https://www.caujolle.fr/en/caujolle-hardware/1007-adjustable-retention-ring-for-tube-less-than-25-mm-diameter.html). |

The housing of the battery and the electronics are currently built
from wood :) This is because we haven't found a good way, yet, to
build waterproof housing inexpensively. Made-to-measure housings are
quite expensive. Professional housings with the right size tend to be
even more expensive, or they have features such as ribbed walls that
make them unsuited for our needs. We will solve this issue in the next
version of the prototype.


| File                 | Description  |
| -------------------- | --------------------------- |
| Battery housing | 20mm plywood, outside dimensions: WxHxD (width x height x depth) |
| Electronics housing | 10mm plywood, outside dimensions: WxHxD (width x height x depth) |



## The electronics and wiring

An overview of the wiring can be found in the following diagram. The
diagram is quite large so you may want to open it in a separate
window or download it and open it with [Inkscape](https://inkscape.org/). Here's the [GitHub link](https://github.com/romi/romi-rover-design/blob/main/wiring/schema-hardware.svg).

<img src="https://raw.githubusercontent.com/romi/romi-rover-design/main/wiring/schema-hardware.svg">

The [Meanwell
DDR-30G-24 transformer](https://www.meanwell-web.com/en-gb/dc-dc-ultra-slim-industrial-din-rail-converter-ddr--30g--24)
converts the battery voltage level to a stable and clean 24V that
powers the electronics. It is not powerfull enough to drive the motors
(wheels, CNC, hoe) so these are draw there current directly from the
battery.

The [Controllino
Mini](https://www.controllino.com/product/controllino-mini/) is a
[Programmable Logic
Controller](https://en.wikipedia.org/wiki/Programmable_logic_controller)
that manages the power supply to the motors. It uses three inputs to
decide whether power should be supplied or not to the motors: the
emergency switch, the on/off button, and the status pin of the
Raspberry Pi.

The Controllino does not provide the power directly to the motors. It
uses the [24V relay from
Finder](https://fr.rs-online.com/web/p/contacteurs/8002843) to connect
or disconnect the battery power. The power relay is designed to handle
strong currents and has a protection against sparks and back-currents.

We also added a [24V USB
hub](https://www.reichelt.com/de/en/usb-2-0-hub-with-4-outputs-for-industrial-use--exsys-ex-1163hm-p82420.html). It
provides four additional USB ports and reduces the power that would be
drawn from the USB ports of the Raspberry Pi without it since the hub
takes its power from the 24V line.

The brain of the rover is the [Raspberry Pi
4](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/). We
added a HifiBerry shield so that the rover can output sound but also
because it has a good 24V to 5V converter onboard. We designed a hat
for the [level shifter](https://en.wikipedia.org/wiki/Level_shifter)
(needed to connect to the Controllino), the [real-time
clock](https://en.wikipedia.org/wiki/Real-time_clock) (RTC), and the
connector. You will find the details below.


The components inside the electronics housing are fixed on a 50 cm
long, 35 mm [DIN rail](https://en.wikipedia.org/wiki/DIN_rail). We
also use distribution blocks and rail mounts:

| File                 | Description  |
| -------------------- | --------------------------- |
| <img src="/assets/images/rover/hardware/din-rail.jpg" width="128"> | 50 cm DIN rail. [Example](https://uk.rs-online.com/web/p/din-rails/0467406) |
| <img src="/assets/images/rover/hardware/din-rail-distribution-block.jpg" width="128"> | We also use distribution blocks that clips on the DIN rail. [Example](https://uk.rs-online.com/web/p/distribution-blocks/2779815). These mounting carriers from Wago are also very handy for connecting low-power wires: [Wago 222 Series](https://www.wago.com/global/installation-terminal-blocks-and-connectors/mounting-carrier/p/222-500) and the their [classic splicing connector](https://www.wago.com/global/search?text=classic%20splicing%20connector). Although we have not used them, the [terminal blocks by Phoenix Contact](https://www.phoenixcontact.com/en-pc/products/terminal-blocks) may be worth a try. |
| <img src="/assets/images/rover/hardware/din-rail-bracket.jpg" width="128"> | For the 3D printed housings that are clipsed on the DIN rail we use these ["35mm Rail Mounting Bracket"](https://www.amazon.com/Mounting-Bracket-Relay-Single-Phase/dp/B08GSQY2RB/). |

A more detailed overview of the wiring is shown in the following diagram (TODO: must be updated). Again, you can download the diagram and open it in [Inkscape](https://inkscape.org/) or in a separate browser window, for a more detailed view. 

<img src="https://raw.githubusercontent.com/romi/romi-rover-design/main/wiring/wiring-diagram.svg" height="500px">

There are two separate power circuits:

2. **Logic circuit**: This circuits powers the embedded PC and other control circuits. 
3. **Power circuit**: This circuit drives all the motors. This is the circuit that is cut when the security switch (the big red button) is pressed.  

<img src="https://raw.githubusercontent.com/romi/romi-rover-design/main/wiring/power-circuit.svg" width="30%">

The power circuits are controller by the Controllino according to the
two start-up phases (the PC and the logic circuits start up first,
then the motors are powered up). 

| Component | Description |
|-----------|----------------|
| <img src="/assets/images/rover/hardware/power-relay.jpg" width="128"> | Non-Latching, protection against sparks and back-current (TODO: be more precise) [RS Online](https://uk.rs-online.com/web/p/non-latching-relays/8002843/) |
| <img src="/assets/images/rover/hardware/emergency-button-1.jpg" width="128"><br><img src="/assets/images/rover/hardware/emergency-button-2.jpg" width="128"> | Farnell: [button](https://fr.farnell.com/omron/a22em01/arret-d-urgence-spst-nc-110v-a/dp/2811980) and [housing](https://fr.farnell.com/omron/a22zb101y/corps-de-bouton-poussoir-arret/dp/2811984) |
| <img src="/assets/images/rover/hardware/on-off-switch.jpg" width="128"> | The on-off switch [Farnell](https://fr.farnell.com/marquardt/1935-3113/interru-a-manette-bipol-blanc/dp/7892497) |



## The display

<img src="/assets/images/rover/hardware/display.jpg" width="480">

The display is used to show status information from the control
software. It also allows you to list the menu of actions that are
programmed on the rover. The display is connected to the Raspberry Pi
over USB. The associated firmware for the Uno is
[CrystalDisplay](https://github.com/romi/libromi/tree/ci_dev/firmware/CrystalDisplay).


| Component | Description |
|-----------|----------------|
| <img src="/assets/images/rover/hardware/arduino-uno.jpg" width="128"> | [Arduino Uno](https://www.arduino.cc/en/Guide/ArduinoUno) | 
| <img src="/assets/images/rover/hardware/shield-lcd-display.jpg" width="128"> | We use the following shield with LCD screen: [GM Electronic](https://www.gmelectronic.com/arduino-shield-with-16x2-lcd-screen-and-buttons). There are similar clones available online. |



## The navigation module   

The navigation uses a differential wheel drive, with two motorized
wheels in the back and two swivel caster in the front. This makes the
control fairly straight-forward and the components are easy to source.

The main components are shown below:

<img src="/assets/images/rover/hardware/schema-navigation-modules.svg" width="70%">

| Component | Specifications | Example |
|-----------|----------------|---------|
| <img src="/assets/images/rover/hardware/arduino-uno.jpg" width="128"> | [Arduino Uno](https://www.arduino.cc/en/Guide/ArduinoUno) | 
| Shield | The shield allows you to connect the wires securely. TODO: PCB design. |


The associated firmware for the Uno is
[MotorController](https://github.com/romi/libromi/tree/ci_dev/firmware/MotorController).

TODO: 3D housing for motor controller

The motor controller connects to the motor driver. The driver
implements a standard H-bridge to control to power supplied to the
motors (both forward and backward rotation). We use the [Sabertooth
2x60A](https://www.dimensionengineering.com/products/sabertooth2x60). There
are other motor drivers out there that can be used also. The power
input should be 24V and there should be able to drive a lot of current
current (> 15 A continuous, 40 A peak).

Two [PWM](https://en.wikipedia.org/wiki/Servo_control) control signals
are used from the Arduino to the driver, similar to RC input: one for
the left and right motor.

<img src="/assets/images/ext/Sabertooth2X60.jpg" width="200px">

The wiring diagram 

<img src="/assets/images/rover/hardware/navigation-wiring.svg" width="70%">


TODO: DIN support for Sabertooth.


## The Raspberry Pi

We wrapped the Raspberri Pi 4 in ints own housing, together with some
additional components. First, we have put a HifiBerry Amp2 hat on
it. The HifiBerry is a high-end audio amplifier and you can connect
two analog audio speakers to it. This is maybe a little extravagant
because this board does not come cheap and its usage is currently
still limited. Audio feedback is planned for the future, though. Also,
we use the HifiBerry as a power adapter because it converts the 24V to
the 5V needed by the Raspberri Pi. All this we probably be
re-evaluated in upcoming versions.

We also added a level-shifter, to communicate with the Controllino. We
also added connector plugs and a ventilator to air the housing.

| Component | Link |
|-----------| -----------|
| <img src="/assets/images/rover/hardware/hifiberry-amp2.jpg" width="128"> | [HifiBerry Amp2](https://www.hifiberry.com/shop/boards/hifiberry-amp2/) |
| <img src="/assets/images/rover/hardware/level-shifter.jpg" width="128"> | Level-shifter: [Sparkfun](https://www.sparkfun.com/products/12009) |
| <img src="/assets/images/rover/hardware/phoenix-contact-5way.jpg" width="128"> | For the connectors, we use the following from Phoenix Contact: 1x [5 way](https://www.phoenixcontact.com/en-us/products/printed-circuit-board-terminal-tdpt-25-5-sp-508-1017506), 1x [2 way](https://www.phoenixcontact.com/en-us/products/printed-circuit-board-terminal-tdpt-25-2-sp-508-1017503), and 1x [4 way](https://www.phoenixcontact.com/en-us/products/printed-circuit-board-terminal-tdpt-25-4-sp-508-1017505)|
| <img src="/assets/images/rover/hardware/ventilator.jpg" width="128"> | Ventilator 12/24V, 30 x 30 x 10 mm [Amazon](https://www.amazon.fr/gp/product/B0757N6B8P/ref=ppx_yo_dt_b_asin_title_o03_s00) |

We designed a PCB board to put all pieces together (TODO: files) and a
housing to protect it all (TODO: file).

<img src="/assets/images/rover/hardware/housing-raspberry-pi.png" width="50%">

The software of the rover is available in
[Github](https://github.com/romi/romi-rover-build-and-test) and has
its own [documentation](../software).


## The camera

The camera uses the standard Raspberry Pi Zero 2 W together with the
Raspberry Pi Camera V2. The software of the camera is part of the
[main repository](https://github.com/romi/romi-rover-build-and-test)
and is also documented on the [software](../software) page.

The camera is powered by a 24 V line (plus ground) directly from the
Meanwell power adaptor. We designed a PCB board to support the
MP1584EN-based 24V-to-5V DC-DC [buck
converter](https://www.amazon.fr/gp/product/B07MY2XP21/ref=ppx_yo_dt_b_asin_title_o07_s00)
to power the Pi Zero and we also add a [RJ45 connection
plug](https://fr.farnell.com/amp-te-connectivity/216550-1/fiche-jack-8-8-droite/dp/1284342?st=rj45). This

TODO: PCB file

TODO: 3D file of housing

The camera is up for a review because we want to switch to the
Raspberry Pi HQ camera.



## The steering

The steering of the front wheels is currently performed by two [NEMA 23 stepper
motors with a 1:77 gearbox](https://www.phidgets.com/?tier=3&catid=24&pcid=21&prodid=353). The stepper motors are controlled by two
standard stepper controller and an Arduino Uno. We also use two
[absolute rotary
encoders from Opkon](https://www.conrad.fr/p/opkon-absolu-codeur-1-pcs-mrv-50a-magnetique-bride-de-serrage-2102690)
to adjust for errors.

NOTE: at the time of writing, the steering controller has not been
integrated into the electronics housing, yet.

The coupling of the stepper motors and of the encoder onto the wheel
axis is still provisional. We use a [coupler](?) to join the wheel
axis to the motor. To connect the encoder to the axis, we use a GT2
belt and two 3D printed pulleys, one for the wheel axes and one for
the encoder.

It is all held together using 3D printed components and two laser-cut
aluminium plates. It look roughly like this:

<img src="/assets/images/rover/hardware/steering-mount-1.png" height="200px">
<img src="/assets/images/rover/hardware/steering-mount-2.png" height="200px">

The files are available at
[romi-rover-design/steering](https://github.com/romi/romi-rover-design/tree/main/steering).



The mechanical components

The control part

1. The list of components
2. The wiring


# The weeding tool

## The CNC

A CNC is adapted for use in the rover. We are using the 1000 mm sized
version of the
[X-Carve](https://www.inventables.com/technologies/x-carve/choose).
We replaced the spindle that is
normally used to carve wooden pieces, with a rotating weeding hoe. 


The newer X-Carve uses a custom design board for the control. However,
we prefer using the older solution that combines an Arduino Uno with a
gShield because it is smaller and more generic. It is possible to use
other stepper drivers. The drivers must use the standard STEP/DIR
control signals.  The associated firmware for the Uno is
[Oquam](https://github.com/romi/libromi/tree/ci_dev/firmware/Oquam).



| Component | Specifications | Example |
|-----------|----------------|---------|
| <img src="/assets/images/rover/hardware/arduino-uno.jpg" width="128"> | [Arduino Uno](https://www.arduino.cc/en/Guide/ArduinoUno) | 
| <img src="/assets/images/rover/hardware/gshield.jpg" width="128"> | Stepper drivers (3 steppers): [gShield](https://synthetos.myshopify.com/products/gshield-v5) |


For the wiring, you can still have a look at XCarve's older
documentation on how to wire the controller boards:

- http://x-carve-instructions.inventables.com/xcarve2015/step10/ 
- http://x-carve-instructions.inventables.com/xcarve2015/step14/ 

Notable, the following two diagrams are of interest:

<img src="/assets/images/rover/hardware/xcarve-wiring-diagram2.jpg" width="50%">

<img src="/assets/images/rover/hardware/xcarve-wiring-diagram-limit-switches.jpg" width="50%">


The yellow wire marked "spindle" in the image above is used to turn the
weeding hoe on or off, as shown in the figure below (see also the
figure in the section on the power circuit).

<img src="/assets/images/rover/hardware/relay-hoe.svg" width="300px">


## The Z-axis

1. The list of components
2. The 3D files
3. The 2D files for laser cutting
4. The wiring

## The weeding head


