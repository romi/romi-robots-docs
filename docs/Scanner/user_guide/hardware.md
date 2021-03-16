Hardware setup and instructions
===============================

## Network overview

We start by introducing the general network design of the ROMI Plant Phenotyper:

<img src="/assets/images/scanner_network.png" alt="Plant Phenotyper - Network overview" width="800" />


## Hardware configuration files

To gather configuration information of the hardware we use `toml` files to define variables.
This allows for easy import in python.

For example, saving the following lines in a `config.toml`:
```toml
[Scan.scanner]
camera_firmware = "sony_wifi"
cnc_firmware = "grbl-v1.1"
gimbal_firmware = "blgimbal"
```

In python:
```python
>>> import toml
>>> conf = toml.load(open('config.toml'))
>>> print(conf)
{'Scan': {'scanner': {'camera_firmware': 'sony_wifi', 'cnc_firmware': 'grbl-v1.1', 'gimbal_firmware': 'blgimbal'}}}
>>> print(conf["Scan"]["scanner"]["camera_firmware"])
"sony_wifi"
```

## PiZero camera `rovercam`

**WORK IN PROGRESS!!!!!**

### Configuring the access point host software (hostapd)
Source: Raspberry Foundation [website](https://www.raspberrypi.org/documentation/configuration/wireless/access-point.md).

#### 1. General setup
Switch over to `systemd-networkd`:
```bash
# deinstall classic networking
sudo apt --autoremove purge ifupdown dhcpcd5 isc-dhcp-client isc-dhcp-common
rm -r /etc/network /etc/dhcp

# enable systemd-networkd
systemctl enable systemd-networkd.service

# setup systemd-resolved
systemctl enable systemd-resolved.service
apt --autoremove purge avahi-daemon
apt install libnss-resolve
ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
```

#### 2. Configure `wpa_supplicant` as access point

To configure `wpa_supplicant` as access point create this file with your settings for `country=`, `ssid=`, `psk=` and maybe `frequency=`.
You can just copy and paste this in one block to your command line beginning with cat and including both EOF (delimiter EOF will not get part of the file):
```
cat > /etc/wpa_supplicant/wpa_supplicant-wlan0.conf <<EOF
country=DE
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
    ssid="RPiNet"
    mode=2
    frequency=2437
    #key_mgmt=NONE   # uncomment this for an open hotspot
    # delete next 3 lines if key_mgmt=NONE
    key_mgmt=WPA-PSK
    proto=RSN WPA
    psk="password"
}
EOF
```

```bash
chmod 600 /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
systemctl disable wpa_supplicant.service
systemctl enable wpa_supplicant@wlan0.service
```

#### Setting up a stand alone access point
Example for this setup:
```bash
                 wifi
mobile-phone <~.~.~.~.~> (wlan0)RPi(eth0)
            \             /
           (dhcp)   192.168.4.1
```
Do "General setup" then create the following file to configure ``wlan0``.
We only have the access point. There is no ethernet device configured.

```bash
cat > /etc/systemd/network/08-wlan0.network <<EOF
[Match]
Name=wlan0
[Network]
Address=192.168.4.1/24
MulticastDNS=yes
DHCPServer=yes
EOF
```
If you want this then reboot.
That's it.
Otherwise go on, no need to reboot at this time.


## Troubleshooting

### Serial access denied
Look [here](../build/troubleshooting.md#serial-access-denied) if you can not communicate with the scanner using usb.
