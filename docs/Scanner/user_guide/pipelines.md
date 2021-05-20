!!! warning
    This is a work in progress... the original author has no idea what he is doing!

## Legend

Let's start with a description of the used symbols:
![Legend](../../assets/images/legend.svg)

- _Note shaped_ boxes are `RomiConfig`, they are TOML files that contains parameters for each task.
- _Round shaped_ boxes are `RomiTasks` with their name on the first level, then the module names (`--module` option in `romi_run_task`) and a quick description of the tasks at hand.
- _Folder shaped_ boxes are `RomiTarget`, they indicate files input/output and the file extension is given between parenthesis.

## Acquisitions

### Acquisition of real plant datasets

![Acquisition - Scan task](../../assets/images/pipeline-acquisition-real_plants.svg)

### Acquisition of virtual plant datasets

![Acquisition - VirtualScan task](../../assets/images/pipeline-acquisition-virtual_plants.svg)

## Plant Reconstruction from RGB images

![Reconstruction - AnglesAndInternodes task](../../assets/images/lite_reconstruction_pipeline.svg)

## 3D Plant Phenotyping

### Geometric approach

![Quantification - AnglesAndInternodes task](../../assets/images/lite_geometric_pipeline.svg)

### Machine Learning approach

![Quantification - AnglesAndInternodes task](../../assets/images/lite_ml_pipeline.svg)

## Evaluation

### Mask task evaluation

![Evaluation - Masks task](../../assets/images/pipeline-evaluation-masks.svg)

### Voxel task evaluation

![Evaluation - Voxels task](../../assets/images/pipeline-evaluation-voxels.svg)

### PointCloud task evaluation

![Evaluation - PointCloud task](../../assets/images/pipeline-evaluation-pointcloud.svg)
