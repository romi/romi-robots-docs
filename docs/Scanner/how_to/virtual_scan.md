How to generate a virtual scan?
===

## Getting started

To follows this guide you should have:

* installed the necessary ROMI software [here](../install/virtual_plant_setup.md)
* access to a database, or use the provided examples


## Basic usage

The virtual scanner works like an HTTP server using Blender.
First, make sure you have `blender` (>= 2.80) installed on your machine.

!!! warning
    **DEPRECATED**
    Then, clone the directory and access it:
    ```bash
    git clone git@github.com:romi/blender_virtual_scanner.git
    cd blender_virtual_scanner
    ```

You can obtain sample data for the scanner here, and put it in the data folder.
```bash
wget https://db.romi-project.eu/models/arabidopsis_data.zip
unzip arabidopsis_data.zip -d data
```

To use custom data, it must consist in `.obj` file, in which each type of organ corresponds to a distinct mesh.
This mesh must have a single material whose name is the name of the organ.
The data dir must contain the `obj` and `mtl` files.

Additionally, background HDRI files can be downloaded from (hdri haven)[https://hdrihaven.com/].
Download `.hdr` files and put them in the `hdri` folder.

!!! warning
    **DEPRECATED**
    To start the virtual scanner, run the following script in blender:
    ```bash
    blender [scene/texture.blend] -b -P scan.py
    ```
    It will start an HTTP server on port `5000`.

### Preparing data
If you have 3D models with a single mesh

### Running a scan (with `romiscan` and `lettucethink`)

The virtual scanner is integrated in `lettucethink-python`, so that it can be used directly with the `Scan` task in `romi_run_task`.

!!! warning
    `lettucethink-python` is **DEPRECATED**

Here is a sample configuration for the virtual scanner creating 640x480 images with ground truth segmentation of organs.
The server mentioned above must be running before running `romi_run_task`.

```toml
[Scan.scanner]
camera_firmware = "virtual"
cnc_firmware = "virtual"
gimbal_firmware = "virtual"
id = "virtual"

[Scan.path]
id = "virtual"
type = "circular"

[Scan.scanner.scanner_args]
inverted = false

[Scan.scanner.camera_args]
width = 640
height = 480
focal = 25
render_ground_truth = true
load_object = "arabidopsis_0.obj?dx=10&dy=10&dz=-5"
load_background = "quarry_03_8k.hdr"

[Scan.scanner.cnc_args]

[Scan.scanner.gimbal_args]

[Scan.scanner.workspace]
x = [ 200, 600,]
y = [ 200, 600,]
z = [ -100, 300,]

[Scan.path.args]
num_points = 10
radius = 100
tilt = 0.45
xc = 0
yc = 0
z = 50
```

### Running the pipeline with ground-truth poses (without Colmap)
To run the pipeline without `colmap` and use the virtual scanner poses as a ground
truth, one must use set the following parameters:

```toml
[Voxels]
use_colmap_poses = false
[Masks]
upstream_task = Scan
```

Then the pipeline can be run as usual and `colmap` will not be run.


### Testing the reconstruction pipeline on a _virtual scan_

To test the plant reconstruction pipeline on an example _virtual scan_ (`arabidopsis_26`):
```bash
romi_run_task --config romiscan/config/original_pipe_0.toml PointCloud integration_tests/arabidopsis_26 --local-scheduler
```
This should process all dependencies to obtain a segmented "PointCloud.ply" !
