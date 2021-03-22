Docker container for ROMI virtual plant imager
=============================================

## Objective
The following sections aim to show you how to build the docker image and run the corresponding container of the [Virtual Plant Imager](https://github.com/romi/plant-imager)

## Prerequisites
In addition to having docker installed in your system, you must also install the nvidia gpu drivers, nvidia-docker (v2.0) and nvidia-container-toolkit.

This docker image has been tested successfully on:
`docker --version=19.03.6 | nvidia driver version=450.102.04 | CUDA version=11.0`

### Building the Docker image
In this repository, you will find a script `build.sh` in the `docker` directory.

```bash
    git clone https://github.com/romi/plant-imager.git
    cd plant-imager/
    cd docker/
    ./build.sh
```
This will create by default a docker image `plantimager:latest`.
Inside the docker image, a user is created and named as the one currently used by your system.
If you want more build options (specific branches, tags...etc), type `./build.sh --help`.

### Running the docker container
In the docker directory, you will find also a script named `run.sh`.

To show more options, type `./run.sh --help`


## Pre-requisites
For clarity let's defines some variables here:

* `ROMI_DB`: the ROMI database root directory (should contain a `romidb` file);
* `ROMI_CFG`: the directory containing the ROMI configurations (TOML files);

To defines these variable, in a terminal:
```bash
export ROMI_DB=/data/ROMI/DB
export ROMI_CFG=/data/ROMI/configs
```

### Get an example archive with arabidopsis model
Download & extract the example archive at the root directory of the romi database: 
```bash
wget --progress=bar -P $ROMI_DB https://media.romi-project.eu/data/vscan_data.tar.xz
tar -C $ROMI_DB/ -xvJf $ROMI_DB/vscan_data.tar.xz
```

### TOML config
Use the following configuration, replacing `<my_vscan>` with the name of the virtual scan dataset to create, *e.g.* `vscan_007`.

```toml
[ObjFileset]
scan_id = "<my_vscan>"

[HdriFileset]
scan_id = "vscan_data"

[LpyFileset]
scan_id = "vscan_data"

[PaletteFileset]
scan_id = "vscan_data"

[ScanPath]
class_name = "Circle"

[ScanPath.kwargs]
center_x = -2
center_y = 3
z = 34.17519302880196
tilt = 8
radius = 30
n_points = 72

[VirtualScan]
obj_fileset = "ObjFileset"
use_palette = true
use_hdri = true
load_scene = false
scene_file_id = "pot"
render_ground_truth = true

[VirtualScan.scanner]
width = 896
height = 896
focal = 24
flash = true
add_leaf_displacement = true

[Voxels]
type = "averaging"
voxel_size = 0.05
```

## Virtual scan of a model plant


### Start the docker container
Use the `roboticsmicrofarms/romiscanner` docker image:
```bash
export ROMI_DB=/data/ROMI/DB
export ROMI_CFG=/data/ROMI/configs

docker run --runtime=nvidia --gpus all \
    -v $ROMI_DB:/home/scanner/db \
    -v $ROMI_CFG:/home/scanner/configs \
    -it roboticsmicrofarms/romiscanner:latest bash
```


### Initialize a scan dataset
Use the `romi_import_folder` tool to import the required `data` into a new scan dataset, *e.g.* `vscan_007`:
```bash 
romi_import_folder ~/db/vscan_data/data/ ~/db/vscan_007/ --metadata ~/db/vscan_data/files.json
```

### Start a `VirtualScan` romi task
```bash
cd romiscanner/bin
romi_run_task VirtualScan ~/db/vscan_007 --config ~/romiscanner/config/vscan_obj.toml
```