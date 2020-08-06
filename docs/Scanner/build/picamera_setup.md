PiCamera setup
==============

!!!warning
    This is a work in progress, Peter Hanappe is developing a new version!

## Getting started
To setup the PiCamera you first need to install a fresh OS on your Rapsberry Pi Zero W.

### Burn a new Raspberry Pi OS Lite image
We recommend the **Raspberry Pi Imager** tool to burn  a new Raspberry Pi OS (32-bit) Lite. 
You can find it [here](https://www.raspberrypi.org/downloads/).

Or you can download an official ZIP [here](https://www.raspberrypi.org/downloads/raspberry-pi-os/).

### Accessing the PiZero

#### A - Enable SSH remote access
After installing the Raspberry Pi OS, add an empty file `ssh` in the `boot` partition to enable SSH access.

!!!warning
    As we will later use the wifi from the PiZero to create an Access Point, we recommend to use the ethernet port to SSH in the PiZero.

#### B - Use local access
Otherwise use a screen and keyboard to access the PiZero.


### Raspberry Pi OS setup
Before installing the softwares, you have to configure some of the Raspberry Pi OS settings & change the password.

#### Change the password
For security reasons, you have to change the `pi` user password because the default is known by everyone!

Use the raspi-config` tool to do it:
```bash
sudo raspi-config
```

!!! warning
    The default password is `raspberry`!

#### Edit the timezone & locales
Change the timezone to get the right time from the PiZero clock!
You may also change the locales to suits your needs.

## Create the WiFi Access Point
We will now create the AP using command lines follwoing the tutorial from: https://learn.sparkfun.com/tutorials/setting-up-a-raspberry-pi-3-as-an-access-point/all.

You may also be interested by doing this with a graphical interface and we would highly recommend [raspap-webgui](https://github.com/billz/raspap-webgui).

### Install Packages
To install the required packages, enter the following into the console:
```bash
sudo apt-get -y install hostapd dnsmasq
```

### Set Static IP Address
Edit the `dhcpcd.conf` file:
```bash
sudo nano /etc/dhcpcd.conf
```
At the bottom of the file, add:
```
denyinterfaces wlan0
```
Save and exit by pressing `ctrl + x` and `y` when asked.

Next, we need to tell the Raspberry Pi to set a static IP address for the WiFi interface.
Open the interfaces file with the following command:
```bash
sudo nano /etc/network/interfaces
```
At the bottom of that file, add the following:
```
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp

allow-hotplug wlan0
iface wlan0 inet static
    address 192.168.0.1
    netmask 255.255.255.0
    network 192.168.0.0
    broadcast 192.168.0.255
```

### Configure Hostapd
We need to set up hostapd to tell it to broadcast a particular SSID and allow WiFi connections on a certain channel.
Edit the hostapd.conf file (this will create a new file, as one likely does not exist yet) with this command:
```
sudo nano /etc/hostapd/hostapd.conf
```
Enter the following into that file.
Feel fee to change the ssid (WiFi network name) and the wpa_passphrase (password to join the network) to whatever you'd like.
You can also change the channel to something in the 1-11 range (if channel 6 is too crowded in your area).
```
interface=wlan0
driver=nl80211
ssid=romi_hotspot
hw_mode=g
channel=6
ieee80211n=1
wmm_enabled=1
ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_key_mgmt=WPA-PSK
wpa_passphrase=raspberry
rsn_pairwise=CCMP
```
Save and exit by pressing `ctrl + x` and `y` when asked.

Unfortunately, `hostapd` does not know where to find this configuration file, so we need to provide its location to the hostapd startup script.

Open `/etc/default/hostapd`:
```bash
sudo nano /etc/default/hostapd
```
Find the line #DAEMON_CONF="" and replace it with:
```
DAEMON_CONF="/etc/hostapd/hostapd.conf"
```
Save and exit by pressing `ctrl + x` and `y` when asked.

### Configure Dnsmasq
Dnsmasq will help us automatically assign IP addresses as new devices connect to our network as well as work as a translation between network names and IP addresses.
The `.conf` file that comes with Dnsmasq has a lot of good information in it, so it might be worthwhile to save it (as a backup) rather than delete it.
After saving it, open a new one for editing:
```bash
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.bak
sudo nano /etc/dnsmasq.conf
```

In the blank file, paste in the text below.
```
interface=wlan0 
listen-address=192.168.0.1
bind-interfaces 
server=8.8.8.8
domain-needed
bogus-priv
dhcp-range=192.168.0.100,192.168.0.200,24h
```

### Test WiFi connection
Restart the Raspberry Pi using the following command:
```bash
sudo reboot
```

After your Pi restarts (no need to log in), you should see `romi_hotspot` appear as a potential wireless network from your computer.

Connect to it (the network password is raspberry, unless you changed it in the `hostapd.conf` file).
Then try to SSH it with:
```bash
ssh pi@192.138.0.1
```


## Install Python3 & pip
You will need the Python3 interpeter (Python>=3.6) to run the PiCamera server & `pip` to install the Picamera package.
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install python3 python3-pip
```
This will update the package manager, upgrade the system libraries & install Python3 & pip.

## Install Picamera package
Once you have `pip` you can install the `picamera` Python3 package:
```bash
pip3 install picamera
```

!!!note
    We do not create an isolated environment in this case since the sole purpose of the PiZero will be to act as a reponsive image server.

## Camera serve Python code
To capture and serve the images from the PiCamera, we use this Python script:

<script src="https://gist.github.com/jlegrand62/c24e454922f0cf203d6f9ed49f95ecc1.js"></script>

To upload it to your PiZero, from a terminal:
```bash
wget https://gist.github.com/jlegrand62/c24e454922f0cf203d6f9ed49f95ecc1/raw/c4cda40ff56984188dca928693852f3f7a317fa4/picamera_server.py
```

Now (test) start the server with:
```bash
python3 picamera_server.py
``` 

!!!todo
    Explain how to execute `python3 picamera_server.py` command at PiZero boot.