---
hide:
  - toc
---
# The Carrier module (CARM)

![](/assets/images/farmersDashboard/cablebot.jpg)

**Size:** 388mm x 216mm x 90  
**Weight:** 1400gr  
**Max speed:** 2m/s (software limited)  
**Max payload:** 2500gr  
**Power consumption:** 1.5Wh on rest, 45Wh normal operation.  

The mobile carrier is an autonomous motion platform capable of travelling suspended on a single tensioned cable.
It can be attached to the cable in a few seconds and controlled manually vie RF remote control.
It integrates the Romi [Camera Module](camera.md) as image capture device to allow remote operation and autonomous scanning and image upload.
Includes [Battery module](power.md) that recharges automatically in the [Charging station module](station.md) while not scanning. 

The primary communication is achieved via Wi-Fi to interact with the farmer phone or laptop, the local farm server or to a remote instance through the internet.
Wi-Fi ensures enough bandwidth is available to perform the image uploads as well as over-the-air software updates, and it eliminates the need for customized gateways.
When a remote connection is required, and the farm does not have one, a Wi-Fi to 4G (or 5G) gateway is located in the recharging station at the cable end. 

![](/assets/images/farmersDashboard/Comm_Diagram.png)

