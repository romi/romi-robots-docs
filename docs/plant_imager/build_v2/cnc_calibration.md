CNC setup & calibration
=======================

After building & wiring the CNC and fitting it into the aluminium frame it is required to calibrate some Grbl software parameters like the _homing directions_ or the _acceleration rates_.

## Using Grbl

Except if you are familiar with Grbl, if you want to know more, have a look at the official Grbl [wiki](https://github.com/gnea/grbl/wiki).

### Connect to the Arduino

Then you can use [picocom](https://github.com/npat-efault/picocom) to connect to the arduino:

```shell
picocom /dev/ttyACM0 -b 115200
```

!!! note
    See [here](cnc_communication.md) how to find the right USB port.

### Getting help

You can type `$` (and press enter) to get help. You should not see any local echo of the `$` and enter.
Grbl should respond with:
```
[HLP:$$ $# $G $I $N $x=val $Nx=line $J=line $SLP $C $X $H ~ ! ? ctrl-x]
ok
```

### Accessing the saved configuration

To access the saved configuration, type `$$` to obtain the parameter values.
For example our config is:
```
$0=10
$1=255
$2=0
$3=5
$4=0
$5=0
$6=0
$10=1
$11=0.020
$12=0.002
$13=0
$20=1
$21=0
$22=1
$23=0
$24=25.000
$25=5000.000
$26=250
$27=1.000
$30=12000
$31=0
$32=0
$100=40.000
$101=40.000
$102=188.947
$110=8000.000
$111=8000.000
$112=1000.000
$120=100.000
$121=100.000
$122=50.000
$130=780.000
$131=790.000
$132=150.000
```

!!! note
    See the official Grbl [wiki](https://github.com/gnea/grbl/wiki/Grbl-v1.1-Configuration#grbl-settings) for details & meaning of parameter.

## Setup & calibration

Now we will:

1. verify the cnc respond correctly to homing instruction
2. calibrate if needed

### Homing the X-carve

Once you are sure that everything is connected properly (especially the limit switches) you can try to "home" the X-Carve manually using `$H` in the previous terminal connected to Grbl.

!!! warning
    Be ready to use the **emergency stop button** in case the axes move in the opposite direction of your limit switches!

!!! note
    If you don't see any response in the terminal when you type the commands, it is perfectly normal!

### Change homing direction:

Parameters named `$3` control the homing direction.

From the official wiki:

!!! quote
    By default, Grbl assumes that the axes move in a positive direction when the direction pin signal is low, and a negative direction when the pin is high.

To configure the homing direction, you simply need to send the value for the axes you want to invert using the table below.

| Setting Value | Mask |Invert X | Invert Y | Invert Z |
|:-------------:|:----:|:-------:|:--------:|:--------:|
| 0 | 00000000 |N | N | N |
| 1 | 00000001 |Y | N | N |
| 2 | 00000010 |N | Y | N |
| 3 | 00000011 |Y | Y | N |
| 4 | 00000100 |N | N | Y |
| 5 | 00000101 |Y | N | Y |
| 6 | 00000110 |N | Y | Y |
| 7 | 00000111 |Y | Y | Y |

For example, if want to invert the Y axis direction only, you'd send `$3=2` to Grbl, and the setting should now read `$3=2 (dir port invert mask:00000010)`

### Edit the acceleration rates

Parameters named `$120`, `$121` & `$123` control the axes acceleration in mm/second/second.

From the official wiki:

!!! quote
    Simplistically, a lower value makes Grbl ease slower into motion, while a higher value yields tighter moves and reaches the desired feed rates much quicker.
    Much like the max rate setting, each axis has its own acceleration value and are independent of each other.
    This means that a multi-axis motion will only accelerate as quickly as the lowest contributing axis can.

Since the Z-axis arm is long and have a "heavy weight" (gimbal + camera) at its lower end, it is probably a good to keep low values to avoid blurry image due to shaking!

To determine optimal values, the official wiki is clear, you will have to run some tests:

!!! quote
    Again, like the max rate setting, the simplest way to determine the values for this setting is to individually test each axis with slowly increasing values until the motor stalls.
    Then finalize your acceleration setting with a value 10-20% below this absolute max value.
    This should account for wear, friction, and mass inertia.
    We highly recommend that you dry test some G-code programs with your new settings before committing to them.
    Sometimes the loading on your machine is different when moving in all axes together.

For example, you can send `$120=100.0` to set the X axis acceleration rate to 100 mm/second².

!!! note
    Deceleration rates may also create shaking!