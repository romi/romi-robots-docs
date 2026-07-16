# How to Reconstruct a Plant with the _Geometric Pipeline_

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

2. Verify that the copy contains the expected image sub‑folders (e.g., `images/`, `metadata/`).

---

## 2. Start the execution environment

You may work either in the `plant3dvision` conda environment **or** in a **Docker** container provided by ROMI.
Choose the option that matches your workflow.

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

The reconstruction pipeline reads a TOML file (for example `/data/ROMI/configs/pipeline.toml`).  
Open it and verify that the sections below match the characteristics of your dataset.

| Section        | Typical things to check                                                        |
|----------------|--------------------------------------------------------------------------------|
| `[Colmap]`     | `matcher`, `single_camera`, `mad_factor`, `metrics` and `max_blind_angle`      |
| `[Undistort]`  | `query` – should filter for `rgb` images with a valid COLMAP pose              |
| `[Masks]`      | `parameters`, `min_threshold` and `dilation` match the lighting of your images |
| `[Voxels]`     | `voxel_size` (resolution) and `bounding_box` to limit the volume               |
| `[PointCloud]` | `algorithm` (usually `marching-cubes`) and `level_set_value`                   |

If you need to tweak a value, edit the file and save it **before** launching the task.

!!! Reference
    Full list of configurable options [here](https://github.com/romi/plant-3d-vision/blob/dev/configs/geom_pipe_full.toml).

The high‑level flow is:

1. `Colmap`: Sparse (and optionally dense) 3‑D reconstruction from raw images.
2. `Undistort`: Optional image undistortion using the chosen camera model or calibration data.
3. `Masks`: 2‑D binary mask generation from undistorted images.
4. `Voxels`: Back-projection of the masked images.
5. `PointCloud`: Generation of a point cloud from the voxels.

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

[Masks]
# Upstream task that provides input images
# Options: "Undistort", "ImagesFilesetExists"
upstream_task = "Undistort"  # Default: "Undistort"
# Query to filter files from upstream task by metadata
query = "{\"channel\":\"rgb\"}"  # Default: "{\"channel\":\"rgb\"}"  (only RGB images)
# Type of image transformation algorithm to use prior to masking
# Options: "linear" (linear combination of the channels (RGB, HSV, YCbCr), "excess_green" (excess green index)
method = "linear"  # Default: "linear"
# Colorspace to use for the filtering
# Options: "RGB", "HSV", "YCbCr"
colorspace = "RGB"  # Default: "RGB"
# Linear coefficients to apply to each channel of the original image in the selected colorspace
# Used only when type="linear"
parameters = "[0.2, 1, 0.1]"  # Default: [0, 1, 0] (using only the green channel in RGB)
# Binarization threshold applied after transforming the image
min_threshold = 0.2 # Default: 0.0
max_threshold = 1.0 # Default: 0.4
# Dilation factor for the binary mask images (morphological dilation)
dilation = 1 # Default: 0 (no dilation)

[Voxels]
# Task that provides the masked images as input
upstream_task = "Masks"  # Default: "Masks"
# Metadata entry to use to access camera poses
camera_metadata = "colmap_camera"  # Default: "colmap_camera"
# Size of the voxel to reconstruct, defines the resolution of the 3D array
voxel_size = 0.6  # Default: 1.0
# Type of backprojection algorithm to use
# Options: "carving", "averaging"
method = "averaging"  # Default: "averaging"
[Voxels.bounding_box]
# 3D bounding box defining the region of interest for reconstruction
# Default: None (uses the entire volume)
x = [270, 465, ]
y = [270, 465, ]
z = [-320, 50, ]

[PointCloud]
# Task that provides the voxel array as input
upstream_task = "Voxels"  # Default: "Voxels"
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

[Clean]
no_confirm = true
```

---

## 4. Run the reconstruction

Replace `my_awesome_plant_007` with the identifier you want for the output plant.

=== "Conda"

    ```bash
    romi_run_task PointCloud \
        /data/ROMI/2026_scans/analysis/my_awesome_plant_007 \
        --config /data/ROMI/configs/pipeline.toml
    ```

=== "Docker"

    ```bash
    romi_run_task PointCloud \
        /myapp/db/my_awesome_plant_007 \
        --config /myapp/configs/pipeline.toml
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
