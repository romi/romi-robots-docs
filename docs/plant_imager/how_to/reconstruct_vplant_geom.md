# How to Reconstruct Virtual Plants with the _Geometric Pipeline_

**Goal**: reconstruct a _Virtual Plant_ scan dataset into a 3‑D plant model ready for downstream analysis.

---

## 1. Prepare your data

1. **Copy the raw acquisition folder** to a separate analysis location so the original files stay untouched.

    ```shell
    cp /data/ROMI/vscans/acquisitions/experiment_X \
          /data/ROMI/vscans/analysis/experiment_X
    ```

2. Verify that the copy contains the expected image sub‑folders (e.g., `images/`, `metadata/`).

    The pipeline expects a folder that follows the FSDB database layout, _e.g._:
    ```
    /data/ROMI/vscans/analysis/experiment_01/
    ├── images/                # RGB renders produced by the Virtual Plant Imager
    ├── metadata/
    │   └── images.json        # per‑image camera pose & acquisition info
    ├── VirtualPlant.obj       # ground‑truth OBJ (used for evaluation)
    └── scan.toml              # configuration used to generate the virtual scan
    ```

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
    export ROMI_DB=/data/ROMI/vscans/analysis/experiment_X
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

The reconstruction pipeline reads a TOML file (for example `/data/ROMI/configs/pipeline_vplant.toml`).  
Open it and verify that the sections below match the characteristics of your dataset.

| Section                   | What to check (virtual‑plant specific)                                                                       |
|---------------------------|--------------------------------------------------------------------------------------------------------------|
| `[Voxels]`                | `voxel_size` (keep ≈ 0.06 mm for synthetic data) and `invert = true` (because masks are background‑inverted) |
| `[PointCloud]`            | `missing_images_threshold = 0` (all images are expected)                          |

If you need to tweak a value, edit the file and save it **before** launching the task.

!!! Reference
    Full list of configurable options [here](https://github.com/romi/plant-3d-vision/blob/dev/configs/geom_pipe_virtual.toml).

The high‑level flow is:

1. `Voxels`: Back‑projection of masked images to a voxel grid.
2. `PointCloud`: Extract a point cloud from the voxel grid.

!!! Notes
    No need to use `Colmap` as the camera extrinsics (poses) from the virtual scanner are exact.
    No need to use `Undistort` as the camera intrisics are also exact.
    No need to use `Masks` as the Virtual Plant Imager produces the 'background' masks.

```toml
[Voxels]
# Task that provides the masked images as input
upstream_task = "ImagesFilesetExists"
# Query to filter files from upstream task by metadata
upstream_colmap = "DummyTask"
query = "{\"channel\":\"background\"}"  # use the (inverted) background masks
# Metadata entry to use to access camera poses
camera_metadata = "camera"
# Size of the voxel to reconstruct, defines the resolution of the 3‑D array
voxel_size = 0.06  # ~9x smaller than real plants
# Type of back‑projection algorithm to use
# Options: "carving", "averaging"
method = "carving"
# Whether to invert the mask values
invert = true

[PointCloud]
# Task that provides the voxel array as input
upstream_task = "Voxels"
# Value of the level set on which points are sampled
level_set_value = 0.0
# Threshold for the number of missing images allowed in the reconstructed volume
missing_images_threshold = 0
```

---

## 4. Run the reconstruction pipeline

Replace `vplant_007` with the identifier you want for the output virtual plant.

=== "Conda"

    ```bash
    # Replace <plant_id> with a short identifier for the output dataset
    romi_run_task PointCloud \
        /data/ROMI/vscans/analysis/vplant_007 \
        --config /data/ROMI/vscans/configs/pipeline_vplant.toml
    ```

=== "Docker"

    ```bash
    romi_run_task PointCloud \
        /myapp/db/vplant_007 \
        --config /myapp/configs/pipeline_vplant.toml
    ```

- **If the command finishes without error**, a point‑cloud file will appear in the analysis folder (`pointcloud.ply` by default).
- **If you see a failure message**, re‑run the command with `--log-level DEBUG` to get more detail, then adjust the relevant configuration entry.

---

## 5. Verify the reconstruction

1. **Visual inspection**: Open the generated point cloud (`pointcloud.ply`) in a 3‑D viewer (e.g., MeshLab, CloudCompare, or the built‑in ROMI explorer).
2. **Check completeness**: The plant outline should be continuous; there should be **no gaps** in the main stem and **no stray points** far outside the expected bounding box.
3. **Optional sanity checks**: Compare the reconstructed point cloud against the ground‑truth OBJ (`VirtualPlant.obj`) using the provided evaluation tasks (see next step).

If you notice problems, consider these quick fixes:

| Symptom                                  | Suggested tweak                                                                                                 |
|------------------------------------------|-----------------------------------------------------------------------------------------------------------------|
| Missing parts of the stem                | Increase `voxel_size` (finer resolution) or verify that all background masks are correctly inverted.            |
| Extra stray points above/below the plant | Adjust the `z` limits in the `[Voxels]` `bounding_box` (if defined) or tighten `filtering` in `[TriangleMesh]`. |
| Unreliable fruit measurements            | Verify `organ_type` and `min_fruit_size` in `[AnglesAndInternodes]`.                                            |

---

## 6. (Optional) Quantitative evaluation against ground truth

You can define evaluation tasks in the TOML configuration file:

```toml
[PointCloudGroundTruth]
# The dataset must have an OBJ file in VirtualPlant
upstream_task = "VirtualPlantObj"
# Number of points to sample from the ground‑truth OBJ
pcd_size = 100000  # default 100000

[PointCloudEvaluation]
# Task that provides the reconstructed point cloud
upstream_task = "PointCloud"
# Ground‑truth point cloud to compare against
ground_truth = "PointCloudGroundTruth"
# Maximum allowed distance (in mm) for a point to be considered correct
max_distance = 2.0  # default to 2.0
```

Run them to get numeric quality metrics.

=== "Conda"

    ```bash
    romi_run_task PointCloudEvaluation \
        /data/ROMI/vscans/analysis/vplant_007 \
        --config /data/ROMI/vscans/configs/pipeline_vplant.toml
    ```

=== "Docker"

    ```bash
    romi_run_task PointCloudEvaluation \
        /myapp/db/vscans/analysis/vplant_007 \
        --config /myapp/configs/pipeline_vplant.toml
    ```

The task reports the **average distance** (in mm) between reconstructed and ground‑truth points and the **percentage of points within the `max_distance` threshold** (default 2 mm).
