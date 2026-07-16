# How to Scan Virtual Plants with the _Virtual Plant Imager_

**Goal**: Create a complete *virtual plant scan* dataset (RGB images, ground‑truth masks, and metadata) using the **Virtual Plant Imager**.  

This guide walks you step‑by‑step from preparing the database to running the scan and checking the results.

---

## 1. Prepare a Working Database

1. **Create a directory** that will hold the virtual‑plant database, _e.g._ `vscans` under `/data/ROMI`:

    ```shell
    mkdir -p /data/ROMI/vscans/
    ```

2. **Copy the `vscan_data` reference example**, to get a ready‑made starter and populate the required sub‑folders:

    ```shell
    cd ~/Projects/plant-imager   # change directory to the cloned repository
    cp -r database_example /data/ROMI/vscans/  # copy the `vscan_data` reference example and `romidb` marker
    ```

    It should copy the folders listed below (any empty folder except `lpy` is fine)
    ```
    vscans/
    ├── vscan_data/
    │   ├── hdri/      # optional HDRI background files
    │   ├── lpy/       # LPY plant model files
    │   ├── obj/       # will be created by the pipeline
    │   ├── palette/   # optional color‑palette images
    │   └── scenes/    # optional background scenes
    └── romidb         # FSDB marker file
    ```

    The example already contains a minimal LPY file (`arabidopsis_notex.lpy`) and a few HDRIs.

---

## 2. Verify / Adjust the Scan Configuration

The scan is driven by a **TOML** file that describes the whole pipeline (`VirtualPlant` → `ScanPath` → `VirtualScan`).  
Use the file `vscan_lpy_blender.toml` as a template and edit the sections you need.

### 2.1 Plant generation (`[VirtualPlant]`)

| Parameter                                   | Meaning                                    | Typical change                                       |
|---------------------------------------------|--------------------------------------------|------------------------------------------------------|
| `lpy_file_id`                               | Name of the LPY model in `vscan_data/lpy/` | Replace with your own model file (without extension) |
| `BRANCHON`                                  | Enable/disable lateral branches            | `true` for branched plants                           |
| `MEAN_NB_DAYS`, `STDEV_NB_DAYS`             | Plant age distribution (days)              | Increase for older plants                            |
| `BETA`, `INTERNODE_LENGTH`, `STEM_DIAMETER` | Geometry of stems/branches                 | Tweak to change overall size                         |

### 2.2 Camera path (`[ScanPath]`)

| Parameter                   | Meaning                            | Typical change                                   |
|-----------------------------|------------------------------------|--------------------------------------------------|
| `class_name`                | Path shape (`Circle`, `Spiral`, …) | Keep `"Circle"` unless you need a custom path    |
| `center_x`, `center_y`, `z` | Path origin (mm)                   | Usually `0, 0, 32` for the default virtual scene |
| `tilt`                      | Camera tilt (°)                    | Small values (≈ 3°) give a frontal view          |
| `radius`                    | Distance from plant (mm)           | Larger radius → wider view, smaller → close‑up   |
| `n_points`                  | Number of viewpoints               | `36` gives a dense scan; lower for quick tests   |

### 2.3 Rendering (`[VirtualScan]`)

| Parameter                 | Meaning                               | Typical change                        |
|---------------------------|---------------------------------------|---------------------------------------|
| `load_scene`              | Load an external Blender scene file   | `false` for the built‑in default      |
| `use_palette`, `use_hdri` | Apply color palette / HDRI background | Keep `true` for realistic rendering   |
| `render_ground_truth`     | Generate segmentation masks           | Always `true` for evaluation          |
| `colorize`                | Randomly color the plant              | `true` unless you need a plain model  |
| `width`, `height`         | Output image resolution               | `1440 × 1080` is a good trade‑off     |
| `focal`                   | Camera focal length (mm)              | `16 mm` works for most setups         |
| `flash`                   | Simulate flash illumination           | `false` unless you want a bright fill |
| `add_leaf_displacement`   | Add leaf surface noise                | `true` for realism                    |

!!! Tip
    Save a copy of the original file before editing.
    You can always revert to the defaults.

---

## 3. Launch the _Virtual Plant Imager_ Docker Container

The _Virtual Plant Imager_ runs inside a Docker container that mounts your database.

```shell
cd ~/Projects/plant-imager/docker
./run.sh -db /data/ROMI/vscans   # maps /data/ROMI/vscans to /home/user/db inside the container
```

You should now have a shell inside the container (prompt shows something like `user@xxxx`).
Keep this terminal open.

---

## 4. Generate the Full Virtual Dataset

Run the scan, choosing a descriptive output name (_e.g._ `my_virtual_plant_001`).

```shell
(lpyEnv) romi_run_task --config plant-imager/configs/vscan_lpy_blender.toml VirtualScan db/my_virtual_plant_001
```

The pipeline will:

1. **Generate the 3‑D plant** from the LPY model (`VirtualPlant` task).
2. **Create the camera trajectory** (`ScanPath` task).
3. **Render images and masks** (`VirtualScan` task) with Blender.

The process may take several minutes depending on your hardware.

---

## 5. Inspect the Result

The new folder `my_virtual_plant_001/` contains:

```
my_virtual_plant_001/
├── images/                # RGB renders
├── metadata/
│   ├── images/            # per‑image metadata (camera pose, file name, etc.)
│   └── images.json
├── files.json
└── scan.toml              # exact configuration used for this run
```

*Quick sanity check*

```shell
ls my_virtual_plant_001/images | head
display my_virtual_plant_001/images/000001.png   # any image viewer
```

Verify that the plant is fully visible in each view and that ground‑truth masks (if you enabled them) are present.

---

## Quick‑Reference Checklist

| Step  | Action                                                                                  |
|-------|-----------------------------------------------------------------------------------------|
| **1** | Create `/data/ROMI/vscans/vscan_data/` and populate required sub‑folders                |
| **2** | Edit the TOML configuration (plant, path, rendering)                                    |
| **3** | Start the _Virtual Plant Imager_ Docker container with `./run.sh -db /data/ROMI/vscans` |
| **4** | Run the full scan with a meaningful dataset name                                        |
| **5** | Inspect `images/` and `metadata/` for completeness                                      |

Follow this guide whenever you need a reproducible, fully‑annotated virtual plant scan for algorithm development, benchmarking, or training data generation.