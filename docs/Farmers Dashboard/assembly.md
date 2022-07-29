# Assembly guide

![](/assets/images/farmersDashboard/desk.jpg)


The cablebot assembly requires simple tools: Pliers, screwdrivers, allen keys and a plastic or wooden tool to apply pressure without damaging the pieces. 
For electronics assembly some extra tools are needed: solder station, cutting pliers, shrink tube and hot air gun. 

## Carrier module (CARM)

The carrier module is the most complex component and it has a lot of different parts, to make the assembly process simpler this module is divided into different groups of parts that can be constructed independently and latter joint together.

* Head
* Body
* Arms (left and right)
* Hands (Left and right)

![](/assets/images/farmersDashboard/CARRM_parts.png)


### Hands (left and right)

There are two _hands_ on the CARM module, left and right. The assembly process for both is the same so we only show it once. This pieces hold the pulleys that are in direct contact with the cable on both extremes. They also hold the two end stops switches that detect obstacles along the path.

![](/assets/images/farmersDashboard/assembly/hands/despiece_hand.png)

### BOM

#### 3d printed parts
<img src="/assets/images/farmersDashboard/assembly/3d-print/Cablebot-Hand_end_stop_trigger_left.jpg" alt="Hand end stop trigger left" height="125px"/> <img src="/assets/images/farmersDashboard/assembly/3d-print/Cablebot-Hand_base_left.jpg" alt="Hand base left" height="125"/> <img src="/assets/images/farmersDashboard/assembly/3d-print/Cablebot-Pulley_608zz.jpg" alt="Pulley 608zz" height="125"/> <img src="/assets/images/farmersDashboard/assembly/3d-print/Cablebot-Hand_base_right.jpg" alt="Hand base right" height="125"/> <img src="/assets/images/farmersDashboard/assembly/3d-print/Cablebot-Hand_end_stop_trigger_right.jpg" alt="Hand end stop trigger right" height="125"/>

|       |                                                                                    |
| :---: | ---                                                                                |
| 1x    | [Hand end stop trigger left](https://github.com/romi/romi-cablebot/blob/main/Hardware/3d-Print/Cablebot-Hand_end_stop_trigger_left.stl)   |
| 1x    | [Hand base left](https://github.com/romi/romi-cablebot/blob/main/Hardware/3d-Print/Cablebot-Hand_base_left.stl)                           |
| 2x    | [Pulley 608zz](https://github.com/romi/romi-cablebot/blob/main/Hardware/3d-Print/Cablebot-Pulley_608zz.stl)                               |
| 1x    | [Hand base right](https://github.com/romi/romi-cablebot/blob/main/Hardware/3d-Print/Cablebot-Hand_base_right.stl)                         |
| 1x    | [Hand end stop trigger right](https://github.com/romi/romi-cablebot/blob/main/Hardware/3d-Print/Cablebot-Hand_end_stop_trigger_right.stl) |

#### Milled Alucobond parts
<img src="/assets/images/farmersDashboard/assembly/Milled-Alucobond/Cablebot-Hand_left_out_small.jpg" alt="Hand left out small" height="125"/>
<img src="/assets/images/farmersDashboard/assembly/Milled-Alucobond/Cablebot-Hand_left_middle_small.jpg" alt="Hand left middle small" height="125"/>
<img src="/assets/images/farmersDashboard/assembly/Milled-Alucobond/Cablebot-Hand_front_left.jpg" alt="Hand front left" height="125"/>
<img src="/assets/images/farmersDashboard/assembly/Milled-Alucobond/Cablebot-Hand_right_out_small.jpg" alt="Hand right out small" height="125"/>
<img src="/assets/images/farmersDashboard/assembly/Milled-Alucobond/Cablebot-Hand_right_middle_small.jpg" alt="Hand right middle small" height="125"/>
<img src="/assets/images/farmersDashboard/assembly/Milled-Alucobond/Cablebot-Hand_front_right.jpg" alt="Hand front right" height="125"/>
<img src="/assets/images/farmersDashboard/assembly/Milled-Alucobond/Cablebot-Hand_left_out_big.jpg" alt="Hand left out big" height="125"/>
<img src="/assets/images/farmersDashboard/assembly/Milled-Alucobond/Cablebot-Hand_left_middle_big.jpg" alt="Hand left middle big" height="125"/>
<img src="/assets/images/farmersDashboard/assembly/Milled-Alucobond/Cablebot-Hand_right_out_big.jpg" alt="Hand right out big" height="125"/>
<img src="/assets/images/farmersDashboard/assembly/Milled-Alucobond/Cablebot-Hand_right_middle_big.jpg" alt="Hand right middle big" height="125"/>

|       |                                                                                    |
| :---: | ---                                                                                |
| 1x    | [Hand left out small](https://github.com/romi/romi-cablebot/blob/main/Hardware/Milled-Alucobond/Cablebot-Hand_left_out_small.dxf)         |
| 1x    | [Hand left middle small](https://github.com/romi/romi-cablebot/blob/main/Hardware/Milled-Alucobond/Cablebot-Hand_left_middle_small.dxf)   |
| 1x    | [Hand front left](https://github.com/romi/romi-cablebot/blob/main/Hardware/Milled-Alucobond/Cablebot-Hand_front_left.dxf)                 |
| 1x    | [Hand right out small](https://github.com/romi/romi-cablebot/blob/main/Hardware/Milled-Alucobond/Cablebot-Hand_right_out_small.dxf)       |
| 1x    | [Hand right middle small](https://github.com/romi/romi-cablebot/blob/main/Hardware/Milled-Alucobond/Cablebot-Hand_right_middle_small.dxf) |
| 1x    | [Hand front right](https://github.com/romi/romi-cablebot/blob/main/Hardware/Milled-Alucobond/Cablebot-Hand_front_right.dxf)               |
| 1x    | [Hand left out big](https://github.com/romi/romi-cablebot/blob/main/Hardware/Milled-Alucobond/Cablebot-Hand_left_out_big.dxf)             |
| 1x    | [Hand left middle big](https://github.com/romi/romi-cablebot/blob/main/Hardware/Milled-Alucobond/Cablebot-Hand_left_middle_big.dxf)       |
| 1x    | [Hand right out big](https://github.com/romi/romi-cablebot/blob/main/Hardware/Milled-Alucobond/Cablebot-Hand_right_out_big.dxf)           |
| 1x    | [Hand right middle big](https://github.com/romi/romi-cablebot/blob/main/Hardware/Milled-Alucobond/Cablebot-Hand_right_middle_big.dxf)     |

Just one set is needed either _small_ or _big_, depending on cable tension (big is better for high tension).

#### Hardware parts

|||
|:---:| --- |
| 2 |	608zz bearing |
| 2 | D2F-01L-D3 End stop |
| 1 | Cable 28 AWG - Black - 450mm (left hand) | 
| 1 | Cable 28 AWG - Green - 450mm (left hand) |
| 1 | Cable 28 AWG - Black - 110mm (right hand)| 
| 1 | Cable 28 AWG - Green - 110mm (right hand)|
| 10 | Washer M8x1.5 |
| 2 | Screw M8x25 |
| 2 | Nut M8 |
| 4 | Screw M3x32 |
| 4 | Nut M8 |
| 2 | Screw M2x10 |
| 2 | Nut M2 |

## Assembly

![](/assets/images/farmersDashboard/assembly/hands/hands-00.jpg)
All the needed pieces, to build the right hand. 

![](/assets/images/farmersDashboard/assembly/hands/hands-01.jpg)
First install the end-stop (with the cables already soldered to it) inserting first the M2 nuts in the hexagonal holes.

![](/assets/images/farmersDashboard/assembly/hands/hands-02.jpg)
 Pass the cables through the hole to the back of the printed piece.

![](/assets/images/farmersDashboard/assembly/hands/hands-03.jpg)
And through the front hole in the alucobond piece.

![](/assets/images/farmersDashboard/assembly/hands/hands-04.jpg)
Align the two holes on both pieces.

![](/assets/images/farmersDashboard/assembly/hands/hands-05.jpg)

![](/assets/images/farmersDashboard/assembly/hands/hands-06.jpg)

![](/assets/images/farmersDashboard/assembly/hands/hands-07.jpg)
Pass the cable back to the front throungh the hole and align it with the pocket on the alucobond piece.

![](/assets/images/farmersDashboard/assembly/hands/hands-08.jpg)
Align and put toghether the two aluminum parts making sure not to pinch the cables.
After joining them check if the cable can move freely.

![](/assets/images/farmersDashboard/assembly/hands/hands-09.jpg)
Insert the M8 screw.

![](/assets/images/farmersDashboard/assembly/hands/hands-10.jpg)
Place the 5 washers on the screw.

![](/assets/images/farmersDashboard/assembly/hands/hands-11.jpg)
Before this step you need to pressure fit the 608zz bearing in to the 3d printed pulley, it can be done easily on a bench press, be sure to slide it until the end. We recomend applying a couple of cyanoacrylate glue drops between the two pieces.

Insert the bearing and the printed pulley on the M8 screw and fix it with the nut, be sure to apply enough pressure.

![](/assets/images/farmersDashboard/assembly/hands/hands-12.jpg)
Hold the end-stop trigger printed piece in place.

![](/assets/images/farmersDashboard/assembly/hands/hands-13.jpg)
Align the aluminum cap and insert the screw.

![](/assets/images/farmersDashboard/assembly/hands/hands-14.jpg)
While you push the screw be sure to keep the trigger aligned.

![](/assets/images/farmersDashboard/assembly/hands/hands-15.jpg)
Fix the nut on the back side.

![](/assets/images/farmersDashboard/assembly/hands/hands-16.jpg)
While keeping aligned the printed piece insert the other screw.

![](/assets/images/farmersDashboard/assembly/hands/hands-17.jpg)
Tighten both nuts.

![](/assets/images/farmersDashboard/assembly/hands/hands-18.jpg)
Your done with the right hand assembly!

![](/assets/images/farmersDashboard/assembly/hands/hands-19.jpg)
Follow the same procedure with the left hand so you can start with the arms.


### Left Arm

### Right Arm

### Head

### Body


## Battery module (BATM)


## Camera module (CAMM)


## Charging station module (CHAM)
