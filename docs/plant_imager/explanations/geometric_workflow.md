# The geometry based workflow

The first workflow we introduce is the one we called _geometry based workflow_ as it transform the obtained point cloud, after reconstruction, to extract a semantic skeleton (called _tree graph_) and use it to compute the fruit orientation in space.
From there we can fulfill our goal: to estimate the fruits' successive angles and internodes lengths.

## Reconstruction part

### Aim
The aim of the reconstruction part is to reconstruct a 3D model of the plant, here a point cloud, from a set of RGB images.

### General idea
We sought at combining _structure from motion_ with _space carving_ to obtain a **quick and reliable** 3D reconstruction of the plant.

The rational is mainly in two part:

1. We have to use _structure from motion_ to get accurate estimate of the **true camera positions** because of the uncertainties from the motors (see [open-loop-design](strengths_limits.md#open-loop-design)).
2. We use _space carving_, instead of _multiview stereo_ (as in the second part of Colmap reconstruction pipeline), because we want a **fast reconstruction of a small portion of the scene**.

The second step is **fast** because we use a simple _linear filter_ to detect the plant position, and we select a small region where there is only the plant to reconstruct.

However, without a precise and repeatable acquisition procedure with the _Plant Imager_, you might have to often change the bounding-box manually, which **breaks the full automation** of the reconstruction procedure.

### Overview

<figure>
  <img src="/assets/images/geom_reconstruct_pipeline.svg" width="800" />
  <figcaption>
    Reconstruction part of the geometry based workflow as defined in <samp>geom_pipe_real.toml</samp> configuration & default parameters.
  </figcaption>
</figure>

### Details
1. We start with the `Colmap` task to estimate both intrinsic and extrinsic parameters using a _structure from motion_ algorithm.
2. The camera intrinsics are used by the `Undistorted` task with a `SIMPLE_RADIAL` model to fix the original RGB images.
3. Then the `Masks` task detect the plant position in each image and create a binary mask for each.
4. This is later used by the `Voxels` task, in combination with the camera extrinsics (also called camera poses), to perform the _space carving_ of a 3D volume. This reconstructs the volume occupied by the plant in the selected portion of the scene.
5. Finally, this is turned into a point cloud describing the envelope of the reconstructed plant structure by the `PointCloud` task.


## Quantification part

### Aim
The aim of the quantification part is estimate the fruits' successive angles and internodes lengths, from the 3D point cloud.

### General idea
We sought at extracting the **skeleton** of the plant to be able to **estimate the organs direction**, here the fruits or leaves, thanks to a single trajectory of points describing it.

### Overview

<figure>
  <img src="/assets/images/geom_quantif_pipeline.svg" width="800" />
  <figcaption>
    Quantification part of the geometry based workflow as defined in <samp>geom_pipe_real.toml</samp> configuration & default parameters.
  </figcaption>
</figure>

### Details
1. We start by transforming the point cloud into a triangular mesh with the `TriangleMesh` task.
2. From there we can extract the _plant skeleton_ thanks to the `CurveSkeleton` task.
3. We then augment this structure with "biological meaning" to this skeleton by defining the root of the tree, labelling the points as fruits or main stem using the `TreeGraph` task.
4. Finally, the `AnglesAndInternodes` task will compute the _fruits direction and branching points_, allowing us to estimate the successive angles and internode lengths between the fruits.