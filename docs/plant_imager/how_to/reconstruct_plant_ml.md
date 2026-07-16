# How to Reconstruct Plants with the _ML Pipeline_


**Goal:** Turn a set of RGB images into a 3‑D plant model ready for downstream analysis.

Follow this sequence each time you need to reconstruct a new plant.
The guide assumes basic familiarity with a terminal and with the ROMI folder layout.

---

## 1. Prepare your data

1. **Copy the raw acquisition folder** to a separate analysis location so the original files stay untouched.

    ```shell
    cp /data/ROMI/2026_scans/acquisitions/experiment_X \
          /data/ROMI/2026_scans/analysis/experiment_X
    ```

2. Verify that the copy contains the expected image sub‑folders (e.g., `rgb/`, `metadata/`).

---

## 2. Start the execution environment

You may work either in the conda environment **or** in a Docker container. Choose the option that matches your workflow.

=== "Conda"

    Activate the `plant3dvision` conda environment:
    ```bash
    conda activate plant3dvision
    ```

=== "Docker"

    Set the `ROMI_DB` & `ROMI_CFG` environment variable, defining the location of the database and configuration folders, then start the container:
    ```bash
    export ROMI_DB=/data/ROMI/2026_scans/analysis/experiment_X
    export ROMI_CFG=/data/ROMI/configs
    bash ${HOME}/Projects/plant-3d-vision/docker/run.sh \
        -v ${ROMI_CFG}:/myapp/configs \
        -t latest \
        -c /bin/bash
    ```

!!! Tip
    If you are unsure which method to use, start with Conda; it requires no additional setup.

---

## 3. Confirm the pipeline configuration

The reconstruction pipeline reads a TOML file, for example `/data/ROMI/configs/pipeline.toml`.

Open it and make sure the sections that affect your data are set correctly:

| Section        | Typical things to check                                                        |
|----------------|--------------------------------------------------------------------------------|
| `[Colmap]`     | `matcher`, `single_camera`, `mad_factor`, `metrics` and `max_blind_angle`      |
| `[Undistort]`  | `query` – should filter for `rgb` images with a valid COLMAP pose              |
| `[Masks]`      | `parameters`, `min_threshold` and `dilation` match the lighting of your images |
| `[Voxels]`     | `voxel_size` (resolution) and `bounding_box` to limit the volume               |
| `[PointCloud]` | `algorithm` (usually `marching-cubes`) and `level_set_value`                   |

If you need to tweak a value, edit the file and save it **before** launching the task.

!!! Reference
    Full list of configurable options [here](https://github.com/romi/plant-3d-vision/blob/dev/configs/ml_pipe_full.toml).

The high‑level flow is:

1. `Colmap`: Sparse (and optionally dense) 3‑D reconstruction from raw images.
2. `Undistort`: Optional image undistortion using the chosen camera model or calibration data.
3. `ModelFilesetExists`: Verify the availability of the trained CNN model required by `Segmentation2D`.
4. `Segmentation2D`: 2‑D semantic segmentation of undistorted images.
5. `Voxels`: Back-projection of the segmented images.
6. `PointCloud`: Generation of a (multi‑class) point cloud from the voxels.
7. `SegmentedPointCloud`: Point‑cloud post‑processing, optionally using COLMAP poses.

```toml
[Colmap]
# Upstream task that provides the input files
upstream_task = "ImagesFilesetExists"  # Default: "ImagesFilesetExists"
# Colmap "executable" to use
colmap_exe = "roboticsmicrofarms/colmap:3.8"
# Type of matcher to use with COLMAP
# Options: "exhaustive" (matches every image against every other) or "sequential" (matches successive images)
matcher = "exhaustive"  # Default: "exhaustive"
# Use GPU for feature extraction and matching when available
use_gpu = true  # Default: true
# Whether images were taken with a single camera (shared intrinsics)
single_camera = true  # Default: true
# Align and scale point clouds using CNC coordinates
align_pcd = true  # Default: true
# Whether to perform the verification of the estimated camera extrinsic
qc_check = true  # Default: true
# Median absolute deviation factor to detect outlier camera pose
mad_factor = 3.0  # Default: 3.
# List of metrics to use to detect the outliers using the MAD method.
metrics = '["xy", "z", "pan", "roll"]'
# Maximum distance to CNC pose to validate COLMAP pose estimation
distance_threshold = 3.0  # Default: 3.0mm
# Maximum distance to fixed CNC pose to validate COLMAP pose estimation
fixed_distance_threshold = 1.0  # Default: 1.0mm
# Maximum angular distance to CNC pose to validate COLMAP pose estimation
angle_threshold = 5.0  # Default: 5.0°
# Maximum angular distance to fixed CNC pose to validate COLMAP pose estimation
fixed_angle_threshold = 3.5  # Default: 3.5°
# Maximum blind angle tolerated for camera pose quality control
max_blind_angle = 20.0  # Default: 20.0 (degrees)
# Number of retries if the task fails
retry_count = 10  # Default: 10

[Undistort]
# Upstream task that provides the input files
upstream_task = "ImagesFilesetExists"  # Default: "ImagesFilesetExists"
# Query to filter files from upstream task by metadata
query = "{\"channel\":\"rgb\", \"pose_estimation\":\"correct\"}"  # RGB images with a valid COLMAP pose

[ModelFilesetExists]
scan_id = "models"

[Segmentation2D]
# Upstream task that provides the input images
upstream_task = "Undistort"  # Default: "Undistort"
# Upstream model training task
model_fileset = "ModelFilesetExists"  # Default: "ModelFilesetExists"
# Name of the trained model to use from the 'model' Fileset
model_id = "Resnet_896_896_epoch50"  # no default value
# Query to filter files from upstream task by metadata
query = "{\"channel\":\"rgb\"}"  # Default: "{}" (empty dictionary, no filtering)
# List of labels identifiers produced by the neural network to use to generate (binary) mask files
labels = "[]"  # Default: [] (use all labels identifiers from model)
# List of labels identifiers that requires inversion of their predicted mask
inverted_labels = "[\"background\"]"  # Default: ["background"]
# Boolean flag to binarize predictions
binarize = true  # Default: true
# Threshold to binarize predictions, required if binarize=True
threshold = 0.01  # Default: 0.01
# Dilation factor to apply to a binary mask
dilation = 1  # Default: 1

[Voxels]
# Task that provides the masked images as input
upstream_task = "Segmentation2D"  # Default: "Masks"
# Metadata entry to use to access camera poses
camera_metadata = "colmap_camera"  # Default: "colmap_camera"
# Size of the voxel to reconstruct, defines the resolution of the 3D array
voxel_size = 0.6  # Default: 1.0
# Type of backprojection algorithm to use
# Options: "carving", "averaging"
method = "averaging"  # Default: "averaging"
# Whether to invert the mask values
invert = true  # Default: false
# List of labels to use for multi-class voxel reconstruction (requires a labeled mask dataset)
labels = "[\"background\"]"  # Default: [] (empty list)
[Voxels.bounding_box]
# 3D bounding box defining the region of interest for reconstruction
# Default: None (uses the entire volume)
x = [270, 465, ]
y = [270, 465, ]
z = [-320, 50, ]

[PointCloud]
# Task that provides the voxel array as input
upstream_task = "Voxels"  # Default: "Voxels"
# List of labels to use for multi-class point cloud generation
labels = "[\"background\"]"  # Default: [] (empty list)
# Algorithm to use to compute the pointcloud
algorithm = "marching-cubes"  # Default: "marching-cubes"
# Distance of the level set on which the points are sampled
level_set_value = 1.0  # Default: 1.0
# Threshold for the number of missing images allowed in the reconstructed volume
missing_images_threshold = 2  # Default: 2
# Standard deviation for Gaussian kernel (only for marching-cubes)
sigma = 0.8
# Level set value for the marching cubes algorithm
mc_level = 0.5

[SegmentedPointCloud]
# Upstream task that provides a point cloud
upstream_task = "PointCloud"  # Default: "PointCloud"
# Upstream task that provides 2D semantic segmentation of the 'images'
upstream_segmentation = "Segmentation2D"  # Default: "Segmentation2D"
# Whether to use COLMAP poses for back-projection
use_colmap_poses = true  # Default: true
```

---

## 4. Run the reconstruction

Replace `my_awesome_plant_007` with the identifier you want for the output plant.

=== "Conda"

    ```bash
    romi_run_task PointCloud /data/ROMI/2026_scans/analysis/my_awesome_plant_007 --config /data/ROMI/configs/pipeline.toml
    ```

=== "Docker"

    ```bash
    romi_run_task PointCloud /myapp/db/my_awesome_plant_007 --config /myapp/configs/pipeline.toml
    ```

- **If the command finishes without error**, a point‑cloud file will appear in the analysis folder (`pointcloud.ply` by default).
- **If you see a failure message**, re‑run the command with `--log-level DEBUG` to get more detail, then adjust the relevant configuration entry.

---

## 5. Verify the result

1. Open the generated point cloud in your favorite 3‑D viewer (e.g., MeshLab, CloudCompare, [P3DX](explore_plant_quantif.md)).
2. Check that the whole plant outline looks complete:
    - no gaps in the main stem
    - no missing parts (cropped)
    - no extra stuff above or below the plant (metal stem holder is ok)
3. If the model is not satisfactory, consider adjusting:
    1. the `bounding_box` in `[Voxels]`, increase the box height (z-axis) if the whole plant is not reconstructed
    2. the `bounding_box` in `[Voxels]`, decrease the box height (z-axis) if extra stuff is present (above or below)
    3. the `parameters` and `min_threshold` in `[Mask]`, if there are gaps in the plant, maybe the binary masks are not optimals.
       See [How to Choose Linear Coefficients and Threshold Parameters for Plant‑Mask Generation](select_linear_params.md), to fine-tune these values.
    3. set the `mad_factor` to `2.5` in `[Colmap]` for a strictier _quality check_ of the estimated pose, if there are gaps in the main stem. 
       Note that this only works if a low number of images is already detected as incorrectly estimated (less than 10%).