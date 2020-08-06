Build instructions for the ROMI plant scanner
=============================================

## Build overview

You will have to achieve the following steps:

1. build the aluminium frame;
2. build the CNC;
3. attach the CNC the to aluminium frame;
4. choose a camera & build the camera mount;
5. wiring it all.


## Open Hardware
We use "widely available" materials and provides all the required information so you can reproduce and modify our work.

If you want to modify it, please note the following important points:

1. The width and depth of the aluminium frame is dependent of the CNC frame size, make sure the CNC frame fits inside the aluminium frame!
2. The height of the aluminium frame will determines the maximum observable plant height.


## Wiring & communication overview

The plant scanner electronics can be divided in two functional groups:

1. the "CNC group", responsible for moving the camera around;
2. the "Gimball & Camera group", allowing to rotate the camera around the z-axis to face the object (plant) to acquire.

Note that the CNC group has 3 axis movement (X, Y & Z), the gimball add a forth one.

<figure>
    <img src="/assets/images/scanner_electronics-overview.png" alt="Scanner electronics overview" width="1200" />
  <figcaption>Overview of the scanner's electronics. Note that the PiCarema act as a wifi hotspot to which the controller computer is registered. </figcaption>
</figure>

The two groups communicate with the main controller by USB.
Note that since the gimball & camera are located at the end of the arm on the z-axis, the USB cable powering & controlling them are going trough the cable rails with those dedicted to the axis motors.
This may create interference, so you will need a (long) properly shielded USB cable!