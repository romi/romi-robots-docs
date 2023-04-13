# How to use the `romi_run_task` generic command ?


We here assume you followed the "installation instructions" available [here](../install/index.md).

## Getting started

There are some requirements to use the different algorithms in the pipeline.
Most of them are installed automatically from the requirements file when using pip.
The most important part is [Colmap](https://colmap.github.io/) (v3.6).

The two requirements that are not shipped with `pip` are:

* [Colmap](https://colmap.github.io/) (v3.6 or v3.7) for the _structure from motion_ algorithms
* [Blender](https://www.blender.org/) (>= 2.93) to be able to use the _virtual plant imager_

Preferably, create a virtual environment for python 3.7 or python 3.8 using `virtualenv` or a conda environment specific to the 3D Scanner.

!!! warning
    If using python 3.8, Open3D binaries are not yet available on `pip`, therefore you have to build Open3D from sources!


## Basic usage

Every task is launched through the `romi_run_task` command provided in the `romitask` library.
It is a wrapper for `luigi`, with preloaded tasks from the `romitask`, `plantimager` & `plant3dvision` modules.

The general usage is as follows:

```shell
romi_run_task [-h]
              [--config CONFIG]
              [--luigicmd LUIGICMD]
              [--module MODULE]
              [--log-level {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
              [local-scheduler]
              task
              [dataset_path]
```

* `CONFIG` is either a file or a folder. If a file, it must be JSON or TOML and contains the configuration of the task to run. If a folder, it will read all  configuration files in JSON or TOML format from the folder.
* `LUIGICMD` is an optional parameter specifying an alternative command for `luigi`.
* `MODULE` is an optional parameter for running task from external modules (see TODO).
* `LOG_LEVEL` is the level of logging. Defaults to `INFO`, but can be set to `DEBUG` to increase verbosity.
* `task` is the name of the class to run, see [here]() for a list of task or have a look at the output of `romi_run_task -h` for a more up-to-date list
* `dataset_path` is the location of the target `Scan` on which to process the task. It is of the form `$DB_LOCATION/SCAN_ID`, where `$DB_LOCATION` is a path containing the `plantdb` marker.


## Defining the dataset path
To defines the `dataset_path` you can specify a dataset name like `my_scan_007`.

You may also use Unix pattern matching with "`*`" and "`?`" to select a list of scan dataset.
For example, in a DB with the following scan dataset: `test_1` `my_scan_test`, `my_scan_002`, `my_scan_007`, `my_scan_011`

- `$DB_LOCATION/*` will match ALL scan dataset
- `$DB_LOCATION/my_scan_*` will match `my_scan_test`, `my_scan_002`, `my_scan_007` & `my_scan_011`
- `$DB_LOCATION/my_scan_???` will match `my_scan_002`, `my_scan_007` & `my_scan_011`
- `$DB_LOCATION/my_scan_00?` will match `my_scan_002` & `my_scan_007`
- `$DB_LOCATION/my_scan_00*` will match `my_scan_002` & `my_scan_007`


## Configuration files

The configuration is in the form of a dictionary, in which each key is the ID of a given task.

In TOML format, it reads as follows:

```toml
[FirstTask]
parameter1 = value1
parameter2 = value2

[SecondTask]
parameter1 = value1
parameter2 = value2
```

An example TOML configuration file for the _geometric reconstruction pipeline_ of a point-cloud is:

```toml
[Colmap]
upstream_task = "ImagesFilesetExists"
matcher = "exhaustive"
compute_dense = false
align_pcd = true
use_gpu = true
single_camera = true
robust_alignment_max_error = 10

[Undistorted]
upstream_task = "ImagesFilesetExists"

[Masks]
upstream_task = "Undistorted"
query = "{\"channel\":\"rgb\"}"
type = "linear"
parameters = "[0, 1, 0]"
dilation = 3
binarize = true
threshold = 0.2

[Voxels]
upstream_mask = "Masks"
upstream_colmap = "Colmap"
voxel_size = 0.5
type = "carving"

[PointCloud]
upstream_task = "Voxels"
level_set_value = 0.0
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
MODULES = {
    # Scanning module:
    "Scan": "plantimager.tasks.scan",
    "ScannerToCenter": "plantimager.tasks.scan",
    "VirtualPlant": "plantimager.tasks.lpy",
    "VirtualScan": "plantimager.tasks.scan",
    "CalibrationScan": "plantimager.tasks.scan",
    "IntrinsicCalibrationScan": "plantimager.tasks.scan",
    # Calibration module:
    "CreateCharucoBoard" : "plant3dvision.tasks.calibration",
    "DetectCharuco" : "plant3dvision.tasks.calibration",
    "ExtrinsicCalibration" : "plant3dvision.tasks.calibration",
    "IntrinsicCalibration" : "plant3dvision.tasks.calibration",
    # Geometric reconstruction module:
    "Colmap": "plant3dvision.tasks.colmap",
    "Undistorted": "plant3dvision.tasks.proc2d",
    "Masks": "plant3dvision.tasks.proc2d",
    "Voxels": "plant3dvision.tasks.cl",
    "PointCloud": "plant3dvision.tasks.proc3d",
    "TriangleMesh": "plant3dvision.tasks.proc3d",
    "CurveSkeleton": "plant3dvision.tasks.proc3d",
    # Machine learning reconstruction module:
    "Segmentation2D": "plant3dvision.tasks.proc2d",
    "SegmentedPointCloud": "plant3dvision.tasks.proc3d",
    "ClusteredMesh": "plant3dvision.tasks.proc3d",
    "OrganSegmentation": "plant3dvision.tasks.proc3d",
    # Quantification module:
    "TreeGraph": "plant3dvision.tasks.arabidopsis",
    "AnglesAndInternodes": "plant3dvision.tasks.arabidopsis",
    # Evaluation module:
    "VoxelsGroundTruth": "plant3dvision.tasks.evaluation",
    "VoxelsEvaluation": "plant3dvision.tasks.evaluation",
    "PointCloudGroundTruth": "plant3dvision.tasks.evaluation",
    "PointCloudEvaluation": "plant3dvision.tasks.evaluation",
    "ClusteredMeshGroundTruth": "plant3dvision.tasks.evaluation",
    "SegmentedPointCloudEvaluation": "plant3dvision.tasks.evaluation",
    "Segmentation2DEvaluation": "plant3dvision.tasks.evaluation",
    "AnglesAndInternodesEvaluation": "plant3dvision.tasks.evaluation",
    "CylinderRadiusGroundTruth": "plant3dvision.tasks.evaluation",
    "CylinderRadiusEstimation": "plant3dvision.tasks.evaluation",
    # Visualization module:
    "Visualization": "plant3dvision.tasks.visualization",
    # Database module:
    "Clean": "romitask.task"
}

```

!!! warning
    This is for reference only, please update the changes in the code.
    This will be later replaced by a reference doc generated from the code!


