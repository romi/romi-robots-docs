---
hide:
  - toc
---
Wirebot
=======

## Main Board and Eletronics
### Raspberry Pi - packages, Dependencies and Configurations
1. Download the [image](https://downloads.ubiquityrobotics.com/pi.html) Robotics Ubuntu+ROS Raspberry Pi Image (3B+ Support) that comes with Ubuntu 16.04 (LXDE), and ROS Kinetic.
2. Copy the image to the SD card. Instructions [here.](https://www.raspberrypi.org/documentation/installation/installing-images/README.md)
3. Resizes the file system to fill the SD card before booting following this instructions.
* Acces to the  raspi-config utility:
    
```bash
$computer:~$sudo raspi-config
```

* Choose "Expand root partition to fill SD card" option:![](https://i.imgur.com/XTUVbGV.png)

5. The Ubiquityrobotics images come up as a Wifi acces point. The SSID is ubiquityrobotXXXX where XXXX is part of the MAC address. Connect to the wifi hostopost and use folowing wifi password:

```bash
robotseverywhere
```
 
6. Once connected, it is possible to log into the Pi with ssh ubuntu@10.42.0.1 with the following password of:

```bash
ubuntu
```

7. Desable the default robots and node runing on the pi.

```bash
$ ubuntu@ubiquityrobot.local:$sudo systemctl disable magni-base
``` 

### Raspberry Pi - Setting up the WIREDBOT to the Network

1. Open a new terminal window, and log in to the robot with ssh:

**ATENTION**: The HOSTNAME for firts time is “ubiquityrobot.local”.

```bash
$ computer:~$ssh ubuntu@ubiquityrobot.local
```

**ATENTION**: The password for firts time is “ubuntu”.

2. Change the hostname using pifi. Type the following command:

```bash
$ ubuntu@ubiquityrobot.local:~$sudo pifi set-hostname wiredbot
```

3. Reboot the Pi.

```bash
$ ubuntu@ubiquityrobot.local:~$sudo reboot
```

4. Log in to the robot with the new hostname "wiredbot":

```bash
$ computer:~$ssh ubuntu@wiredbot.local
```

5. Use pifi to list the nearby networks:

```bash
$ ubuntu@wiredbot:~$pifi list seen
```

**ATENTION**: Search for the network where the robots are connected.

6. Swich to to the desire network by using the following command.

```bash
$ ubuntu@NEWHOSTNAME:~$sudo pifi add localNetwork password
```

**ATTENTION**: The keyword "localNetwork" on this documentation refert to the network the robot need to be connected. The keyword "pass" on this documentation refer to the password of the network.

7. Reboot the Pi.

```bash
$ ubuntu@wiredbot:~$sudo reboot
```

8. Test the connectivity with the Pi. Open a new terminal window on a external on a diferent computer:

```bash
$ computer:~$ping wirebot.local
```
**TIP**: Press control-c to stop the pinging
**ADVERTENCE**: If something goes wrong, the PI will come back up as access point mode. Search on the network for the name ubiquityrobot, reboot and start over.

9. Log into the PI by using:

```bash
$ computer:~$ssh ubuntu@wirebot.local

```

the output will be:
```bash
The authenticity of host ‘10.0.0.113 (10.0.0.113)’ can’t be established. ECDSA key fingerprint is SHA256:sDDeGZzL8FPY3kMmvhwjPC9wH+mGsAxJL/dNXpoYnsc. Are you sure you want to continue connecting (yes/no)?
```

continue by wrinting:

```bash
$ computer:~$yes
```

the password is still.

```bash
ubuntu
```

10. Update and updagrade de Pi.

```bash
$ ubuntu@wiredbot:~$sudo apt-get update
```

```bash
$ ubuntu@wiredbot:~$sudo apt-get upgrade
```

### ROS - Setting up the ROS NODES and Arduino Firmware.

1. Make sure you have installed the resent updates and updagrades.

```bash
$ ubuntu@wiredbot:~$sudo apt-get update
```

```bash
$ ubuntu@wiredbot:~$sudo apt-get upgrade
```

2. Point to the workspace folder for ros packages

3. Clone the repository on the Pi, the romi/grlbl_serial into the /src folder of your catkin workspace and rebuild your workspace:

```bash
$ ubuntu@wiredbot:~$cd ~/catkin_ws/src/
```
```bash
$ ubuntu@wiredbot:~$git clone git@github.com:romi/grlbl_serial.git
```
```bash
$ ubuntu@wiredbot:~$catkin_make
```

4. Clone the repository on the Pi, the romi/i2c_pca9685_driver  into the /src folder of your catkin workspace and rebuild your workspace:

```bash
$ ubuntu@wiredbot:~$cd ~/catkin_ws/src/
```
```bash
$ ubuntu@wiredbot:~$git clone git@github.com:romi/i2c_pca9685_driver.git
```
```bash
$ ubuntu@wiredbot:~$catkin_make
```

### Wiring diagram.

1. Schematics:
![](https://i.imgur.com/trWLiE3.png)

2. List Part

| Item | Description | Quantity |
| -------- | -------- | -------- |
| 0  | Raspberry pi model 3b+                              | 1  |
| 1  | Raspberry Pi Camera Module v2                       | 1  |
| 2  | 16-Channel 12-bit - I2C interface - PCA9685         | 1  |
| 3  | Arduino UNO                                         | 1  |
| 4  | Arduino CNC Shield V3                               | 1  |
| 5  | A4988 Stepper Motor Driver                          | 4  |
| 6  | Nema 23 Unipolar 1.8deg                             | 1  |
| 7  | Survey3W Camera - Orange+Cyan+NIR (OCN, NDVI)       | 1  |
| 8  | Survey3W HDMI PWM Trigger Cable                     | 1  |
| 9  | Survey3 Advanced GPS Receiver                       | 1  |
| 10 | 12V Power Supply                                    | 1  |
| 11 | Wires and general hardware                          | -  |

## Hardware Setup.

1.Drawings
* Assebly drawing - Top view ![](https://i.imgur.com/Hm89GiT.png)
* Assebly drawing - Botton View ![](https://i.imgur.com/kCCWUAc.jpg)

2. List Part

| Item | Description | Quantity |
| -------- | -------- | -------- |
| 0  | Aluminium Profile 20×20 T-Slot 5                              | 4  |
| 1  | Idler Pulley Plate                                            | 6  |
| 2  | Join Plat T                                                   | 4  |
| 3  | Corner connector 90 degree (V-Slot)                           | 2  |
| 4  | Gantry Plate V-Slot 20-80                                     | 2  |
| 5  | 3M Drop in Tee Nuts – Insert nuts                             | 50 |
| 6  | 3M Allen Low Profile Screws                                   | 50 |
| 7  | M8 Allen Screw - 45mm Long                                    | 6  |
| 8  | Motor Mount Plate NEMA 23                                     | 1  |
| 9  | Nylon Pulley And Wheel - 40 mm Diameter - 8 mm Bearing        | 6  |
| 10 | Nema 23 stepper motor                                         | 1  |
| 11 | P65 Weatherproof Enclosure/electrical enclosure box           | 2  |
| 12 | 5mm Shock Cord - Marine Grade Polyester Coated Rubber Rope    | -  |



## Running ROS node - Path Planning
1. ROS Nodes Overview.

![](https://i.imgur.com/HC6vxM0.jpg)

2. ROS Master - Run ROS Nodes over the raspberry PI.

* Log into the raspberry PI by using:

```bash
$ computer:~$ssh ubuntu@wirebot.local
```

* (OPTIONAL) Edit the path planning according to the dimensions of the field to scan and the desired length and amount of waypoints.

```bash
$ ubuntu@ubiquityrobot.local:~$sudo nano ~/catkin_ws/src/grlbl_serial/src/path_planning_action_client.py
```
* Edit the path_planning_action_client.py by changing the variable **movement_goal.xyz_position** that is under the function **def path_planning_client()**. Here is an example of a Path planning that takes pictures of every 500mm in a distance of 10mts:
```
    movement_goal.xyz_position = ["{'x':0, 'y':0, 'z':500, 'delay':20}",
                                  "{'x':0, 'y':0, 'z':1000, 'delay':20}",
                                  "{'x':0, 'y':0, 'z':1500, 'delay':20}",
                                  "{'x':0, 'y':0, 'z':2000, 'delay':20}",
                                  "{'x':0, 'y':0, 'z':2500, 'delay':20}",
                                  "{'x':0, 'y':0, 'z':3000, 'delay':20}",
                                  "{'x':0, 'y':0, 'z':3500, 'delay':20}",
                                  "{'x':0, 'y':0, 'z':4000, 'delay':20}",
                                  "{'x':0, 'y':0, 'z':4500, 'delay':20}",
                                  "{'x':0, 'y':0, 'z':5000, 'delay':20}",
                                  "{'x':0, 'y':0, 'z':5500, 'delay':20}",
                                  "{'x':0, 'y':0, 'z':6000, 'delay':20}",
                                  "{'x':0, 'y':0, 'z':6500, 'delay':20}",
                                  "{'x':0, 'y':0, 'z':7000, 'delay':20}",
                                  "{'x':0, 'y':0, 'z':7500, 'delay':20}",
                                  "{'x':0, 'y':0, 'z':8000, 'delay':20}",
                                  "{'x':0, 'y':0, 'z':8500, 'delay':20}",
                                  "{'x':0, 'y':0, 'z':9000, 'delay':20}",
                                  "{'x':0, 'y':0, 'z':9500, 'delay':20}"]
```

* Start up the nodes and the ROS master by launching the path_planning_action_server_node node under the raspberry PI:


```bash
$ ubuntu@ubiquityrobot.local:~$roslaunch grlbl_serial path_planning_action_server_node.launch
```

* **(ADVERTENCE)** If the ROS package is not under the autocomplete method of the terminal. The problem will be solve by sourcing the devel/setup.bash.

```bash
$ ubuntu@ubiquityrobot.local:~$source ~/catkin_ws/src/devel/setup.bash
```
3. ROS Slave - Run ROS Nodes over the Remote Computer.

* Start up the nodes by launching the path_planning_action_client_node node under the remote computer:

```bash
$ ubuntu@ubiquityrobot.local:~$roslaunch grlbl_serial path_planning_action_client_node.launch
```

* **(OPTIONAL)** This node as well can by launch over the raspberry PI. This can be done by lauching the node over a new terminal.

* By launching the previous ROS node on the WIREDBOT. The starting process of collecting photos from the Mapir camera and the Raspi Cam will be launch automatically according to the path planning instructions save on the path_planning_action_client.py file.

### Saving the data from the WIREDBOT. (UNDER-DEVELOPMENT)

* Kepp running or re start  the node and the ROS master by launching the path_planning_action_server_node node under the raspberry PI:

```bash
$ ubuntu@ubiquityrobot.local:~$roslaunch grlbl_serial path_planning_action_server_node.launch
```

* Publish a 1500us to the /i2c_pca9685_driver wiredbot_PWMValues/wiredbot_PWMValues mapir_control_pwm:

```bash
$ ubuntu@ubiquityrobot.local:~$rostopic pub -1 /i2c_pca9685_driver wiredbot_PWMValues/wiredbot_PWMValues 
int16 mapir_control_pwm 1500
int16 motor_A_pwm
int16 motor_B_pwm
```

* Once ros is publishing the message mapir_control_pwm 1500us under the topic \i2c_pca9685_driver\wiredbot_PWMValues. The camera is ready to mount. On the raspberry PI. Mount the camera by using the following commands.

```bash
$ ubuntu@ubiquityrobot.local:~$mkdir /mapir
$ ubuntu@ubiquityrobot.local:~$mkdir sudo mount -t vfat /dev/sdb2 /mapir
$ ubuntu@ubiquityrobot.local:~$cd /mapir/DCMI/Photos
```
*

## Image Gallery - Valldaura:
1. Lettuce Think and Wirebot:

![](https://i.imgur.com/J2hgzgj.jpg)

2. Wirebot on the field:

![](https://i.imgur.com/fd3LhGe.jpg)

2. Wirebot on the field:

![](https://i.imgur.com/kwJfLmn.jpg)


## WIREBOT 3D Scans:










