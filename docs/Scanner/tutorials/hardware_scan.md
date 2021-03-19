Plant Imager Bot
===

## Objective
This tutorial will guide through the steps of acquiring images of a plant using the `plant imager` robot  
![Dense COLMAP reconstruction](../../assets/images/plant_imager.jpg){width=800 loading=lazy}  
In order to collect data in the process of plant phenotyping, the plant imager robot takes RGB images of an object following a particular path with precise camera poses.


## Prerequisite

To run an acquisition, you should previously have:

* built the scanner following the guidelines [here](../build/index.md)
* installed the necessary ROMI software [here](../install/plant_imager_setup.md) 
  (make sure you are in the conda environment or that you run properly the docker for the `plantimager` repository)
* interfaced the machine running the ROMI software with the plant imager
  (main steps: 
    1. check it is correctly connected to the Gimbal and CNC by USB
    2. turn on camera and connect it to the device via wifi)
* set up a [DB](../user_guide/data.md) (or do the following steps)

To quickly retrieve an example DB you can use:
```bash
wget https://db.romi-project.eu/models/test_db.tar.gz
tar -xf test_db.tar.gz
```
This will create a `integration_tests` folder with a ready to use test database.  

You can also generate a simple database with the following commands:
```bash
mkdir path/to/db
touch path/to/db/db/romidb
```


## Step by step tutorial

`Scan` is the basic task for running an acquisition with the robot.

A **default** configuration file for the plant imager can be found under `romiscanner/config/hardware.toml`.
It regroups :  
- specifications of the device setup (under the arguments linked to Scan.scanner)  
- parameters describing the acquisition path (ScanPath)  
- description of the object (in Scan.metadata.object)   
- description of the hardware (in Scan.metadata.hardware) 
```toml
[ScanPath] # Example, circular scan with 60 points:
class_name = "Circle"

[ScanPath.kwargs]
center_x = 375
center_y = 375
z = 80
tilt = 0
radius = 300
n_points = 60

[Scan.scanner.camera] # camera related parameters
module = "romiscanner.sony"
# module = "romiscanner.gp2"

#[Scan.scanner.camera.kwargs]
#url = "http://myflashair"

[Scan.scanner.camera.kwargs]
device_ip = "192.168.122.1"
api_port = "10000"
postview = true
use_flashair = false
rotation = 270

[Scan.scanner.gimbal] # module and kwargs linked to the gimbal
module = "romiscanner.blgimbal"

[Scan.scanner.gimbal.kwargs]
port = "/dev/ttyACM1"
has_tilt = false
zero_pan = 0
invert_rotation = true

[Scan.scanner.cnc] # module and kwargs linked to the CNC
module = "romiscanner.grbl"

[Scan.scanner.cnc.kwargs]
homing = true
port = "/dev/ttyACM0"

[Scan.metadata.workspace] # A volume containing the target scanned object
x = [ 200, 600,]
y = [ 200, 600,]
z = [ -100, 300,]

[Scan.metadata.object] # object related metadata
species = "chenopodium album"
seed_stock = "Col-0"
plant_id = "3dt_chenoA"
growth_environment = "Lyon-indoor"
growth_conditions = "SD+LD"
treatment = "None"
DAG = 40
sample = "main_stem"
experiment_id = "3dt_26-01-2021"
dataset_id = "3dt"

[Scan.metadata.hardware] # hardware related metadata
frame = "30profile v1"
X_motor = "X-Carve NEMA23"
Y_motor = "X-Carve NEMA23"
Z_motor = "X-Carve NEMA23"
pan_motor = "iPower Motor GM4108H-120T Brushless Gimbal Motor"
tilt_motor = "None"
sensor = "RX0"
```

!!! Warning
    This is a default configuration file. You will most probably need to create one to fit your hardware setup. 
    Check the configuration documentation for the [hardware](../metadata/hardware_metadata.md) and the [scanned object](../metadata/biological_metadata.md)

### Running an acquisition with the `Scan` task

Assuming you have an active database, you can now run a scan using `romi_run_task`:
```bash
romi_run_task --config config/hardware.toml Scan /path/to/db/scan_id/
```
where:

- `/path/to/db` must be an existing FSDB database
- there is no `/path/to/db/scan_id` already existing in the database.

This will create the corresponding folder and fill it with images from the scan.



### Creation of a scan

Once the acquisition is done, the database is updated and we now have the following tree structure:
```
db/
├── scan_id/
│   ├── images/
│   ├── metadata/
│   │   └── images/
│   │   └── images.json
│   └── files.json
│   └── scan.json
└── romidb
```

with:

- `images` containing a list of RGB images acquired by the camera moving around the plant
- `metadata/images` a folder filled with json files recording the poses (camera coordinates) for each taken image  
- `metadata/images.json` containing parameters of the acquisition that will be used later in reconstruction (type of format for the images, info on the object and the workspace)
- `files.json` detailing the files contained in the scan
- `scan.json`, a copy of the acquisition config file


You can now [reconstruct your plant in 3d](reconstruct_scan.md) !


## Troubleshooting

### Serial access denied
* Look [here](../build/troubleshooting.md#serial-access-denied) if you can not communicate with the scanner using usb.
* Make sure the device used to run the acquisition is well connected to the camera (wifi)
* Message to Gimbal still transiting :

```bash
Traceback (most recent call last):
  File "/home/romi/miniconda3/envs/scan_0.8/lib/python3.8/site-packages/serial/serialposix.py", line 265, in open
    self.fd = os.open(self.portstr, os.O_RDWR | os.O_NOCTTY | os.O_NONBLOCK)
OSError: [Errno 16] Device or resource busy: '/dev/ttyACM0'
```
Try deconnect and reconnect the USB link and rerun a Scan