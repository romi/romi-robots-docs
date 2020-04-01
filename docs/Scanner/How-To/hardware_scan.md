How to use the plant scanner?
=======
!!! info
    Do this only if you want to control the hardware and scan plants with the open-source scanner!


## Getting started

To follows this guide you should have a `conda` or a Python `venv`, see [here](/Scanner/how-to/#how-to-install-romi-packages)

### Install ROMI packages with `pip`:

#### Install `romidata`:
Since we will need an active database to performs the reconstruction, we install it as follows:
```bash
pip install git+https://github.com/romi/data-storage.git@dev
```

To quickly create an example DB you can use:
```bash
wget https://db.romi-project.eu/models/test_db.tar.gz
tar -xf test_db.tar.gz
```
This will create a `integration_tests` folder with a ready to use test database. 

#### Install `lettucethink`:
```bash
pip install git+https://github.com/romi/lettucethink-python@dev
```

## Running scans
`Scan` is the basic task for running a task with the scanner.

A sample configuration file for the (real) scanner is as follows:
```toml
[Scan.scanner]
camera_firmware = "sony_wifi"
cnc_firmware = "grbl-v1.1"
gimbal_firmware = "blgimbal"

[Scan.scanner.scanner_args] # These are the kwargs passed to the scanner constructor
inverted = false

[Scan.scanner.camera_args] # These are the kwargs passed to the camera constructor
postview = true
device_ip = "10.0.2.66"
api_port = "10000"

[Scan.scanner.cnc_args] # These are kwargs passed to the CNC constructor
homing = true
port = "/dev/ttyUSB0"

[Scan.scanner.gimbal_args]
port = "/dev/ttyACM1"
has_tilt = false
zero_pan = 145

[Scan.scanner.camera_model] # This is a precalibrated camera model
width = 1616
height = 1080
id = 1
model = "OPENCV"
params = [ 1120.72122223961, 1120.72122223961, 808.0, 540.0, 0.0007513494532588769, 0.0007513494532588769, 0.0, 0.0,]

[Scan.scanner.workspace] # A volume containing the target scanned object
x = [ 200, 600,]
y = [ 200, 600,]
z = [ -100, 300,]

[Scan.path] # Example circular scan with 72 points:
type = "circular"

[Scan.path.args]
num_points = 3
radius = 350
tilt = 0.45 # rad
xc = 400
yc = 400
z = 0

[Scan.metadata]
key = value # Any metadata you want to add to the scan
```

To see available parameters for scanner, camera, CNC, check the `romiscanner` module.

!!! todo
    Add a link to the `romiscanner` documentation!

### 1. Create a configuration file
Create a file named `scanner.toml` with the following text, adjusting parameters as needed for the actual configuration of the scanner.
Check the `lettucethink` documentation for additional information.

!!! todo
    Add a link to the `lettucethink` documentation!

### 2. Launch the `Scan` task
Assuming you have an active database, you can nom run a scan using `romi_run_task`:
```bash
romi_run_task --config scanner.toml Scan /path/to/db/scan_id/ --local-scheduler
```
where:

- `/path/to/db` must be an existing FSDB database
- `scan_id` must not already exist in the database.

This will create the corresponding folder and fill it with images from the scan.