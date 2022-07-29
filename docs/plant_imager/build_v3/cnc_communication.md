# Communicating with Oquam


## USB port

First you need to find which USB port your X-Controller board is connected to.

To do so, you can use ``dmesg``:

1. make sure the usb cable from the X-Controller board is unplugged from your computer
2. run ``dmesg -w`` in a terminal
3. connect the usb to your computer and see something like:
    ```shell
    [42063.157605] usb 1-2: new full-speed USB device number 7 using xhci_hcd
    [42063.313985] usb 1-2: New USB device found, idVendor=0403, idProduct=6001, bcdDevice= 6.00
    [42063.313991] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
    [42063.313995] usb 1-2: Product: X-Controller
    [42063.313997] usb 1-2: Manufacturer: Inventables
    [42063.314000] usb 1-2: SerialNumber: XCONTROLLER6CFIRF
    [42063.317878] ftdi_sio 1-2:1.0: FTDI USB Serial Device converter detected
    [42063.317954] usb 1-2: Detected FT232RL
    [42063.318915] usb 1-2: FTDI USB Serial Device converter now attached to ttyUSB0
    ```

!!! important
    The important info here is ``ttyUSB0``!


## Connect with `picocom`

Then you can use [picocom](https://github.com/npat-efault/picocom) to connect to the board:

```shell
picocom /dev/ttyUSB0 -b 115200 --omap crcrlf
```

!!! note
    `-b 115200` is the baudrate of the connection, read the [picocom man page](https://linux.die.net/man/8/picocom) for more info.
    ` --omap crcrlf` is mapping the serial output from `CR` to `CR+LF`.

Once connected you should see something like:

```shell
picocom v3.1

port is        : /dev/ttyUSB0
flowcontrol    : none
baudrate is    : 115200
parity is      : none
databits are   : 8
stopbits are   : 1
escape is      : C-a
local echo is  : no
noinit is      : no
noreset is     : no
hangup is      : no
nolock is      : no
send_cmd is    : sz -vv
receive_cmd is : rz -vv -E
imap is        : 
omap is        : 
emap is        : crcrlf,delbs,
logfile is     : none
initstring     : none
exit_after is  : not set
exit is        : no

Type [C-a] [C-h] to see available commands
Terminal ready
#_Init OK:00f7
```

This mean you now have access to a `Oquam` terminal to communicate, notably send instructions, to the CNC!


## Troubleshooting

### Serial access denied

If you get an error about permission access:

1. Check in what group you are with:
    ```shell
    groups ${USER}
    ```

2. If you are not in `dialout`:
    ```shell
    sudo gpasswd --add ${USER} dialout
    ```

3. Then log out and back in to see changes!
