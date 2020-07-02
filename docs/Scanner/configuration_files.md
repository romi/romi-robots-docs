Configuring executed tasks by Luigi
===

## Introduction

Each tasks has a default configuration but to create a working pipeline, you need to set some parameters in a TOML configuration file.

There is two types of parameters:

1. those associated with luigi: upstream tasks, requirements & outputs
2. those tuning the used algorithms: variables & parameters

For examples look at the configurations provided in `romiscan/configs`.


## Database & I/O tasks
These tasks refers to the inputs and outputs of each algorithmic tasks.
They are often related to tasks defined in the `romidata` library.

### Clean
Clean a scan dataset.

No luigi parameters (no upstream task).

List of task variables:

- `no_confirm`: boolean indicating whether a confirmation is required to clean the dataset, `False` by default, *i.e.* confirmation required.

Example:
```toml
[Clean]
no_confirm = true
```
Use this to clean without confirmation.


### FilesetExists
Check that the given `Fileset` id exists (in dataset).

No luigi parameters (no upstream task).

List of task variables:

- `fileset_id`: the id (`str`) to check for existence.


### ImagesFilesetExists(FilesetExists)
Check that the image file set exists.

No luigi parameters (no upstream task).

List of task variables:

- `fileset_id`: the id (`str`) to check for existence `'images'` by default.


### ModelFileset(FilesetExists)
Check that the trained ML models file set exists.

No luigi parameters (no upstream task).

List of task variables:

- `fileset_id`: the id (`str`) to check for existence `'models'` by default.

Example:
```toml
[ModelFileset]
scan_id = "models"
```
Defines the location of he trained ML models in a dataset named `'models'`.


## Algorithmic tasks

### Colmap task
Defined in `romiscan.task.colmap`, it is used to match scan images and estimate camera poses. 
It can also be used to compute a sparse and/or dense point cloud. 

List of luigi task parameters:

- `upstream_task`: task upstream of the `Colmap` task, default is `ImagesFilesetExists`


List of task variables:

- `matcher`: images mathing method, can be either "exhaustive" (default) or "sequential";
- `compute_dense`: boolean indicating whether to run the dense colmap to obtain a dense point cloud, `False` by default;
- `cli_args`: dictionary of parameters for colmap command line prompts;
- `align_pcd`: boolean indicating whether to align point cloud on calibrated or metadata poses, `True` by default;
- `calibration_scan_id` : ID of the calibration scan, requires the .

Example:
```toml
[Colmap]
matcher = "exhaustive"
compute_dense = false
calibration_scan_id = "calib_scan_shortpath"

[Colmap.cli_args.feature_extractor]
"--ImageReader.single_camera" = "1"
"--SiftExtraction.use_gpu" = "1"

[Colmap.cli_args.exhaustive_matcher]
"--SiftMatching.use_gpu" = "1"

[Colmap.cli_args.model_aligner]
"--robust_alignment_max_error" = "10"
```

!!! todo
    Add a `compute_sparse`?


### Undistorted task
Defined in `romiscan.task.proc2d`, it is used to undistorts images using computed intrinsic camera parameters.


### Masks task
Defined in `romiscan.task.proc2d`, it is used to create binary mask of the plant location within each image. 

List of luigi task parameters:

- `upstream_task`: task upstream of the `Masks` task, default is `Undistorted` but can be `None`.

List of task variables:

- `type`: method to use to compute masks, choices are: `'linear'`, `'excess_green'`, `'vesselness'`, `'invert'`;
- `parameters`: list of scalar parameters, depends on type hence **no default values**;
- `dilation`: integer defining the dilation factor to apply when using a binary mask, **no default values**;
- `binarize`: boolean indicating whether to binarize the mask, default is `True`;
- `threshold`: float used as threshold for binarization step, default is `0.0`;


### Voxels task
Defined in `romiscan.task.cl`, it is used to reconstruct the 3D structure of the plant from binary or segmented masks . 


List of luigi task parameters:

- `upstream_task`: task upstream of the `Colmap` task, default is `ImagesFilesetExists`


List of task variables:

- `type`: ;

Example:
```toml
[Voxels]
upstream_mask = "Segmentation2D"
labels = "[\"background\"]"
voxel_size = 0.3
type = "averaging"
invert = false
use_colmap_poses = true
log = false
```

!!! note
    Choose `'Segmentation2D'` as `` for ML pipeline or `'Masks'` for geometrical pipeline.

### PointCloud task

Example:
```toml
[PointCloud]
level_set_value = 1
background_prior= 0.5
log = false
```

### SegmentedPointCloud task

Example:
```toml
[SegmentedPointCloud]
upstream_segmentation = "Segmentation2D"
upstream_task = "PointCloud"
use_colmap_poses = true
```

### Segmentation2D task

Example:
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

### Visualization task

Example:
```toml
[Visualization]
max_image_size = 1500
max_point_cloud_size = 10000
thumbnail_size = 150
pcd_source = "vox2pcd"
mesh_source = "delaunay"
```

### ClusteredMesh task

Example:
```toml
[ClusteredMesh]
upstream_task = "SegmentedPointCloud"
```


### AnglesAndInternodes task

Example:
```toml
[AnglesAndInternodes]
upstream_task = "ClusteredMesh"
```


## Evaluation tasks

### VoxelGroundTruth

Example:
```toml

```


### PointCloudGroundTruth

Example:
```toml
[PointCloudGroundTruth]
pcd_size = 10000
```


### ClusteredMeshGroundTruth

Example:
```toml

```


### PointCloudEvaluation task

Example:
```toml
[PointCloudEvaluation]
max_distance = 0.2
```


### PointCloudSegmentationEvaluation task



### Segmentation2DEvaluation task

