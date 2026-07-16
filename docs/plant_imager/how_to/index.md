# How To

## End users

To get detailed instructions on how to perform tasks like data _acquisition_, _reconstruction_ and _quantification_, follows these instructions:

### Acquisitions

- [How to **Scan Plants** with _Plant Imager 2.1_](scan_plant_imager_2.1.md)
- [How to **Scan Plants** with _Plant Imager 3_](scan_plant_imager_3.md)
- [How to Scan VirtualPlants with th **Plant Imager 3**](scan_plant_imager_3.md)

## Reconstructions & Quantification

- [How to Fix World Frame for Older Scan Datasets](fix_world_frame.md)
- [How to Choose Linear Coefficients and Threshold Parameters for Plant‑Mask Generation](select_linear_params.md)
- [How to Reconstruct Plants with the **Geometric Pipeline**](reconstruct_plant_geom.md)
- [How to Reconstruct Plants with the **ML Pipeline**](reconstruct_plant_ml.md)

## Exploratory Analysis

- [How to Explore Reconstruction and Quantification with the **Plant 3D Explorer**]()

## Tasks details

To get a deeper understanding of what each task does, we made some notebooks.

- [**Colmap** - From RGB images to camera poses](../../assets/notebooks/HowTo%20-Colmap-%20From%20RGB%20images%20to%20camera%20poses.ipynb)
- [**Undistorted** - Undistort RGB images using camera model](../../assets/notebooks/HowTo%20-Undistorted-%20Undistort%20RGB%20images%20using%20camera%20model.ipynb)
- [**Masks** - From RGB images to masks](../../assets/notebooks/HowTo%20-Masks-%20From%20RGB%20images%20to%20masks.ipynb)
- [**Voxels** - From mask images and camera coordinates to volume](../../assets/notebooks/HowTo%20-Voxels-%20From%20mask%20images%20and%20camera%20coordinates%20to%20volume.ipynb)
- [**PointCloud** - From carved volume to point cloud](../../assets/notebooks/HowTo%20-PointCloud-%20From%20carved%20volume%20to%20point%20cloud.ipynb)
- [**TriangleMesh** - From point cloud to triangular mesh](../../assets/notebooks/HowTo%20-TriangleMesh-%20From%20point%20cloud%20to%20triangular%20mesh.ipynb)
- [**CurveSkeleton** - From triangular mesh to curved skeleton](../../assets/notebooks/HowTo%20-CurveSkeleton-%20From%20triangular%20mesh%20to%20curved%20skeleton.ipynb)
- [**TreeGraph** - From curved skeleton to tree graph](../../assets/notebooks/HowTo%20-TreeGraph-%20From%20curved%20skeleton%20to%20tree%20graph.ipynb)
- [**AnglesAndInternodes** - Extract fruits angles and internodes distance from a tree graph](../../assets/notebooks/HowTo%20-AnglesAndInternodes-%20Extract%20fruits%20angles%20and%20internodes%20distance%20from%20a%20tree%20graph.ipynb)

You have to download them and execute them by calling `jupyter notebook` in the conda environment with the `plant-3d-vision` module installed.