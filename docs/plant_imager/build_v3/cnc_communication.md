# Communicating with Oquam


## USB port

First you need to find which USB port your X-Controller board is connected to.

To do so, you can use ``dmesg``:

1. make sure the usb cable from the X-Controller board is unplugged from your computer
2. run ``dmesg -w`` in a terminal
3. connect the usb to your computer and see something like:
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


## Connect with `picocom`

Then you can use [picocom](https://github.com/npat-efault/picocom) to connect to the board:

```shell
picocom /dev/ttyACM0 -b 115200
```

!!! note
    `-b 115200` is the baudrate of the connection, read the [picocom man page](https://linux.die.net/man/8/picocom) for more info.

Once connected you should see something like:

```shell
picocom v2.2


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
