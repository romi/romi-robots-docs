# PiCamera HQ

## BOM

To assemble a SINGLE PiCamera HQ, you will need the following list of materials:

| ID  | Name                              | Qty | Off the shelf / Custom | Material  | Manufacturer  | Serial number | Link                                                                                                                                                                                                                                                                     |
|-----|-----------------------------------|-----|------------------------|-----------|---------------|---------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 7   | Mounting Plate Rpi Zero Hq Camera | 1   | Custom                 | PMMA      |               |               | [dxf](../../assets/images/plant_imager_v3/manual_gimbal/Mounting_Plate_Rpi_Zero_Hq_Camera_V3.dxf)                                                                                                                                                                       |
| 21  | RaspberryPiZeroW                  | 1   | Off the Shelf          |           |               |               | [kubii.fr](https://www.kubii.fr/home/2077-kit-pi-zero-w-kubii-3272496009509.html?search_query=kit+pi+zero&results=91)                                                                                                                                                    |
| 22  | Raspberry Pi HQ Camera            | 1   | Off the Shelf          |           |               |               | [kubii.fr](https://www.kubii.fr/raspberry-pi-microbit/2950-camera-hq-officielle-633696492738.html)                                                                                                                                                                       |
| 23  | 6mm CS-mount lens                 | 1   | Off the Shelf          |           |               |               | [kubii.fr](https://www.kubii.fr/raspberry-pi-microbit/2952-lentille-grand-angle-officielle-6mm-3272496301498.html)                                                                                                                                                       |
| 24  | Ribbon cable                      | 1   | Off the Shelf          |           |               |               | [kubii.fr](https://www.kubii.fr/cameras-accessoires/1830-cable-pour-camera-pi-zero-edition-kubii-3272496006768.html)                                                                                                                                                     |
| 25  | 5mm M2.5 nylon screws             | 8   | Off the Shell          |           |               |               | [thepihut.com](https://thepihut.com/products/mounting-plate-for-high-quality-camera?variant=31867507048510)                                                                                                                                                              |

!!! note
    This is contained in the "Manual gimbal" BOM.


## Assembly

!!! todo
    Write assembly instructions!


## Software

### Flash Raspbian Lite OS

To flash the OS on the microSD, have a look at the official Raspberry Pi OS instructions [here](https://www.raspberrypi.com/software/).
We strongly advise to use the **Raspberry Pi Imager** to do so.


### Change the `hostname`
We strongly advise to give a specific `hostname` to each device to avoid having the all named `raspberrypi`.

Choose option A OR B, then reboot the RPi!

!!! Important
    RFCs mandate that a hostname's labels may contain only the ASCII letters 'a' through 'z' (case-insensitive), the digits '0' through '9', and the hyphen.
    Hostname labels cannot begin or end with a hyphen.
    No other symbols, punctuation characters, or blank spaces are permitted.

#### A. Using `raspi-config`
It is possible to change the hostname with the `raspi-config` tool:
```shell
sudo raspi-config
```
Then move to `1 System Options > S4 Hostname`.
Enter the desired hostname, _e.g._ `picamera1`, and hit `<OK>`.

#### B. Command-line
For example, we want to rename our first _romi-camera_ `picamera1`.
We can do so by changing `/etc/hostname` & `/etc/hosts` with:
```shell
export NEW_HNAME="picamera1"
sudo sed "s/raspberrypi/$NEW_HNAME/" /etc/hostname
sudo sed "s/raspberrypi/$NEW_HNAME/" /etc/hosts
```


### Create the `romi` user
Boot the RPi, login with the default `pi` user & `raspberry` password.
Then create the user `romi` with:
```shell
sudo adduser romi
```
This will also create the home directory for this user and ask for a password.

Add this user to `dialout`, `video` & `sudo` groups with:
```shell
sudo adduser romi dialout
sudo adduser romi video
sudo adduser romi sudo
```

!!! Warning
    We should probably give instructions to remove the default `pi` user, or at least to remove it from the `sudo` group?!
    `sudo deluser --remove-home pi`


### Install requirements
To install the requirements simply run:
```shell
sudo apt install build-essential cmake git libpng-dev libjpeg9-dev
```

We also deactivate something useless in our case (dynamic linker):
```shell
sudo mv /etc/ld.so.preload /etc/ld.so.preload.bak
```

### Clone the sources
To clone the sources from the ROMI GitHub repository, simply run:
```shell
git clone --branch ci_dev --recurse-submodules https://github.com/romi/romi-rover-build-and-test.git
```

!!! note
    The `--recurse-submodules` option will automatically initialize and update each submodule in the repository.

### Compile the sources
Then move to the cloned directory and compile the `romi-camera` app with:
```shell
cd romi-rover-build-and-test
mkdir build
cd build
cmake ..
make romi-camera
```