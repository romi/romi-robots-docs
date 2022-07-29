# Get the pieces

## 3d print

![](/assets/images/farmersDashboard/printing.jpg)

- 3d printing advice
- materials
- slicing recomendations

imagen de la prusa imprimiendo...

![](/assets/images/farmersDashboard/printed_line_orange.png)


## Milling

### Aluminum composite

Some cablebot parts are milled in a composite panel consisting of two aluminium cover sheets and a polymer core, this material can also be bended if cutted at specific depth with a 90 degrees V end mill. In the cablebot [repository](https://github.com/romi/romi-cablebot/tree/main/Hardware/Milled-Alucobond) you can find all the parts as DXF files. Gcode has to be generated with specific settings for the used CNC machine.

![](/assets/images/farmersDashboard/milling_.jpg)

Feeds and speeds for V - Curve milling bit to bend alucobond

In our case we are using a high revolution spindle that works in between 18k-24k RPM. After some tests, we have found that this feeds and speeds work us well for cutting 3mm alucobond composite:

| Tool 			 | RPM        | Feed         | Feed plunge   | Stepdown     |
| ---------------| ---------- | ------------ | ------------- | ------------ |
| V carve - 90º  | 24,000 rpm | 5,000 mm/min | 3,000 mm/min  | 0.22 mm/step |
| 3 mm flat tool | 24,000 rpm | 5,000 mm/min | 3,000 mm/min  | 1.2 mm/step  |
| 6 mm flat tool | 18,000 rpm | 5,000 mm/min | 3,000 mm/min  | 1.7 mm/step  |

![](/assets/images/farmersDashboard/alucobond_line_grey.png)


### HDPE

For the tension adjusting slider some HDPE pieces need to be milled, the center piece is the more complicated since the milling has to be on both sides.

Feeds and speeds for HDPE:

| Tool           | RPM        | Feed Cut     | Feed Plunge  | Stepdown    |
| -------------- | ---------- | ------------ | ------------ | ----------- |
| 3 mm flat tool | 18,000 rpm | 2,000 mm/min | 2,000 mm/min | 1.4 mm/step |
| 6 mm flat tool | 18,000 rpm | 6,000 mm/min | 5,000 mm/min | 1.4 mm/step |

![](/assets/images/farmersDashboard/HDPE_line_blue.png)

