# The mobile carrier (cablebot)

![](/assets/images/farmersDashboard/cable-full.png)

The mobile carrier is an autonomous motion platform capable of travelling suspended on a single tensioned nylon cable. Its design allows it to move it from one cable to another as well to adapt to [different cable tensions dynamically](tension.md); those features are unique among other systems

![](/assets/images/farmersDashboard/cablebot-valldaura.png)

## Structure
The whole design uses a CNC folded aluminium-plastic sandwich panel designed to provide adequate outdoor resistance while being light-weight. The moving parts and other fixtures use custom 3D printed plastic (PLA/ABS). All the cabling and electronics integrate into the internal structure to minimize damage caused by environmental factors. The tension mechanism design allows it to move it from one cable to another as well to adapt to different cable tensions dynamically, and it uses a self-lubricated polymer to avoid maintenance. All the parts can be made on a Fab Lab or other rapid prototyping facility with no customized tooling required.

## Motion system
The platform is battery powered  (12V LiPo 2Ah) and uses a brushless servo motor (DFROBOT FIT0441) combined with an optical cable tracker (ADNS-9800) to precisely move using a close loop system. It also contains built-in end stops switches as well as an inertial measurement unit to ensure it can safely operate autonomously. 

## Control
The entire motion system is controlled by a low-cost and low-power microcontroller  (Microchip ATmega328) that interfaces with the camera module. The much powerful computer in the camera module runs the main logics and communication subsystem based on the software and hardware stack used in the Rover, ensuring modularity and scalability.  As both the camera module and the Rover run the Raspberry PI ARM based Linux architecture our software stack is portable across each one of the robots. Those ensuring the Rover and the carrier use the same remote management interfaces. Following that approach the carrier can be managed using the same standard RC remote controller for on-site  maintenance operations.

## Interface and management
The primary communication is achieved via Wi-Fi to interact with the farmer phone or laptop, the local farm server or to a remote instance through the internet. Wi-Fi ensures enough bandwidth is available to perform the image uploads as well as over-the-air software updates, and it eliminates the need for customized gateways. When a remote connection is required, and the farm does not have one, a Wi-Fi to 4G (or 5G) gateway is located in the recharging station at the cable end. 

