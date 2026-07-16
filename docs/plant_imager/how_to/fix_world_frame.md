# How to Fix World Frame for Older Scan Datasets

**Goal**: Correct the world‑frame metadata of image poses in a PlantDB/FSDB scan dataset so that:

* every image has a negative *z* coordinate (preserving magnitude), and  
* all pan angles start at 0° (the first image’s pan becomes the reference).

The guide assumes you have a local copy of the dataset and the `fix_world_frame.py` script installed.

## Step‑by‑step instructions

1. **Open a terminal** and navigate to the directory containing `fix_world_frame.py`.

    ```bash
    cd ~/Projects/plant-3d-vision/scripts/
    ```

2. Run the script on the **whole dataset** (default behavior) or **subset of scans**.

    === "Whole dataset"

        ```bash
        python fix_world_frame.py /data/ROMI/ --no-auth
        ```

        `--no-auth` tells the script to connect to the DB as the built‑in `admin` user (useful for local or test datasets).

    === "Subset of scans"

        To apply the fix only on a subset of scans, _e.g_ only March 2023 scans:

        ```bash
        python fix_world_frame.py /data/ROMI/ --scan "2023-03-*" --no-auth
        ```

        The `--scan` option accepts glob patterns; multiple patterns can be supplied and are OR‑combined.

3. **Review the script output.**
    The CLI prints each processed scan and, after completion, lists scans whose `pipeline.toml` backup was found.
    For those scans, if you intend to reprocess them using the `pipeline.toml` backup to reuse the specific combination of parameters, you must manually adjust the `Voxels.bounding_box` Z limits in the backed‑up `pipeline.toml` file.

    ```
    Processing scan: scan001
    Processing scan: scan002
    Processing scan: scan003
    ...
    All done!
    If you intend to reuse them, remember to edit the `Voxels.bounding_box` z‑axis values in the backed‑up `pipeline.toml` file for these scans: 0, scan003
    ```

4. **Verify the changes** (optional).  
    Open a sample image file and inspect its `approximate_pose` metadata; you should see a negative *z* and a pan value starting from 0°.

## Tips & common pitfalls

| Situation                      | Guidance                                                                                                                                                             |
|--------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **No scans match the pattern** | Ensure the pattern matches the scan IDs exactly (case‑sensitive). Use `*` as a wildcard.                                                                             |
| **`pipeline.toml` not found**  | The script only warns about scans that already have a backup. If the file is missing, you may need to create one manually before re‑running downstream pipelines.    |
| **Authentication errors**      | Verify that the username/password are correct, or use `--no‑auth` for local databases.                                                                               |
| **Unexpected pan values**      | The script normalises pan with `% 360`. If you see values outside 0‑359°, the scan may contain corrupted metadata; re‑run the script after fixing the original pose. |

## When to stop

You have successfully normalized the world frame when:

* All scans report “All done!” without error messages.  
* The `approximate_pose` of every image shows a negative *z* and pan angles that start at 0°.  
* The `pipeline.toml` backup files (if any) have been inspected and their bounding‑box Z limits updated.

You can now feed the dataset into downstream analysis pipelines that assume a standard world‑axis orientation.

---

For a full reference of all CLI options, see the script’s `--help` output.