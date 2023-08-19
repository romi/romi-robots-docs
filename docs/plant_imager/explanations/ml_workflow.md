# The machine-learning based workflow

The second workflow we introduce is the one we called _machine-learning based workflow_ as we make use of a trained CNN to **predict organ types and locations** on our original RGB images.
This information is then projected on the point cloud, so we can compute the fruit orientation in space.
From there we can fulfill our goal: to estimate the fruits' successive angles and internodes lengths.

## Reconstruction part

### Aim
The aim of the reconstruction part is to reconstruct a 3D model of the plant, here a point cloud, from a set of RGB images.

### General idea
As for the _geometry based workflow_, we sought at combining _structure from motion_ with _space carving_ to obtain a **quick and reliable** 3D reconstruction of the plant.

However, we added an extra layer of complexity with the prediction of organs types and locations instead of the simple & fast _linear filter_.
This in turn improve the automation level of the reconstruction procedure as the plant is automatically identified in the scene.
There is thus no need for manual definition of the scene bounding-box.

### Overview

<figure>
  <img src="/assets/images/ml_reconstruct_pipeline.svg" width="800" />
  <figcaption>
    Reconstruction part of the machine-learning based workflow as defined in <samp>ml_pipe_real.toml</samp> configuration & default parameters.
  </figcaption>
</figure>

### Details
1. We start with the `Colmap` task to estimate both intrinsic and extrinsic parameters using a _structure from motion_ algorithm.
2. The camera intrinsics are used by the `Undistorted` task with a `SIMPLE_RADIAL` model to fix the original RGB images.
3. Then the `Segmentation2D` task performs semantic labelling of the plant organs in each image and create a binary mask for each image and organ type.
4. This is later used by the `Voxels` task, in combination with the camera extrinsics (also called camera poses), to perform the _space carving_ of a 3D volume. This reconstructs the volume occupied by the plant in the selected portion of the scene.
5. Finally, this is turned into a point cloud describing the envelope of the reconstructed plant structure by the `PointCloud` task.


## Quantification part

### Aim
The aim of the quantification part is estimate the fruits' successive angles and internodes lengths, from the 3D point cloud.

### General idea
We sought at projecting the CNN predictions about organ types on the 3D point cloud to know the exact position of each fruit.
From there we could **estimate the fruit directions**, thanks to oriented bounding-box for fruits directions and the mean skeleton for the branching point to the main stem.  

### Overview

<figure>
  <img src="/assets/images/ml_quantif_pipeline.svg" width="800" />
  <figcaption>
    Quantification part of the machine-learning based workflow as defined in <samp>ml_pipe_real.toml</samp> configuration & default parameters.
  </figcaption>
</figure>

### Details
1. We start by projecting the CNN predictions about organ types and locations to the 3D point cloud with the `SegmentedPointcloud` task.
2. From there individualize each organ thanks to the `OrganSegmentation` task.
3. Finally, the `AnglesAndInternodes` task will compute the _fruits direction and branching points_, allowing us to estimate the successive angles and internode lengths between the fruits.

The `ClusteredMesh` task is here to generate a labelled triangular mesh that can be visualized, but is not necessary to the previous quantification workflow.
Note that this task could be used in place of the `OrganSegmentation` task, and it could be later used by `AnglesAndInternodes`.