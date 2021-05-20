How to use the ROMI scanner software?
=======

We here assume you have followed the "installation instructions" available [here](../install/index.md).


## Getting started

There are some requirements to use the different algorithms in the pipeline.
Most of them are installed automatically from the requirements file when using pip.
The most important part is [Colmap](https://colmap.github.io/) (v3.6).

The two requirements that are not shipped with pip are:

* [Colmap](https://colmap.github.io/) (v3.6) for the structure from motion algorithms
* [Blender](https://www.blender.org/) (>= 2.81) for the virtual scanner

Preferably, create a virtual environment for python 3.7 or python 3.8 using `virtualenv` or a conda environment specific to the 3D Scanner.

!!! warning
    If using python 3.8, Open3D binaries are not yet available on pip, therefore you have to build Open3D from sources!



## Basic usage

Every task on the scanner is launched through the `romi_run_task` command provided in
the `romiscan` module. It is a wrapper for `luigi`, with preloaded tasks from
the `romiscan` module.

The general usage is as follows:
```shell
romi_run_task [-h] [--config CONFIG] [--luigicmd LUIGICMD] [--module MODULE]
[--local-scheduler] [--log-level LOG_LEVEL] task scan
```

* `CONFIG` is either a file or a folder. If a file, it must be `json` or `toml` and contains the configuration of the task to run. If a folder, it will read all configuration files in `json` or `toml` format from the folder.
* `LUIGICMD` is an optional parameter specifying an alternative command for `luigi`.
* `MODULE` is an optional parameter for running task from external modules (see TODO).
* `LOG_LEVEL` is the level of logging. Defaults to `INFO`, but can be set to `DEBUG` to increase verbosity.
* `task` is the name of the class to run (see TODO)
* `scan` is the location of the target `scan` on which to process the task. It is of the form `DB_LOCATION/SCAN_ID`, where `DB_LOCATION` is a path containing the `romidb` marker.


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

## Pipelines
This is a sample configuration for the _full reconstruction pipeline_:
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

To run the _full reconstruction pipeline_ use this configuration file with `romi_run_task`:
```shell
romi_run_task --config scanner.json AnglesAndInternodes /path/to/db/scan_id/ --local-scheduler
```

This will process all tasks up to the `AnglesAndInternodes` task.
Every task produces a `Fileset`, a subdirectory in the scan directory whose name starts the same as the task name.
The characters following are a hash of the configuration of the task, so that the outputs of the same task with different parameters can coexist in the same scan.
Any change in the parameters will make the needed task to be recomputed with subsequent calls of `romi_run_task`.
Already computed tasks will be left untouched.

To recompute a task, just delete the corresponding folder in the scan directory and rerun `romi_run_task`.

## Default task reference
```python
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

!!! warning
    This is for reference only, please update the changes in the code.
    This will be later replaced by a reference doc generated from the code!

```text
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
