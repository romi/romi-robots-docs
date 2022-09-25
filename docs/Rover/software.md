Software Installation
=====================

## Overview

This document describes how to run and compile the software for the
ROMI Rover. 

## Prerequisites

The software of the rover runs on Linux. It is not tied to a specific
Linux distribution but we have tested it mostly on recent versions of
Debian (includin Raspian) and Ubuntu.

The software is mostly writen in C++ and depends on the following
libraries:
    
- **rcom**: An inter-process communication framework. It provides
  real-time communication using UDP messages and high-level
  communication based on web protocols (HTTP, Websockets). The code is
  available on [GitHub](https://github.com/romi/librcom) and [separate
  documentation](https://docs.romi-project.eu/Rover/librcom/) is
  available also.

- **libromi**: The library with thd base classes for the romi rover:
  [Code](https://github.com/romi/libromi). This repository also
  contains the firmware for most of the microcontrollers used in the
  Rover, Plant Imager, and Cablebot. 

- **romi-rover**: All of the apps for the Romi rover, including
  `romi-rover`, `romi-camera`, and `romi-cablebot`.
  [Code](https://github.com/romi/romi-rover-build-and-test)




## Installing a Raspberry Pi from scratch

We use the _Lite_ version of Raspbian. You can download it at
[https://www.raspberrypi.org/downloads/raspbian/](https://www.raspberrypi.org/downloads/raspbian/). There
are several ways to prepare the disk image for the RPi. Check the page
at
[https://www.raspberrypi.org/documentation/installation/installing-images/](https://www.raspberrypi.org/documentation/installation/installing-images/)
(there’s lots of information available on this topic online) and
follow the instructions that suit you best.

Once you have the SD card, connect RPi to screen, keyboard and network
(ethernet), power up the board and log in (user _pi_, password
_raspberry_). The first thing you want to do is change some of the
default settings using the raspi-config tool. In the console type:

```bash
$ sudo raspi-config
```

The list of settings that you may want to look at includes:

```
1 Change User Password
2 Network Options
   Hostname
   WiFi
4 Localisation Options
   Change locales
   Change keyboard layout
5 Interfacing Options
   Enable SSH
8 Update
```

Next, create the user ‘romi’: 

```bash
$ sudo adduser romi
$ sudo adduser romi dialout
$ sudo adduser romi video
$ sudo adduser romi sudo
```

After that, quit the current session and login again as user ‘romi’.

The _nano_ text editor is installed by default but if you prefer
anoher editor, now is a good time to install it:

```bash
$ sudo apt install emacs-nox (... or any editor you like :)
```

Install the developer tools:
```bash
$ sudo apt install build-essential cmake git
```

Install the software dependencies: 
```bash
$ sudo apt install libpng-dev libjpeg9-dev
```
That's it. You should be ready.


## Installing the romi-rover apps

The installation has it [own
documentation](https://github.com/romi/romi-rover-build-and-test) on
github.


## Compiling the romi-camera 

The `romi-camera` application is used in the Rover, Cablebot, and
Plant Imager. Because the camera uses the Raspberry Pi Zero, which has
less RAM memory than its larger siblings.

The installation proceeds as described in the documentation of
[romi-rover-build-and-test](https://github.com/romi/romi-rover-build-and-test). However,
it is not necessary to compile all applications and limit this step to
the camera app only:

```bash
$ mkdir build
$ cd build/
$ cmake ..
$ make romi-camera
```

## Starting up the software manually

As explained in the [rcom
documentation](https://docs.romi-project.eu/Rover/librcom/#the-registry),
the `rcom-registry` has to be started before the other
applications. It can be started remotely using ssh as follows:

```bash
$ ssh romi@camera.local /home/romi/romi-rover-build-and-test/build/bin/romi-camera \
    --registry <IP-ADDRESS-REGISTRY> --mode video --fps 5 --bitrate 12000000
```

In the second step, the `romi-camera` should be started up. The rcom
c onnections use a time-out so there is some flexibility in the
start-up order of the applications.


```bash
$ ./build/bin/rcom-registry
```

If you use any Python code, such as the Unet neural network for the
image segmentation, the following script can be used: 

```bash
$ python3 ./application/romi-python/main.py \
      --model-path <PATH-UNET-WEIGHTS> 
```

Lastly, the `romi-rover` application should be started.

```bash
$ ./build/bin/romi-rover --config $CONFIG_FILE \
    --session $SESSION_DIR --script $SCRIPT_FILE
```

A more elaborate example can be found in this
[script](https://github.com/romi/romi-rover-build-and-test/blob/ci_dev/scripts/rover-start).
It should be called indirectly using the `intra-row-weeding-tbm`
script:

```bash
$ cd scrips
$ ./intra-row-weeding-tbm
```

## Starting the apps on boot 

Currently we are still using the old rc.local mechanism. The file
/etc/rc.local is no longer included in more recent Ubuntu versions. If
`ls /etc/rc.local` returns an error, you will have to create the file
as follows:

```bash
$ sudo nano /etc/rc.local
```

Copy the following contents:

```
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

exit 0
```

Finally, make the script executable.
```bash
$ sudo chmod +x /etc/rc.local
```

To enable the apps on start-up, add the following line in
/etc/rc.local, above the `exit 0` line:

```bash
sudo -u romi PATH-TO-STARTUP-SCRIPT &
```


# Rcom interfaces



## Camera

The CNC interface is exported by the `romi-camera` application.

| Method | Parameters | Return | Description | 
|-----------|----------------|----------------|----------------|
| camera:grab-jpeg-binary | None | A binary buffer with a JPEG-encoded image | |
| camera:set-value | name: the name of the setting, value: the numerical value | None | |
| camera:select-option | name: the name of the option, value: the value as a string | None | |

## CNC

The CNC interface is exported by the `oquam` application.

| Method | Parameters | Return | Comments | 
|-----------|----------------|----------------|----------------|
| cnc-homing | None | None | Starts the homing procedure that puts the CNC's arm in the home position |
| cnc-moveto | x, y, z: the position to move to, speed: the relative speed, as a fraction of the absolute speed | None | |
| cnc-spindle | speed: the speed, between 0 and 1 | None | |
| cnc-travel | path: a list of [x, y, z] points, speed: the relative speed | None | |
| cnc-get-range | None | The dimensions of the CNC, as [[xmin, xmax], [ymin, ymax], [zmin, zmax]] | |
| cnc-helix | xc, yc: the center point of the arc, alpha: the angle of the arc, z: to z-position to move to, speed: the relative speed | None | |
| cnc-get-position | None  | Returns the position as {"x": x, "y": y, "z": z} | |


