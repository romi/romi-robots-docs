# How to Scan Plants with _Plant Imager 2.1_

!!! info
    The _Plant Imager 2.1_ refers to the version fixed issues with the world reference frame.

---

## Get Ready

1. **Open a terminal** - press <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>t</kbd>.
2. **Activate the environment**
   ```bash
   conda activate plant_imager
   ```
3. **Power the _Sony RX0_ camera** - press the small black button.
4. **Connect the controller** to the camera Wi-Fi (this should happen automatically).
5. **Turn on the _Plant Imager_** unit.

---

## Center the Plant

You must know where the _center_ defined in your configuration is in the real world, then place the plant there.

1. Open the scan configuration you intend to use (_e.g._ `/data/ROMI/configs/scan.toml`).

2. Check the key parameters under `[ScanPath]` and `[ScanPath.kwargs]`:
   ```toml
   [ScanPath]
   class_name = "Circle"   # circular path
   
   [ScanPath.kwargs]
   center_x = 375   # X coordinate of the center
   center_y = 375   # Y coordinate of the center
   z        = 100   # Camera height (higher = lower camera)
   ```

!!! important
    Keep `center_x` and `center_y` unchanged.
    You may adjust `z` as long as it stays `<120`.

3. Move the arm to the center
   ```bash
   romi_run_task ScannerToCenter /tmp --config /data/ROMI/configs/scan.toml
   ```

4. When the arm stops, place your plant directly under it.

---

## Run a Quick Test Scan

A short scan confirms that the plant is correctly positioned and fully visible.

1. **Set `n_points` to 4** in the same `scan.toml` (the other values stay the same):
   ```toml
   [ScanPath.kwargs]
   center_x = 375 # x-coordinate of the center
   center_y = 375 # y-coordinate of the center
   z = 100        # height of the camera, higher values lower the camera
   radius = 350   # distance to the center / plant
   n_points = 4  # number of images to take around the plant
   ```

!!! note
   Do not modify `radius` unless you have a specific reason.

2. **Navigate to your acquisition folder** and launch the test scan:

   ```bash
   cd /path/to/my_database   # probably /data/ROMI/Romi_****/acquisitions
   romi_run_task Scan test_4_views --config /data/ROMI/configs/scan.toml --no-auth
   ```

3. **Inspect the images**
   Open the `test_4_views/images` folder in a file browser and verify that each picture captures the plant clearly.

4. **If the view is unsatisfactory**, reposition the plant and repeat steps 2‑3 until you are happy with the results.

!!! information
   The system has been tested up to center_x = 384, center_y = 384, and radius = 382

---

## Scan a Plant Dataset

When you are ready to acquire a full dataset:

1. **Confirm the final scan parameters** (`radius` and `n_points`) in `scan.toml`. Example for a dense acquisition:

   ```toml
   [ScanPath.kwargs]
   center_x = 375
   center_y = 375
   z = 100
   radius = 350
   n_points = 40   # more images for higher detail
   ```

2. **Add the plant’s biological metadata** under `[Scan.metadata.object]` (replace the example values with your own):

   ```toml
   [Scan.metadata.object]
   species = "Arabidopsis thaliana"
   ecotype = "Col0"
   seed_stock = "186AV L5"
   plant_id = "AL4_col0_158"
   growth_environment = "C2_Lyon"
   growth_conditions = "Long day"
   treatment = "none"
   DAG = 48
   sample = "whole plant"
   experiment_id = "AL4"
   ```

3. **Place the plant in the imager**.

4. **Run the acquisition**, naming the dataset (e.g. `my_awesome_plant_007`):

   ```shell
   cd /path/to/my_database   # e.g. /data/ROMI/Romi_****/acquisitions
   romi_run_task Scan my_awesome_plant_007 --config /data/ROMI/configs/scan.toml --no-auth
   ```

The task will capture the specified number of images around the plant.

---

## Shut Down Safely

1. **Stop the camera** to prevent battery drain.
2. **Power off the Plant Imager** unit.

---

### Quick‑Reference Checklist

| Step  | Action                                                                              |
|-------|-------------------------------------------------------------------------------------|
| **1** | Open terminal, activate `plant_imager`, power camera, connect Wi‑Fi, turn on imager |
| **2** | Verify `center_x`, `center_y`, `z`; run `ScannerToCenter`; place plant              |
| **3** | Set `n_points = 4`; run `test_4_views`; validate images                             |
| **4** | Adjust `radius`/`n_points`; fill metadata; run final `Scan` task                    |
| **5** | Stop camera, power down imager                                                      |

Follow this guide whenever you need a reliable, repeatable plant scan with Plant Imager 2.1.
