Communicating & controlling the gimball
=======================================

## Connect to the Feather M0

First you need to find which USB port your Feather M0 is connected to.

To do so, you can use ``dmesg``:

1. make sure the usb cable from the Feather M0 is unplugged
2. run ``dmesg -w`` in a terminal
3. connect the usb and see something like:
```shell
[70481.093408] cdc_acm 1-2:1.0: ttyACM1: USB ACM device
```

!!! important
    The important info here is ``ttyACM1``!

Then you can use [picocom](https://github.com/npat-efault/picocom) to connect to the Feather M0:
```shell
picocom /dev/ttyACM1 -b 115200
```

## Usage

Send plain text-formatted commands for the position or speed commands.
See the command list below:

* `x`: set velocity (unit: RPM)
* `X`: set target position (units: degrees)
* `c`: start the calibration of the encoder
* `C`: print results of the calibration
* `v`: print target velocity
* `p`: print PWM value

## Troubleshooting

### Serial access denied

Look [here](troubleshooting.md#serial-access-denied) if you can not communicate with the scanner using usb.
