# How to Reconstruct Plants with the _Geometric Pipeline_

In this step, we reconstruct the 3D structure of the plant and quantify its phyllotaxy.

## Getting Started

1. Open a terminal by pressing <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>t</kbd>.
2. Activate the `plant3dvision` conda environment (A) **OR** start a Docker container (B):

    1. Conda environment:
       ```bash
       conda activate plant3dvision
       ```

    2. Docker container:
       ```bash
       bash ${HOME}/Projects/plant-3d-vision/docker/run.sh \
           -db /data/ROMI/test_v2 \
           -v /data/ROMI/configs:/myapp/configs \
           -v ~/scripts:/myapp/scripts \
           -t latest \
           -c /bin/bash
       ```

3. Copy your acquisition data, for example `/data/ROMI/Romi_****/acquisitions/my_awesome_plant_*`, to a different directory for analysis, such as `/data/ROMI/Romi_****/analysis`:
   ```bash
   cp /data/ROMI/Romi_Fabfab/acquisitions/my_awesome_plant_* /data/ROMI/Romi_Fabfab/analysis/.
   ```

## Reconstruction
To proceed with the reconstruction of a new plant, for example, named `my_awesome_plant_007`, follow these steps:

1. Verify the parameters in the TOML configuration file, for example `/data/ROMI/configs/pipeline.toml`:
   ```toml
   [Colmap]
   upstream_task = "ImagesFilesetExists"
   matcher = "exhaustive"
   align_pcd = true
   use_gpu = true  # faster processing 
   single_camera = true  # images all comes from a single camera
   distance_threshold = 5  # in mm; maximum allowed Euclidean distance from CNC pose

   [Undistort]
   upstream_task = "ImagesFilesetExists"
   query = "{\"channel\":\"rgb\", \"pose_estimation\":\"correct\"}"  # RGB images with a valid COLMAP pose

   [Masks]
   upstream_task = "Undistort"
   type = "linear"
   parameters = "[0.2, 1, 0.1]"
   dilation = 3 #Modified
   binarize = true
   threshold = 0.2

   [Voxels]
   upstream_mask = "Masks"
   upstream_colmap = "Colmap"
   voxel_size = 0.6
   type = "averaging"
   [Voxels.bounding_box]
   x = [ 270, 465,]
   y = [ 270, 465,]
   z = [ -320, 50,]

   [PointCloud]
   upstream_task = "Voxels"
   level_set_value = 0.0

   [TriangleMesh]
   upstream_task = "PointCloud"
   library = "open3d"
   filtering = "largest connected triangles"
   depth = 9

   [Clean]
   no_confirm = true
   ```
2. Start the reconstruction with:
   ```bash
   romi_run_task TriangleMesh /data/ROMI/Romi_Fabfab/analysis/my_awesome_plant_007 --config /data/ROMI/configs/pipeline.toml
   ```
