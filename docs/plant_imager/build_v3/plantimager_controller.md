# Plant Imager controller

We use a Raspberry Pi 4 as a "main controller" to:
1. control the CNC (with Oquam) over USB
2. create a local Wi-Fi network

It thus acts as an _access point_ for other devices, notably for the PiCamera(s) (Pi Zero W).

## Setup

### Flash Raspbian Lite OS

To flash the OS on the microSD, have a look at the official Raspberry Pi OS instructions [here](https://www.raspberrypi.com/software/).
We strongly advise to use the **Raspberry Pi Imager**.


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
Enter the desired hostname, _e.g._ `plant-imager`, and hit `<OK>`.

#### B. Command-line
For example, we want to rename our first _romi-camera_ `plant-imager`.
We can do so by changing `/etc/hostname` & `/etc/hosts` with:
```shell
export NEW_HNAME="plant-imager"
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


### Clone the sources
To clone the sources from the ROMI GitHub repository, simply run:
```shell
git clone --branch ci_dev --recurse-submodules https://github.com/romi/romi-rover-build-and-test.git
```

!!! note
    The `--recurse-submodules` option will automatically initialize and update each submodule in the repository.

### Compile the sources
Then move to the cloned directory and compile the `oquam` app with:
```shell
cd romi-rover-build-and-test
mkdir build
cd build
cmake ..
make oquam
```
