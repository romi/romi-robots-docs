Communicating with the CNC
==========================

## Connect to the Arduino UNO

First you need to find which USB port your arduino is connected to.

To do so, you can use ``dmesg``:

1. make sure the usb cable from the arduino is unplugged
2. run ``dmesg -w`` in a terminal
3. connect the usb and see something like:

```shell
[70480.940181] usb 1-2: new full-speed USB device number 31 using xhci_hcd
[70481.090857] usb 1-2: New USB device found, idVendor=2a03, idProduct=0043, bcdDevice= 0.01
[70481.090862] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=220
[70481.090865] usb 1-2: Product: Arduino Uno
[70481.090868] usb 1-2: Manufacturer: Arduino Srl            
[70481.090871] usb 1-2: SerialNumber: 554313131383512001F0
[70481.093408] cdc_acm 1-2:1.0: ttyACM0: USB ACM device
```

!!! important
    The important info here is ``ttyACM0``!

Then you can use [picocom](https://github.com/npat-efault/picocom) to connect to the arduino:

```shell
picocom /dev/ttyACM0 -b 115200 --omap crcrlf --echo
```

!!! note
    `-b 115200` is the baud rate of the connection, read the [picocom man page](https://linux.die.net/man/8/picocom) for more info.
    `--omap crcrlf` is mapping the serial output from `CR` to `CR+LF`.
    `--echo` allows you to see what you are typing.

Once connected you should see something like:

```shell
picocom v2.2

port is        : /dev/ttyACM0
flowcontrol    : none
baudrate is    : 115200
parity is      : none
databits are   : 8
stopbits are   : 1
escape is      : C-a
local echo is  : no
noinit is      : no
noreset is     : no
nolock is      : no
send_cmd is    : sz -vv
receive_cmd is : rz -vv -E
imap is        : 
omap is        : 
emap is        : crcrlf,delbs,

Type [C-a] [C-h] to see available commands

Terminal ready

Grbl 1.1f ['$' for help]
[MSG:'$H'|'$X' to unlock]
```

This mean you now have access to a Grbl terminal (`Grbl 1.1f`) to communicate, notably send instructions, to the CNC!

## Troubleshooting

### Serial access denied

Look [here](troubleshooting.md#serial-access-denied) if you can not communicate with the scanner using usb.
