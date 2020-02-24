Scanner
=======

This is a document centralizing all documentation for the 3D scanner.
The 3D scanner software is composed of several python libraries organized in different packages:

* `romidata`: the data processing module
* `lettucethink`: the hardware interface
* `romiscan`: the computer vision algorithms
* `romiseg`: the segmentation models

Additionally, some [CGAL](https://www.cgal.org/) bindings are implemented in a separate python library: `cgal_bindings_skeletonization`.

A separate repository is dedicated to the virtual scanner, which is available as a blender python (bpy) script.


# Getting started

## Installation

There are some requirements to use the different algorithms in the pipeline.
Most of them are installed automatically from the requirements file when using pip.
The most important part is [Colmap](https://colmap.github.io/) (v3.6).

Preferably, create a virtual environment for python 3.7 or python 3.8 using `virtualenv` or a conda environment specific to the 3D Scanner. **Beware**: if using python 3.8, Open3D binaries are not yet available on pip, therefore you have to build Open3D from sources!

### A - Create a virtual environment
```bash
virtualenv -p /usr/bin/python3.7 scan3d && source scan3d/bin/activate
```

### B - Create a conda environment:
```bash
conda create -n scan3d
```


### Install `colmap`:
Follow the procedure from the official documentation [here](https://colmap.github.io/install.html#).
Make sure to use version 3.6.

TODO: use COLMAP python build [script](https://colmap.github.io/install.html#build-script) to make conda package?

Note: If you are using a conda environment, you can install `ceres-solver` dependency for COLMAP from the conda-forge channel:
```bash
conda install ceres-solver -c conda-forge
```


### Optional - Use NVIDIA for OpenCL
If you want to use NVIDIA for OpenCL in the processing pipeline, install `pyopencl` from source, and configure it to use OpenCL 1.2 (NVIDIA does not
support the default OpenCL 2.0).

First, make sure you have python headers installed, on ubuntu:
```bash
apt install python3.7-dev
```

Then install `pyopencl` from source, and configure it to use OpenCL 1.2:
```bash
git clone https://github.com/inducer/pyopencl
cd pyopencl
git submodule update --init
pip install pybind11 mako
./configure.py --cl-pretend-version=1.2 # NVIDIA has bad OpenCL support and only provides OpenCL 1.2
python setup.py install
cd ..
```

### Install `romidata`, `lettucethink` & `cgal_bindings_skeletonization` with `pip`:
To install directly using `pip`, you need `ssh` access to the ROMI repository on GitHub!

#### Install `romidata`:
```bash
pip install git+https://github.com/romi/data-storage.git@dev
```

#### Install `lettucethink`:
```bash
pip install git+https://github.com/romi/lettucethink-python@dev
```

#### Install `cgal_bindings_skeletonization`:
```bash
pip install git+https://github.com/romi/cgal_bindings_skeletonization
```
Note: this takes some time since it has to download dependencies and compile

#### Install `Scan3D`:

##### A - From sources:
Clone the Scan3D repository and install requirements
```bash
git clone https://github.com/romi/Scan3D
cd Scan3D
git checkout dev
pip install .
```

##### B - From `pip`:
```bash
pip install git+https://github.com/romi/Scan3D@dev
```

The `Scan3D` package is now installed. 


#### Optional - Install `romiseg`:
To install the additional segmentation module:
```bash
pip install git+ssh://git@github.com/romi/Segmentation@dev
```
(TODO: make `romiseg` public)

**Beware:** If not using CUDA 10.0, you have to install the matching pytorch distribution: for example,
for CUDA 9.2, use
```
pip install torch==1.4.0+cu92 -f https://download.pytorch.org/whl/torch_stable.html
```

## Initializing a Database

The `FSDB` class from the `romidata` module is used for data storage.
A database is any folder which contains a file named `romidb`.
To create an empty database, just create a new folder and an empty file named `romidb` in it.

# Processing pipelines

## Testing on a test db

Get the test DB from :
```bash
 wget https://db.romi-project.eu/models/test_db.tar.gz
```
Extract it:
```bash
tar -xvf test_db.tar.gz
```
Test the virtual plant pipeline on a virtual scan:
```bash
run-task --config Scan3D/default/segmentation2d_arabidopsis.toml PointCloud integration_tests/arabidopsis_26 --log-level DEBUG --local-scheduler
```
This should process all dependencies to obtain a segmented "PointCloud.ply" !

## Basic usage

Every task on the scanner is launched through the `run-task` command provided in
the `romiscan` module. It is a wrapper for `luigi`, with preloaded tasks from
the `romiscan` module.

The general usage is as follows:
```bash
run-task [-h] [--config CONFIG] [--luigicmd LUIGICMD] [--module MODULE]
[--local-scheduler] [--log-level LOG_LEVEL] task scan
```

* `CONFIG` is either a file or a folder. If a file, it must be `json` or `toml`
and contains the configuration of the task to run. If a folder, it will read all
configuration files in `json` or `toml` format from the folder.
* `LUIGICMD` is an optional parameter specifying an alternative command for
`luigi`.
* `MODULE` is an optional parameter for running task from external modules (see
TODO).
* `LOG_LEVEL` is the level of logging. Defaults to `INFO`, but can be set to
`DEBUG` to increase verbosity.
* `task` is the name of the class to run (see TODO)
* `scan` is the location of the target `scan` on which to process the task. It
is of the form `DB_LOCATION/SCAN_ID`, where `DB_LOCATION` is a path containing
the `romidb` marker.

## Configuration files

The configuration is in the form of a dictionary, in which each key is the ID of a given task.
In `toml` format, it reads as follows:
```toml
[FirstTask]
parameter1 = value1
parameter2 = value2
[SecondTask]
parameter1 = value1
parameter2 = value2
```

## Running scans

`Scan` is the basic task for running a task with the scanner. A sample
configuration file for the (real) scanner is as follows:

To see available parameters for scanner, camera, CNC, check the `lettucethink` module.

Create a file named `scanner.toml` with the following text, adjusting parameters as needed for the actual configuration of the scanner.
Check the `lettucethink` documentation for additional information.

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

Then, run a scan using
```bash
run-task --config scanner.json Scan /path/to/db/scan_id/ --local-scheduler
```
`/path/to/db` must be an existing FSDB database and `scan_id` must not already exist in the database.
This will create the corresponding folder and fill it with images from the scan.


## Pipelines

This is a sample configuration for the full pipeline:

```toml
[Colmap]
matcher = "exhaustive"
compute_dense = false

[Colmap.cli_args.feature_extractor]
"--ImageReader.single_camera" = "1"
"--SiftExtraction.use_gpu" = "1"

[Colmap.cli_args.exhaustive_matcher]
"--SiftMatching.use_gpu" = "1"

[Colmap.cli_args.model_aligner]
"--robust_alignment_max_error" = "10"

[Masks]
type = "excess_green"
dilation = 5
binarize = true
threshold = 0.0

[Voxels]
voxel_size = 1.0
type = "carving"

[PointCloud]
level_set_value = 1.0

[Visualization]
max_image_size = 1500
max_pcd_size = 10000
thumbnail_size = 150
pcd_source = "vox2pcd"
mesh_source = "delaunay"
```

To run the pipeline use `run-task`
```bash
run-task --config scanner.json AnglesAndInternodes /path/to/db/scan_id/ --local-scheduler
```

This will process all tasks up to the `AnglesAndInternodes` task.
Every task produces a `Fileset`, a subdirectory in the scan directory whose name starts the same as the task name.
The characters following are a hash of the configuration of the task, so that the outputs of the same task with different parameters can coexist in the same scan.
Any change in the parameters will make the needed task to be recomputed with subsequent calls of `run-task`.
Already computed tasks will be left untouched.

To recompute a task, just delete the corresponding folder in the scan directory and rerun `run-task`.

# Default task reference
default_modules = {
    "Scan": "romiscan.tasks.scan",
    "Clean": "romiscan.tasks.scan",
    "CalibrationScan": "romiscan.tasks.scan",
    "Colmap": "romiscan.tasks.colmap",
    "Undistorted": "romiscan.tasks.proc2d",
    "Masks": "romiscan.tasks.proc2d",
    "Segmentation2D": "romiscan.tasks.proc2d",
    "Voxels": "romiscan.tasks.cl",
    "PointCloud": "romiscan.tasks.proc3d",
    "TriangleMesh": "romiscan.tasks.proc3d",
    "CurveSkeleton": "romiscan.tasks.proc3d",
    "TreeGraph": "romiscan.tasks.arabidopsis",
    "AnglesAndInternodes": "romiscan.tasks.arabidopsis",
    "Visualization": "romiscan.tasks.visualization"
}

```
Class name: Scan
Module: romiscan.tasks.scan
Description: A task for running a scan, real or virtual.
Default upstream tasks: None
Parameters:
    - metadata (DictParameter) : metadata for the scan
    - scanner (DictParameter) : scanner hardware configuration (TODO: see hardware documentation)
    - path (DictParameter) : scanner path configuration (TODO: see hardware documentation)

Class name: CalibrationScan
Module: romiscan.tasks.scan
Description: A task for running a scan, real or virtual, with a calibration path. It is used to calibrate
    Colmap poses for subsequent scans. (TODO: see calibration documentation)
Default upstream tasks: None
Parameters:
    - metadata (DictParameter) : metadata for the scan
    - scanner (DictParameter) : scanner hardware configuration (TODO: see hardware documentation)
    - path (DictParameter) : scanner path configuration (TODO: see hardware documentation)
    - n_line : number of shots taken on the orthogonal calibration lines

Class name: Clean
Module: romiscan.tasks.scan
Description: Cleanup a scan, keeping only the "images" fileset and removing all computed pipelines.
Default upstream tasks: None
Parameters:
    - no_confirm (BoolParameter, default=False) : do not ask for confirmation in the command prompt.

Class name: Colmap
Module: romiscan.tasks.colmap
Description: Runs colmap on a given scan.
Default upstream tasks: Scan
Upstream task format: Fileset with image files
Output fileset format: images.json, cameras.json, points3D.json, sparse.ply [, dense.ply]
Parameters:
    - matcher (Parameter, default="exhaustive") : either "exhaustive" or "sequential" (TODO: see colmap documentation)
    - compute_dense (BoolParameter) : whether to run the dense colmap to obtain a dense point cloud
    - cli_args (DictParameter) : parameters for colmap command line prompts (TODO: see colmap documentation)
    - align_pcd (BoolParameter, default=True) : align point cloud on calibrated or metadata poses ?
    - calibration_scan_id (Parameter, default="") : ID of the calibration scan.

Class name: Undistorted
Module: romiscan.tasks.proc2d
Description: Undistorts images using computed intrinsic camera parameters
Default upstream tasks: Scan, Colmap
Upstream task format: Fileset with image files
Output fileset format: Fileset with image files

Class name: Masks
Module: romiscan.tasks.proc2d
Description: compute masks using several functions
Default upstream tasks: Undistorted
Upstream task format: Fileset with image files
Output fileset format: Fileset with grayscale or binary image files
Parameters:
    - type (Parameter) : "linear", "excess_green", "vesselness", "invert" (TODO: see segmentation documentation) 
    - parameters (ListParameter) : list of scalar parmeters, depends on type
    - dilation (IntParameter) : by how much to dilate masks if binary
    - binarize (BoolParameter, default=True) : binarize the masks
    - threshold (FloatParameter, default=0.0) : threshold for binarization
    - 
Class name: Segmentation2D
Module: romiscan.tasks.proc2d
Description: compute masks using trained deep learning models
Default upstream tasks: Undistorted
Upstream task format: Fileset with image files
Output fileset format: Fileset with grayscale image files, each corresponding to a given input image and class
Parameters:
    - query (DictParameter) : query to pass to upstream fileset. It filters file by metadata, e.g {"channel": "rgb"} will process
        only input files such that "channel" metadata is equal to "rgb".
    - labels (Parameter) : string of the form "a,b,c" such that a, b, c are the identifiers of the labels produced by the neural
      	network
    - Sx, Sy (IntParametr) : size of the input of the neural network. Input pictures are cropped in the center to this size.
    - model_segmentation_name : name of ".pt" file  that can be found at  `https://db.romi-project.eu/models`
    - 
Class name: Voxels
Module: romiscan.tasks.cl
Description: Computes a volume from backprojection of 2D segmented images
Default upstream tasks: 
    - upstream_mask: Masks
    - upstream_colmap: Colmap
Upstream task format:
    - upstream_mask: Fileset with grayscale images
    - upstream_colmap: Output of Colmap task
Output fileset format: npz file with as many arrays as classes
Parameters:
    - use_colmap_poses (BoolParameter, default=True): Either use precomputed camera poses or output from the Colmap task
    - voxel_size (FloatParameter): size of one side of voxels
    - type (Parameter): "carving" or "averaging" (TODO: See 3D documentation)
    - multiclass (BoolParameter, default=False): whether input data is single class or multiclass (e.g as an output of Segmentation2D)
    - log (BoolParameter, default=True), in the case of "averaging" type, whether to apply log when averaging values.
    
Class name: PointCloud
Module: romiscan.tasks.proc3d
Description: Computes a point cloud from volumetric voxel data (either single or multiclass)
Default upstream tasks: Voxels
Upstream task format: npz file with as many 3D array as classes
Output task format: single point cloud in ply. Metadata may include label name if multiclass.

Class name: TriangleMesh
Module: romiscan.tasks.proc3d
Description: Triangulates input point cloud. Currently ignores class data and needs only one connected component.
Default upstream tasks: PointCloud
Upstream task format: ply file
Output task format: ply triangle mesh file

Class name: CurveSkeleton
Module: romiscan.tasks.proc3d
Description: Creates a 3D curve skeleton
Default upstream tasks: TriangleMesh
Upstream task format: ply triangle mesh
Output task format: json with two entries "points" and "lines" (TODO: precise)

Class name: TreeGraph
Module: romiscan.tasks.arabidopsis
Description: Creates a tree graph of the plant
Default upstream tasks: CurveSkeleton
Upstream task format: json
Output task format: json (TODO: precise)

Class name; AnglesAndInternodes
Module: romiscan.tasks.arabidopsis
Description: Computes angles and internode
Default upstream tasks: TreeGraph
Upstream task format: json
Output task format: json (TODO: precise)
```

# Visualizer

## Running a development server for the visualizer

Clone the visualizer git repository :
```bash
git clone git@github.com:romi/sony_visualiseur-plantes-3d.git
cd sony_visualiseur-plantes-3d
```

Install node packages and build the pages:
```bash
npm install
```

Set the DB location using the `DB_LOCATION` environment variable:
```bash
export DB_LOCATION=/path/to/the/db
```

Launch the flask development server:
```bash
scanner-rest-api
```

Finally, start the frontend development server:
```bash
npm start
```

You can now access the visualizer on [http://localhost:3000](http://localhost:3000).

## Ready to run docker image

See: [*visualizer*](/dev/docker/#visualizer) docker image.


## Visualizer API reference

# Virtual scanner

## Basic usage

The virtual scanner works like an HTTP server using Blender.
First, make sure you have `blender` (>= 2.80) installed on your machine.

Then, clone the directory and access it:
```bash
git clone git@github.com:romi/blender_virtual_scanner.git
cd blender_virtual_scanner
```

You can obtain sample data for the scanner here, and put it in the data
folder.
```bash
wget https://db.romi-project.eu/models/arabidopsis_data.zip
unzip arabidopsis_data.zip -d data
```

To use custom data, it must consist in `.obj` file, in which each type of organ corresponds to a distinct mesh.
This mesh must have a single material whose name is the name of the organ.
The data dir must contain the `obj` and `mtl` files.

Additionally, background HDRI files can be downloaded from (hdri haven)[https://hdrihaven.com/].
Download `.hdr` files and put them in the `hdri` folder.

To start the virtual scanner, run the following script in blender:
```bash
blender [scene/texture.blend] -b -P scan.py
```

It will start an HTTP server on port `5000`.

## Preparing data
If you have 3D models with a single mesh

## Running a scan (with `romiscan` and `lettucethink`)

The virtual scanner is integrated in lettucethink-python, so that it can be used directly with the `Scan` task in `run-task`.

Here is a sample configuration for the virtual scanner creating 640x480 images with ground truth segmentation of organs.
The server mentioned above must be running before running `run-task`.

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

## Running the pipeline with ground-truth poses (without Colmap)

To run the pipeline without `colmap` and use the virtual scanner poses as a ground
truth, one must use set the following parameters:

```toml
[Voxels]
use_colmap_poses = false
[Masks]
upstream_task = Scan
```

Then the pipeline can be run as usual and `colmap` will not be run.

## Scanner API reference

### Objects

* `/objects` (GET): retrieve the list of `obj` files in the data folder that can be loaded.
* `/load_object/<object_id>` (GET) load the given object in the scene. Takes a translation vector as URL parameters (`dx`, `dy`, `dz`)

### Classes

* `/classes` (GET): retrieve the list of classes.

### Backgrounds

* `/backgrounds` (GET): retrieve the list of `hdr` files in the `hdri` folder that can be loaded.
* `/load_background/<background_id>` (GET) load the given background in the scene.

### Camera

* `/camera_intrinsics` (POST): set camera intrinsics. Keys: `width`, `height`, `focal`
* `/camera_pose` (POST): set camera pose. Keys: `tx`, `ty`, `tz`, `rx`, `ry`, `rz`

### Rendering

* `/render` (GET): gets the rendering of the scene
* `/render_class/<class_id>` (GET) renders the scene, with everything transparent except the given class

TODO: missing endpoints

[httpie](https://httpie.org/)

```
# Setup camera
http -f post http://localhost:5000/camera_intrinsics width=1920 height=1080 focal=35

# Load arabidopsis_0
http get 'http://localhost:5000/load_object/arabidopsis_0.obj?dx=10&dy=20&dz=1'

# Load "old tree in the park" background
http get http://127.0.0.1:5000/load_background/old_tree_in_city_park_8k.hdr

# Move camera
http -f post http://localhost:5000/camera_pose tx=-60 ty=0 tz=50 rx=60 ry=0 rz=-90

# Render scene and download image
http --download get http://localhost:5000/render

# Render only leaves
http --download get http://localhost:5000/render_class/Color_7
```
