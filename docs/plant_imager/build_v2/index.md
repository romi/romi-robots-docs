# Assembly instructions for the third version of the ROMI plant imager


## Assembly overview

You will have to achieve the following steps:

1. assemble the aluminium frame: [instructions](alu_frame.md)
2. assemble the X-Carve CNC: [instructions](cnc_frame.md)
3. attach the CNC the to aluminium frame
4. assemble one of the electronic controller:
   - X-controller: [instructions](cnc_electronics.md#x-controller-assembly)
   - gShield hat : [instructions](cnc_electronics.md#gshield-assembly)
5. wire the X-Carve CNC motors & endstops to the controller
6. assemble & mount the custom gimbal: [instructions](gimbal_setup.md)
7. choose a camera & build the camera mount
   1. PiCamera: [instructions](picamera_setup.md)
   2. Sony RX-0
   3. gPhoto2 compatible camera
8. [OPTIONAL] add the LED bars inside
9. wiring it all.


## Open Hardware

We use "widely available" materials and provides all the required information, so you can reproduce and modify our work.

If you want to modify it, please note the following important points:

1. The width and depth of the aluminium frame is dependent of the CNC frame size, make sure the CNC frame fits inside the aluminium frame!
2. The height of the aluminium frame will determine the maximum observable plant height.


## Wiring & communication overview

The plant imager electronics can be divided in two functional groups:

1. the "CNC group", responsible for moving the camera around;
2. the "Gimbal & Camera group", allowing to rotate the camera around the z-axis to face the object (plant) to acquire.

Note that the CNC group has 3 axis movement (X, Y & Z), the gimbal add a forth one.

<figure>
    <img src="/assets/images/scanner_electronics-overview.png" alt="Plant imager electronics overview" width="1200" />
  <figcaption>Overview of the plant imager's electronics. Note that the PiCamera act as a wifi hotspot to which the controller computer is registered. </figcaption>
</figure>

The two groups communicate with the main controller by USB.
Note that since the gimbal & camera are located at the end of the arm on the z-axis, the USB cable powering & controlling them are going through the cable rails with those dedicated to the axis motors.
This may create interference, so you will need a (long) properly shielded USB cable!