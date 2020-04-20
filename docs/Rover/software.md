Software Installation
=====================

## Overview

This document describes how to run and compile the software for the
ROMI Rover. If you are a developer looking for details on the source
code then have a look at the separate [Developer
Documentation](/Rover/developer).

## Prerequisites

The software of the rover runs on Linux. It is not tied to a specific
Linux distribution but we have tested it mostly on recent versions of
Debian (includin Raspian) and Ubuntu.

The software is mostly writen in C and depends on the following
libraries:

![](/assets/images/software-dependencies.svg)

- **libr**: Common code for the rcom and the libromi libraries. It
  provides some OS abstraction (for example for threads, memory
  allocation, file system, networking), some core functionality
  (logging, time), and some base classes (variable-size memory
  buffers, json parser, lists, serial
  connections). [Code](https://github.com/romi/libr)
    
- **rcom**: An inter-process communication framework. It provides
  real-time communication using UDP messages and high-level
  communication based on web protocols (HTTP, Websockets). It also
  includes several utilities to develop and manage rcom applications.
  [Code](https://github.com/romi/rcom)

- **libromi**: Base classes for the romi rover: fsdb (database with
  filesystem back-end), image loading and manipulations, …)
  [Code](https://github.com/romi/libromi)

- **romi-brush-motor-controller**: The motor
    controller. [Code](https://github.com/romi/romi-brush-motor-controller)

- **romi-rover**: All of the apps for the Romi rover. 
  [Code](https://github.com/romi/romi-rover)

By default, the rover uses a USB camera. It is possible to use the
Intel Realsense camera on the Picamera instead. In that case, you will
have to install additional libraries (see XXX).

## Installing a Raspberry Pi from scratch

We use the _Lite_ version of Raspbian. You can download it at
[https://www.raspberrypi.org/downloads/raspbian/](). There are several
ways to prepare the disk image for the RPi. Check the page at
[https://www.raspberrypi.org/documentation/installation/installing-images/]()
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
   Enable Camera
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

!!! tips "Quick install"
    ```bash
    #!/bin/bash

    # Install the dependencies
    sudo apt install build-essential cmake git libpng-dev libjpeg9-dev

    # Download, compile and install the libraries & apps
    for id in libr rcom libromi romi-rover; do
        echo ----------------------------------------------
        echo Compiling $id

        # Download or update the github repository
        if [ -d $id ]; then
            cd $id
            git pull
        else
            git clone https://github.com/romi/$id.git
            cd $id
        fi

        # Standard cmake build sequence
        mkdir -p build
        cd build
        cmake ..
        make
        sudo make install
        sudo ldconfig

        # Get ready for the next component
        cd ../..
    done
    ```

## Installing the romi-rover apps

You should first install the [libr](https://github.com/romi/libr),
[rcom](https://github.com/romi/rcom), and
[libromi](https://github.com/romi/libromi) libraries. Check out their
the Github pages for the installation instruction and the API
documentation.

You should also flash the motor controller to the Arduino
(instructions are available on
[Github](https://github.com/romi/romi-brush-motor-controller)) too.

Once that is done, the installation of the romi-rover apps is
straight-forward. First, check out the code:

```bash
$ git clone https://github.com/romi/romi-rover.git 
```

Then proceed to the compilation and installation:
```bash
$ cd romi-rover
$ mkdir build
$ cd build
$ cmake ..
$ make
$ sudo make install
```

## Compiling the picamera app

Although not currently used by the ROMI Rover, we have an Rcom app to
access the Picamera. To get it working, you will first have to install
the _raspicam_ library:

```bash
$ git clone https://github.com/cedricve/raspicam.git
$ cd raspicam/
$ mkdir build
$ cd build/
$ cmake ..
$ make
$ sudo make install
$ sudo ldconfig
```

Once raspicam is installed, you must re-run cmake to enable the
compilation of the picamera app:

```bash
$ cd romi-rover/build/
$ rm CMakeCache.txt
$ cmake .. -DWITH_PICAMERA=ON
$ make
$ sudo make install
```

## Compiling the realsense app

The fonctionality of the Realsense camera app is not complete. You can
use it to obtain RGB images and depth images (as BW PNG images). You
will first have to install
[_librealsense2_](https://github.com/IntelRealSense/librealsense/).

When librealsense is installed, re-run cmake to enable the compilation
of the realsense app:

```bash
$ cd romi-rover/build/
$ rm CMakeCache.txt
$ cmake .. -DWITH_REALSENSE=ON
$ make
$ sudo make install
```

## Configuration

### Configuring the romi-rover apps

In the directory /home/romi, create the following directories and copy
the default configuration and script files:

```bash
$ cd /home/romi
$ mkdir sessions
$ mkdir config
$ cp <romi-rover>/config/config-romi-rover.json config/
$ mkdir scripts
$ cp <romi-rover>/script/config-default.json scripts/
```

        "html": "<romi-rover>/interface/html",


### Starting the apps on boot 

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
/usr/local/bin/rclaunch /home/romi/config/config-romi-rover.json &
```



### Configuring the image uploads



## Annex: the apps and their options

```
    "fake_camera": {
        "image": "data/camera.jpg"
    },
```
