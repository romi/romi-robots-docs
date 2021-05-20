Tasks metadata: parametrization
===============================

## Aim
They aim at keeping track of the parameters used by algorithms during any ROMI task.
They enable to trace back results and compare them.

## Database location

Located under the `metadata` directory of the plant scan dataset, these JSON files contain the parameters used to run the task and are produced by each task.

Examples of task metadata JSON file names:

```
AnglesAndInternodes_1_0_2_0_0_1_9e87e344e6.json
Colmap_True____feature_extrac_3bbfcb1413.json
Masks_True_5_out_9adb9db801.json
TreeGraph_out__CurveSkeleton_5dca9a2821.json
Undistorted_out_____fb3e3fa0ff.json
Voxels_False___background___False_0ac9c133f7.json
Visualization.json
```

The tasks ids are a concatenation of the task name, the first values of the first 3 parameters sorted by parameter name and a md5hash of the name/parameters as a cananocalised json (from luigi documentation of task_id_str)


## AnglesAndInternodes task

### Configuration

To configure this task, we use the `[AnglesAndInternodes]` section in the TOML configuration file.
For example:

```toml
[AnglesAndInternodes]
upstream_task = "TreeGraph"
characteristic_length = 1.0
stem_axis_inverted = false
```

### Database location

Found under `metadata/AnglesAndInternodes_*.json`.

### JSON example

Example of `metadata/AnglesAndInternodes_*.json` corresponding to the example TOML configuration file:

```json
{
    "task_params": {
        "characteristic_length": 1.0,
        "min_elongation_ratio": 2.0,
        "min_fruit_size": 0.1,
        "number_nn": 50,
        "output_file_id": "out",
        "scan_id": "",
        "stem_axis": 2,
        "stem_axis_inverted": "False",
        "upstream_task": "ClusteredMesh"
    }
}
```

## ClusteredMesh task

### Configuration

To configure this task, we use the `[Colmap]` section in the TOML configuration file.
For example:

```toml
[ClusteredMesh]
upstream_task = "SegmentedPointCloud"
min_vol = 1.0
min_length = 10.0
```

### Database location

Found under `metadata/ClusteredMesh_*.json`.

### JSON example

Example of `metadata/ClusteredMesh_*.json` corresponding to the example TOML configuration file:

```json
{
    "task_params": {
        "min_length": 10.0,
        "min_vol": 1.0,
        "output_file_id": "out",
        "scan_id": "",
        "upstream_task": "SegmentedPointCloud"
    }
}
```

## Colmap task

### Configuration

To configure this task, we use the `[Colmap]` section in the TOML configuration file.
For example:

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

[Colmap.bounding_box] # default to None
x = [150, 650]
y = [150, 650]
z = [-90, 300]
```

### Database location

Found under `metadata/Colmap_*.json`.

### JSON example

Example of `metadata/Colmap_*.json` corresponding to the example TOML configuration file:

```json
{
    "bounding_box": {
        "x": [
            282.3466418101626,
            590.7798175997629
        ],
        "y": [
            386.77943280470265,
            589.1307313142569
        ],
        "z": [
            22.820168903922998,
            259.7594718279537
        ]
    },
    "task_params": {
        "align_pcd": "True",
        "calibration_scan_id": "",
        "cli_args": {
            "exhaustive_matcher": {
                "--SiftMatching.use_gpu": "1"
            },
            "feature_extractor": {
                "--ImageReader.single_camera": "1",
                "--SiftExtraction.use_gpu": "1"
            },
            "model_aligner": {
                "--robust_alignment_max_error": "10"
            }
        },
        "compute_dense": "False",
        "matcher": "exhaustive",
        "output_file_id": "out",
        "scan_id": "",
        "upstream_task": "ImagesFilesetExists"
    }
}
```

## CurveSkeleton task

### Configuration

To configure this task, we use the `[CurveSkeleton]` section in the TOML configuration file.
For example:

```toml
[CurveSkeleton]
upstream_task = "TriangleMesh"
```

### Database location

Found under `metadata/CurveSkeleton_*.json`.

### JSON example

Example of `metadata/CurveSkeleton_*.json` corresponding to the example TOML configuration file:

```json
{
    "task_params": {
        "output_file_id": "out",
        "scan_id": "",
        "upstream_task": "TriangleMesh"
    }
}
```

## Masks task

### Configuration

To configure this task, we use the `[Masks]` section in the TOML configuration file.
Default parametrization based on linear masking.
For example:

```toml
[Masks]
upstream_task = "Undistorted"
type = "linear"
parameters = "[0,1,0]"
dilation = 5
binarize = true
threshold = 0.3
```

### Database location

Found under `metadata/Masks_*.json`.

### JSON example

Example of `metadata/Masks_*.json` corresponding to the example TOML configuration file:

```json
{
    "task_params": {
        "binarize": "True",
        "dilation": 5,
        "output_file_id": "out",
        "parameters": [
            0,
            1,
            0
        ],
        "query": {},
        "scan_id": "",
        "threshold": 0.3,
        "type": "linear",
        "upstream_task": "ImagesFilesetExists"
    }
}
```

## PointCloud task

### Configuration

To configure this task, we use the `[PointCloud]` section in the TOML configuration file.
For example:

```toml
[PointCloud]
upstream_task = "Voxels"
level_set_value = 1.0
log = false
background_prior= -200
min_contrast = 10.0
min_score = 0.2
```

### Database location

Found under `metadata/PointCloud_*.json`.

### JSON example

Example of `metadata/PointCloud_*.json`:

```json
{
    "task_params": {
        "background_prior": 0.5,
        "level_set_value": 1,
        "log": "False",
        "min_contrast": 10.0,
        "min_score": 0.2,
        "output_file_id": "out",
        "scan_id": "",
        "upstream_task": "Voxels"
    }
}
```

## Segmentation2D task

### Configuration

To configure this task, we use the `[Segmentation2D]` section in the TOML configuration file.
For example:

```toml
[Segmentation2D]
upstream_task = "Undistorted"
model_fileset = "ModelFileset"
query = "{\"channel\":\"rgb\"}"
model_id = "Resnetdataset_gl_png_896_896_epoch50"
resize = true
binarize = true
dilation = 1
Sx = 896
Sy = 896
epochs = 1
batch = 1
learning_rate = 0.0001
threshold = 0.0035

[ModelFileset]
scan_id = "models"
```

### Database location

Found under `metadata/Segmentation2D_*.json`.

### JSON example

Example of `metadata/Segmentation2D_*.json` corresponding to the example TOML configuration file:

```json
{
    "task_params": {
        "Sx": 896,
        "Sy": 896,
        "binarize": "True",
        "dilation": 1,
        "inverted_labels": [
            "background"
        ],
        "labels": [],
        "model_fileset": "ModelFileset",
        "model_id": "Resnetdataset_gl_png_896_896_epoch50",
        "output_file_id": "out",
        "query": {
            "channel": "rgb"
        },
        "resize": "True",
        "scan_id": "",
        "threshold": 0.0035,
        "upstream_task": "Undistorted"
    }
}
```

## SegmentedPointCloud task

### Configuration

To configure this task, we use the `[SegmentedPointCloud]` section in the TOML configuration file.
For example:

```toml
[SegmentedPointCloud]
upstream_segmentation = "Segmentation2D"
upstream_task = "PointCloud"
use_colmap_poses = true
```

### Database location

Found under `metadata/SegmentedPointCloud_*.json`.

### JSON example

Example of `metadata/SegmentedPointCloud_*.json` corresponding to the example TOML configuration file:

```json
{
    "task_params": {
        "output_file_id": "out",
        "scan_id": "",
        "upstream_segmentation": "Segmentation2D",
        "upstream_task": "PointCloud",
        "use_colmap_poses": "True"
    }
}
```

## TreeGraph task

### Configuration

To configure this task, we use the `[TreeGraph]` section in the TOML configuration file.
For example:

```toml
[TreeGraph]
upstream_task = "CurveSkeleton"
z_axis = 2
stem_axis_inverted = false
```

### Database location

Found under `metadata/TreeGraph_*.json`.

### JSON example

Example of `metadata/TreeGraph_*.json` corresponding to the example TOML configuration file:

```json
{
    "task_params": {
        "output_file_id": "out",
        "scan_id": "",
        "upstream_task": "CurveSkeleton",
        "z_axis": 2,
        "z_orientation": 1
    }
}
```

## TriangleMesh task

### Configuration

To configure this task, we use the `[TriangleMesh]` section in the TOML configuration file.
For example:

```toml
[TriangleMesh]
upstream_task = "PointCloud"
```

### Database location

Found under `metadata/TriangleMesh_*.json`.

### JSON example

Example of `metadata/TriangleMesh_*.json` corresponding to the example TOML configuration file:

```json
{
    "task_params": {
        "output_file_id": "out",
        "scan_id": "",
        "upstream_task": "PointCloud"
    }
}
```

## Undistorted task

### Configuration

To configure this task, we use the `[Undistorted]` section in the TOML configuration file.
For example:

```toml
[Undistorted]
upstream_task = "ImagesFilesetExists"
```

### Database location

Found under `metadata/Undistorted_*.json`.

### JSON example

Example of `metadata/Undistorted_*.json` corresponding to the example TOML configuration file:

```json
{
    "task_params": {
        "output_file_id": "out",
        "query": {},
        "scan_id": "",
        "upstream_task": "ImagesFilesetExists"
    }
}
```

## Visualization task

### Configuration

To configure this task, we use the `[Visualization]` section in the TOML configuration file.
For example:

```toml
[Visualization]
upstream_point_cloud = "PointCloud"
upstream_mesh = "TriangleMesh"
upstream_colmap = "Colmap"
upstream_angles = "AnglesAndInternodes"
upstream_skeleton = "CurveSkeleton"
upstream_images = "ImagesFilesetExists"
max_image_size = 1500
max_point_cloud_size = 10000
thumbnail_size = 150
```

### Database location

Found under `metadata/Visualization.json`.

### JSON example

Example of `metadata/Visualization.json` corresponding to the example TOML configuration file:

```json
{
    "files": {
        "angles": "AnglesAndInternodes",
        "camera": "cameras",
        "images": [
            "image_00000_rgb",
            "image_00001_rgb",
            "image_00002_rgb",
            "image_00003_rgb",
            "image_00004_rgb",
            "image_00005_rgb",
            "image_00006_rgb",
            "image_00007_rgb",
            "image_00008_rgb",
            "image_00009_rgb",
            "image_00010_rgb",
            "image_00011_rgb",
            "image_00012_rgb",
            "image_00013_rgb",
            "image_00014_rgb",
            "image_00015_rgb",
            "image_00016_rgb",
            "image_00017_rgb",
            "image_00018_rgb",
            "image_00019_rgb",
            "image_00020_rgb",
            "image_00021_rgb",
            "image_00022_rgb",
            "image_00023_rgb",
            "image_00024_rgb",
            "image_00025_rgb",
            "image_00026_rgb",
            "image_00027_rgb",
            "image_00028_rgb",
            "image_00029_rgb",
            "image_00030_rgb",
            "image_00031_rgb",
            "image_00032_rgb",
            "image_00033_rgb",
            "image_00034_rgb",
            "image_00035_rgb",
            "image_00036_rgb",
            "image_00037_rgb",
            "image_00038_rgb",
            "image_00039_rgb",
            "image_00040_rgb",
            "image_00041_rgb",
            "image_00042_rgb",
            "image_00043_rgb",
            "image_00044_rgb",
            "image_00045_rgb",
            "image_00046_rgb",
            "image_00047_rgb",
            "image_00048_rgb",
            "image_00049_rgb",
            "image_00050_rgb",
            "image_00051_rgb",
            "image_00052_rgb",
            "image_00053_rgb",
            "image_00054_rgb",
            "image_00055_rgb",
            "image_00056_rgb",
            "image_00057_rgb",
            "image_00058_rgb",
            "image_00059_rgb"
        ],
        "measures": "measures",
        "mesh": "TriangleMesh",
        "point_cloud": "PointCloud",
        "poses": "images",
        "skeleton": "CurveSkeleton",
        "thumbnails": [
            "thumbnail_00000_rgb",
            "thumbnail_00001_rgb",
            "thumbnail_00002_rgb",
            "thumbnail_00003_rgb",
            "thumbnail_00004_rgb",
            "thumbnail_00005_rgb",
            "thumbnail_00006_rgb",
            "thumbnail_00007_rgb",
            "thumbnail_00008_rgb",
            "thumbnail_00009_rgb",
            "thumbnail_00010_rgb",
            "thumbnail_00011_rgb",
            "thumbnail_00012_rgb",
            "thumbnail_00013_rgb",
            "thumbnail_00014_rgb",
            "thumbnail_00015_rgb",
            "thumbnail_00016_rgb",
            "thumbnail_00017_rgb",
            "thumbnail_00018_rgb",
            "thumbnail_00019_rgb",
            "thumbnail_00020_rgb",
            "thumbnail_00021_rgb",
            "thumbnail_00022_rgb",
            "thumbnail_00023_rgb",
            "thumbnail_00024_rgb",
            "thumbnail_00025_rgb",
            "thumbnail_00026_rgb",
            "thumbnail_00027_rgb",
            "thumbnail_00028_rgb",
            "thumbnail_00029_rgb",
            "thumbnail_00030_rgb",
            "thumbnail_00031_rgb",
            "thumbnail_00032_rgb",
            "thumbnail_00033_rgb",
            "thumbnail_00034_rgb",
            "thumbnail_00035_rgb",
            "thumbnail_00036_rgb",
            "thumbnail_00037_rgb",
            "thumbnail_00038_rgb",
            "thumbnail_00039_rgb",
            "thumbnail_00040_rgb",
            "thumbnail_00041_rgb",
            "thumbnail_00042_rgb",
            "thumbnail_00043_rgb",
            "thumbnail_00044_rgb",
            "thumbnail_00045_rgb",
            "thumbnail_00046_rgb",
            "thumbnail_00047_rgb",
            "thumbnail_00048_rgb",
            "thumbnail_00049_rgb",
            "thumbnail_00050_rgb",
            "thumbnail_00051_rgb",
            "thumbnail_00052_rgb",
            "thumbnail_00053_rgb",
            "thumbnail_00054_rgb",
            "thumbnail_00055_rgb",
            "thumbnail_00056_rgb",
            "thumbnail_00057_rgb",
            "thumbnail_00058_rgb",
            "thumbnail_00059_rgb"
        ],
        "zip": "scan"
    },
    "task_params": {
        "max_image_size": 1500,
        "max_point_cloud_size": 10000,
        "output_file_id": "out",
        "scan_id": "",
        "thumbnail_size": 150,
        "upstream_angles": "AnglesAndInternodes",
        "upstream_colmap": "Colmap",
        "upstream_images": "Undistorted",
        "upstream_mesh": "TriangleMesh",
        "upstream_point_cloud": "PointCloud",
        "upstream_skeleton": "CurveSkeleton"
    }
}
```

## Voxels task

### Configuration

To configure this task, we use the `[Voxels]` section in the TOML configuration file.
For example:

```toml
[Voxels]
upstream_mask = "Masks"
upstream_colmap = "Colmap"
use_colmap_poses = true
voxel_size = 1.0
type = "carving"
log = false
invert = false
labels = "[]"
```

### Database location

Found under `metadata/Voxels_*.json`.

### JSON example

Example of `metadata/Voxels_*.json` corresponding to the example TOML configuration file:

```json
{
    "task_params": {
        "invert": "False",
        "labels": [
            "background"
        ],
        "log": "False",
        "output_file_id": "out",
        "scan_id": "",
        "type": "averaging",
        "upstream_colmap": "Colmap",
        "upstream_mask": "Segmentation2D",
        "use_colmap_poses": "True",
        "voxel_size": 0.01
    }
}
```

## Scan task

!!! todo
    For some reason the parameters are defined in the `metadata/metadata.json` file.
    Definition can be found [here](index.md#scanning-operation).