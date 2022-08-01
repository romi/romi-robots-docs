# Get the pieces

# 3d print

![](/assets/images/farmersDashboard/printing.jpg)

![](/assets/images/farmersDashboard/printed_line_orange.png)

# Milling

## Aluminum composite

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


## Gcode generation

In the Romi Cablebot github [repository](https://github.com/romi/romi-cablebot/tree/main/Hardware/Milled-Alucobond) you can find all the drawings (in DXF format) to generate the needed gcode. In the files you will find different layers depending on the operation and the depth, in this example you can see the layer called _vcut_ for the folding marks, _pocket-0.95mm_ indicates a pocketing operation with a depth of 0.95 mm and _profiling_ to cut the piece. Keep in mind that you will need to add bridges on your piece, so it doesn't move during machining, this process is different depending on the CAM software you use.

![](/assets/images/farmersDashboard/dxf.png)

## Generating Gcode in Blender

[Blendercam](https://github.com/vilemduha/blendercam) is a free/libre addon that allows gcode generation inside blender, in this way we avoid the use of extra software and model exporting. Don't forget to check their  [documentation](https://github.com/vicobarberan/blendercam#-how-to-use-wiki).

To use it you need to clone the addon repository to some place in your computer:

~~~
git clone https://github.com/vilemduha/blendercam
~~~

Some python dependencies sould also be installed, you can do it with pip from the command line:

```
$ ./pip3 install shapely
$ ./pip3 install vtk
$ ./pip3 install Equation
```

[OpenCamLib](https://github.com/aewallin/opencamlib) is an optional dependency, but based on our tests we recommend its installation.

To activate the addon, in Blender, open the _Preferences_ window (_edit → preferences_).  
Clik on _File Paths_ button and enter the path where you cloned the blender CAM repository in the _Scripts_ field.

![](/assets/images/farmersDashboard/blender-preferences.png)

Save perferences and restart blender. Now enable it in _Add-ons_ section (preferences window).

![](/assets/images/farmersDashboard/blender-addons.png)

### Adding a post processor

After installing the addon you will need a postprocessor script that works with your specific CNC machine. If none of the included ones works for you, you can easily create your own:

**1.** Modify `scripts/addons/cam/__init__.py` and add a new _item_ on the **machineSettings** class (around line 125):

![](/assets/images/farmersDashboard/postprocessor.png)

**2.** Create a new file in `scripts/addons/cam/nc/` directory with your post processor name. (ej. `raptor.py`). You can copy an existing postprocessor and modify it to fit your needs.

**3.** Modify `scripts/addons/cam/gcodepath.py`, search for the `exportGcodePath()` function and add a condition for your post processor where you specify the extension of the file and the name of the module you just created on step 2.

There is example commit on what's needed to add a postprocessor [here](https://github.com/vilemduha/blendercam/pull/122/files). It is a little outdated (use `gcodepath.py` instead of `utils.py`) but can be used as a general guide.



### Steps to get folding traces
As an example on how to get the proper traces for alucobond milling with folding parts.

**1.** With the object cutting side pointing up, duplicate it and **rotate 90º** with the bottom corner as rotation point.

![](/assets/images/farmersDashboard/folding01.png){ width="300" }

**2.** Displace the duplicated part **2mm towards the center**. That's one millimeter per side of the folding axis.

![](/assets/images/farmersDashboard/folding02.png){ width="300" }

**3.** Repeat both steps on the other side

![](/assets/images/farmersDashboard/folding03.png){ width="300" } ![](/assets/images/farmersDashboard/folding04.png){ width="300" }

**4.** Create a line at 1mm from the part border (centered between both pieces)

![](/assets/images/farmersDashboard/folding05.png){ width="300" }

**5.** Repeat the process for the other side, now you have the V cutt milling traces

![](/assets/images/farmersDashboard/folding06.png){ width="300" }

**6.** Join the two parts, remove the vertices outside the bottom layer and create a bridge to join both parts.
This paths should be -2.2mm from the surface of the material (leaving a thikness of 0.8mm after cutting)

![](/assets/images/farmersDashboard/folding07.png){ width="300" }

Now you can process the part with blendercam to get the gcode.

## HDPE

For the tension adjusting slider some HDPE pieces need to be milled, the center piece is the more complicated since the milling has to be on both sides.

Feeds and speeds for HDPE:

| Tool           | RPM        | Feed Cut     | Feed Plunge  | Stepdown    |
| -------------- | ---------- | ------------ | ------------ | ----------- |
| 3 mm flat tool | 18,000 rpm | 2,000 mm/min | 2,000 mm/min | 1.4 mm/step |
| 6 mm flat tool | 18,000 rpm | 6,000 mm/min | 5,000 mm/min | 1.4 mm/step |

![](/assets/images/farmersDashboard/HDPE_line_blue.png)

