# Flashing Oquam on X-Controller

The ROMI project developed the `Oquam` firware as an alternative to `Grbl`.
To flash it on the X-Controller follow these instructions.

You will need the Arduino IDE.
On Ubuntu, with `snap`, do:
```shell
snap install arduino
```

## Download the sources
Start by downloading the `libromi` sources from the ROMI GitHub repository:

```shell
git clone https://github.com/romi/libromi.git
git checkout encoder_z
```

## Flashing the firmware

### Create a ZIP archive of the Arduino libraries
You will need to add the `RomiSerial` as extra library to the Arduino IDE.
It is located under `libromi/arduino_libraries/RomiSerial`.

To create a ZIP archive:
```shell
zip -r RomiSerial.zip RomiSerial
```

### Open the Arduino IDE
Open the `libromi/firmware/Oquam/Oquam.ino` sketch using `File > Open...` or with the <kbd>Ctrl + O</kbd> shortcut.
Then browse and select the INO file.

### Add the `RomiSerial` library
Add the `RomiSerial.zip` library using the `Sketch > Include Library > Add .ZIP Library...` menu.
Then browse and select the ZIP file.

### Select the board
Select the right board to upload to using the `Tools > Board` menu and select `Arduino UNO`.

### Power up the X-Controller
Connect the power cord and start the X-Controller.

### Select the USB port
Plug the USB cable and select the right USB port to upload to using `Tools > Port` menu.

See [find the USB port](#find-the-usb-port) to determine which port the X-Controller is connected to.

### Finally flash the firmware
You may now flash the firmware with the :material-arrow-right-bold-circle: icon below the main menu.

Wait for the IDE to indicate `Done uploading` on the status bar at the bottom right of the IDE window.
Then you can unplug safely!


## Troubleshooting

### Find the USB port

To find which USB port your arduino board is connected to, you can use ``dmesg``:

1. make sure the usb cable is unplugged
2. run ``dmesg -w`` in a terminal
3. connect the usb (from the arduino board to the computer) and you should see something like:

```shell
[14818.631347] usb 1-4: new full-speed USB device number 7 using xhci_hcd
[14818.787048] usb 1-4: New USB device found, idVendor=0403, idProduct=6001, bcdDevice= 6.00
[14818.787062] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[14818.787069] usb 1-4: Product: X-Controller
[14818.787073] usb 1-4: Manufacturer: Inventables
[14818.787077] usb 1-4: SerialNumber: XCONTROLLER6CFIRF
[14818.847148] usbcore: registered new interface driver usbserial_generic
[14818.847155] usbserial: USB Serial support registered for generic
[14818.851163] usbcore: registered new interface driver ftdi_sio
[14818.851179] usbserial: USB Serial support registered for FTDI USB Serial Device
[14818.851367] ftdi_sio 1-4:1.0: FTDI USB Serial Device converter detected
[14818.851402] usb 1-4: Detected FT232RL
[14818.851860] usb 1-4: FTDI USB Serial Device converter now attached to ttyUSB0
```

!!! important
    The important info here is ``ttyUSB0``!


### Serial access denied

If you get an error about permission access:

0. Check you selected the right USB port. If yes, proceed to the next steps.

1. To see which groups your `$USER` belongs to:
    ```shell
    groups ${USER}
    ```
    If you see the `dialout` group there, go back to checking the USB port!

2. If you are not in `dialout`:
    ```shell
    sudo gpasswd --add ${USER} dialout
    ```

3. Then log out for your session, and then log back in to see changes (with `groups ${USER}`).
