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
```

!!! todo
    Explains the meaning of the weird tag associated to the task name!


## AnglesAndInternodes task

### Configuration
To configure this task, we use the `[AnglesAndInternodes]` section in the TOML configuration file.
For example:
```toml
[AnglesAndInternodes]
upstream_task = "ClusteredMesh"
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
For example:
```toml
[Masks]
upstream_task = "ImagesFilesetExists"
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
level_set_value = 1
background_prior= 0.5
log = false
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


## Voxels task

### Configuration
To configure this task, we use the `[Voxels]` section in the TOML configuration file.
For example:
```toml
[Voxels]
upstream_mask = "Segmentation2D"
labels = "[\"background\"]"
voxel_size = 0.01
type = "averaging"
invert = false
use_colmap_poses = true
log = false
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

!!!todo
    For some reason the parameters are defined in the `metadata/metadata.json` file. Definition can be found [here](index.md#scanning-operation).