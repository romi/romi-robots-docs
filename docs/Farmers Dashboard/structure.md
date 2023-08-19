# Structure

The whole design uses a CNC folded aluminium-plastic sandwich panel designed to provide adequate outdoor resistance while being light-weight.
The moving parts and other fixtures use custom 3D printed plastic (PLA/ABS).
All the cabling and electronics integrate into the internal structure to minimize damage caused by environmental factors.
The tension mechanism design allows it to move it from one cable to another as well to adapt to different cable tensions dynamically, and it uses a self-lubricated polymer to avoid maintenance.
All the parts can be made on a Fab Lab or other rapid prototyping facility with no customized tooling required.

![](/assets/images/farmersDashboard/despiece_CARM_BATM.png)

To facilitate documentation and assembly the Carrier Module is conceptually grouped in different parts:

The **_hands_** hold the lateral pulleys supporting the module on the cable; the **_arms_** are the main symmetrical structure, joined by the central part of the sliding dynamic tension mechanism; the **_head_** is the moving part that holds the motor ant ist electronics; and finally the **_body_** that holds everything together and works as a bridge for the cabling between the different components.

![](/assets/images/farmersDashboard/CARRM_parts.png)


## Hands

The miniature switches used as end stops are held by a 3d printed piece that integrates a plastic hinge as trigger element.
Integrated in the same housing are the 3d printed lateral pulleys held by a 608zz bearing.

![](/assets/images/farmersDashboard/endstop.png)


![](/assets/images/farmersDhboard/endstop-cable.png)

## Dynamic tension

The Farmers Dashboard carrier has a system the allows dynamic adaptation to different cable tensions, allowing a light motor torque to move even on high tension cables need to cover long distances and avoiding slips on low tension cables.

![](/assets/images/farmersDashboard/tension.gif)

Three pieces of machined HDPE in _sandwich_ form are used to allow smooth movement of the central part of the robot maintaining correct alignment.

![](/assets/images/farmersDashboard/slide.png)

To allow a bigger range of tensions pre-compression level of the springs can be adjusted by turning the three screws under the base piece.
By turning the front screws the level of friction between the HDPE slides can also be regulated.

![](/assets/images/farmersDashboard/spring-tension.png)

