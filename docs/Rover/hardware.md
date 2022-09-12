Hardware Documentation
======================

This document describes the hardware, both the mechanical parts and
the electronics..

# The main structure   

The figure below gives an overview of the main components.

![](/assets/images/rover-overview.svg)


## The mechanical components   

### The frame

### The wheels

### The boxes

### The CNC

We use currently use the X-Carve. Please follow X-Carve's documentation at [](http://x-carve-instructions.inventables.com/xcarve2015/).

### The Z-axis

### The cover


# The frame

The drawings of the frame are available as PDF files. The current
version is prototype V3:


| File                 | Description  |
| -------------------- | --------------------------- |
| [![Rover](/assets/images/rover/hardware/Rover.png)](/assets/images/rover/hardware/Rover.pdf) | Overview of the components |
| [![Frame](/assets/images/rover/hardware/Frame.png)](/assets/images/rover/hardware/Frame.pdf)  | The main frame. (fr: Châssis) |
| [![Left-Wheel-Module](/assets/images/rover/hardware/Left-Wheel-Module.png)](/assets/images/rover/hardware/Left-Wheel-Module.pdf)  | The left wheel module (fr: Roue motrice gauche) |
| [![Right-Wheel-Module](/assets/images/rover/hardware/Right-Wheel-Module.png)](/assets/images/rover/hardware/Right-Wheel-Module.pdf)  | The right wheel module. It is a mirror of the left wheel module. (fr: Roue motrice droite) |
| [![Cover](/assets/images/rover/hardware/Cover.png)](/assets/images/rover/hardware/Cover.pdf)  | The arches for the rain and light cover. (fr: Toit) |
| [![Caster](/assets/images/rover/hardware/Caster.png)](/assets/images/rover/hardware/Caster.pdf)  | The caster wheel. (fr: Roue folle) |
| [![Fork-Caster](/assets/images/rover/hardware/Fork-Caster.png)](/assets/images/rover/hardware/Fork-Caster.pdf) | In it's latest version, the caster wheel now has a straight fork. This drawing updates and replaces the fork in the previous drawing. |




## The electronics   

### The basic architecture of the control modules   

![](/assets/images/schema-hardware-modules.svg)

<div class="todo">
<b>NOTE</b>: The current rovers don't implements the schema above, yet:
<ul>
<li>The CNC has no encoders.</li>
<li>The rover in Valldaur doesn't have a control panel.</li>
</ul>
</div>

### The control panel

<div class="todo">
<b>NOTE</b>: The control panel is still being developed at the time of writing.
</div>

The control panel is used to start and stop the rover and to display
status information on the character display.


| Component | Specifications | Example |
|-----------|----------------|---------|
| Controller  | [Arduino Uno](https://www.arduino.cc/en/Guide/ArduinoUno) or equivalent | ![](/assets/images/ext/a000066_front_1_1_1.jpg) |
| Proto shield | The shield allows you to solder the wires securely | [Adafruit](https://www.adafruit.com/product/2077) ![](/assets/images/ext/2077-03.jpg) <br> [Sparkfun](https://www.sparkfun.com/products/13820) ![](/assets/images/ext/13820-SparkFun_ProtoShield_Kit-04.jpg) <br> [Amazon](https://www.amazon.com/s?k=arduino+proto+shield) |
|Relay (2x) | TODO |[Sparkfun](https://www.sparkfun.com/products/13815) ![](/assets/images/ext/13815-04a.jpg) |
|Push button with LEDS (2x) | One green and one red |[Adafruit](https://www.adafruit.com/product/3489) ![](/assets/images/ext/3489-00.jpg) |
|LCD Character Display|Comptable with XXX|[Farnell](https://uk.farnell.com/midas/mc21609ab6w-fptlw-v2/display-alphanumeric-16x2-white/dp/2675622) ![](/assets/images/ext/o2218965-40.jpg)|



### The power circuit


<div class="todo">
<b>NOTE</b>: This is the new power circuit that will be used with the control panel. It's currently not implemented in either rover.
</div>

There are three separate power circuits:

1. **Always-on circuit**: This circuits powers the control panel.
2. **Logic circuit**: This circuits powers the embedded PC and other control circuits.
3. **Power circuit**: This circuit drives all the motors. This is the circuit that is cut when the security switch (the big red button) is pressed.  

![](/assets/images/power-circuit.svg)

The control panel actuates two relays (Relay 1 & 2) according to the
two start-up phases (the PC and the logic circuits start up first,
then the motors are powered up). The third relay is designed to handle
strong currents. It has a protection against sparks and
back-currents.

Most of the logic runs on 5V. (TODO: Add a Meanwell power converter. Q: One converter for the the control panel + one of the logic circuit? Or one single converter?)

The figure does not show the power line for the weeding hoe. The hoe
is turned on/off using a fourth relay that is connected to the gShield
board of the CNC. It using the CNC's spindle on/off functionality. You
can find more information on this in the section on the CNC below.
    

| Component | Specifications | Example |
|-----------|----------------|---------|
|Relay |Non-Latching, protection against sparks and back-current (TODO: be more precise) |[RS Online](https://uk.rs-online.com/web/p/non-latching-relays/8002843/) ![](/assets/images/ext/F8002843-01.jpeg) |
|Security switch|            | Farnell: [button](https://fr.farnell.com/omron/a22em01/arret-d-urgence-spst-nc-110v-a/dp/2811980) and [housing](https://fr.farnell.com/omron/a22zb101y/corps-de-bouton-poussoir-arret/dp/2811984) ![](/assets/images/ext/2811980-40.jpg) ![](/assets/images/ext/2811984-40.jpg) |

### The navigation module   

The navigation uses a differential wheel drive, with two motorized
wheels in the back and two swivel caster in the front. This makes the
control fairly straight-forward and the components are easy to source.
The navigation module can also receive input from a remote control to
steer the rover.

The main components are shown below:

![](/assets/images/schema-navigation-modules.svg)

#### Components

| Component | Specifications | Example |
|-----------|----------------|---------|
| Motors    | [Brushed DC motors](https://en.wikipedia.org/wiki/Brushed_DC_electric_motor), 24 V, minimum 200 W | We are using wheel chair motors for now. We bought a set at [Superdroid Robots](https://www.superdroidrobots.com/shop/item.aspx/lst10-24vdc-120-rpm-wheel-chair-motor-pair/2599/). ![](/assets/images/ext/TD-291-120.jpg)  |
| Encoders  | [Incremental encoders](https://en.wikipedia.org/wiki/Incremental_encoder) | US Digital E2 ![](/assets/images/ext/e2_webproduct_01.jpg) (Available from [Superdroid Robotics](https://www.superdroidrobots.com/shop/item.aspx?itemid=2315)). |
| Controller  | [Arduino Uno](https://www.arduino.cc/en/Guide/ArduinoUno) or equivalent | ![](/assets/images/ext/a000066_front_1_1_1.jpg) |
| Proto shield | The shield allows you to solder the wires securely | [Adafruit](https://www.adafruit.com/product/2077) ![](/assets/images/ext/2077-03.jpg) <br> [Sparkfun](https://www.sparkfun.com/products/13820) ![](/assets/images/ext/13820-SparkFun_ProtoShield_Kit-04.jpg) <br> [Amazon](https://www.amazon.com/s?k=arduino+proto+shield) |
| Motor driver | Preferably one board that can drive two motors. Two drivers, one for each motor, is possible, too. Power input: 24V, Maximum output current: > 15 A per motor, Control signals: two [PWM](https://en.wikipedia.org/wiki/Servo_control) signals (similar to RC input) for the left and right motor. The driver implements a standard H-bridge to control to power supplied to the motors (both forward and backward rotation). | [Sabertooth 2x60A](https://www.dimensionengineering.com/products/sabertooth2x60) ![](/assets/images/ext/Sabertooth2X60.jpg) <br> [Sabertooth 2x32A](https://www.dimensionengineering.com/products/sabertooth2x32) ![](/assets/images/ext/Sabertooth2x32Small.jpg) <br> [RoboClaw 2x60A](https://www.basicmicro.com/RoboClaw-2x60A-Motor-Controller_p_8.html) ![](/assets/images/ext/MC60A_Right_Small2.jpg) |
| RC controller and receiver | A standard RC receiver that outputs a PWM signal. Powered by 5V.  | We've succesfully used the remote controllers for [Spektrum](https://www.spektrumrc.com), [this one](https://www.spektrumrc.com/Products/Default.aspx?ProdID=SPM2335) for example or similar ![](/assets/images/ext/SPM2335_a3.jpg) ![](/assets/images/ext/SPMSR310-450.jpg)  |
| Wheels | You will need those, too.  | We are using the wheel [provided by Superdroid Robotics](https://www.superdroidrobots.com/shop/item.aspx/direct-drive-wheelchair-motor-wheel-and-shaft-set-pair-13-inch-traction-lug/2237/) for now ![](/assets/images/ext/TD-178-000.jpg) |

#### Wiring diagram

![](/assets/images/navigation-wiring.svg)

### The tool positioning

A CNC is adapted for use in the rover. We replaced the spindle that is
normally used to carve wooden pieces, with a rotating weeding hoe. We
are using to larger, 1000 mm sized version of the
[X-Carve](https://www.inventables.com/technologies/x-carve/choose).

The newer X-Carve uses a custom design board for the control. However,
we prefer using the older solution that combines an Arduino Uno with a
gShield because it is smaller and more generic. For the time being, we
use the [_grbl_](https://github.com/gnea/grbl/wiki) language to send
commands from the embedded PC to the CNC controller. Therefore, any
solution that accepts grbl commands should be drop-in solution for the
Uno+gShield combo.

| Component | Specifications | Example |
|-----------|----------------|---------|
| CNC       | Minimum work area: 0.7 m x 0.7m | [X-Carve](https://www.inventables.com/technologies/x-carve/choose) |
| Optional: Controller board | Must run grbl interpreter | [Arduino Uno](https://www.arduino.cc/en/Guide/ArduinoUno) ![](/assets/images/ext/a000066_front_1_1_1.jpg) |
| Optional: Stepper drivers (3 steppers) | The driver must use the STEP/DIR control signals | [gShield](https://synthetos.myshopify.com/products/gshield-v5) ![](/assets/images/ext/10699531753_e00472237e_b_1_1024x1024.jpg) <br> [Arduino CNC Shield] [eBay](https://www.ebay.com/str/protoneer) and [RepRap](https://www.reprap.me/arduino-cnc-shield.html) ![](/assets/images/ext/sku165456-2.jpg) |

You can still have a look at XCarve's older documentation on how to wire the controller boards:

- http://x-carve-instructions.inventables.com/xcarve2015/step10/ 
- http://x-carve-instructions.inventables.com/xcarve2015/step14/ 

Notable, the following two diagrams are of interest:

![](/assets/images/ext/xcarve-wiring-diagram2.jpg)

![](/assets/images/ext/xcarve-wiring-diagram-limit-switches.jpg)

The yellow wire marked "spinle" in the image above is used to turn the
weeding hoe on or off, as shown in the figure below (see also the
figure in the section on the power circuit).

![](/assets/images/relay-hoe.svg)


