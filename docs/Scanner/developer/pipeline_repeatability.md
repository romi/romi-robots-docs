Testing the reconstruction pipelines repeatability
===

## Objective
The reconstruction pipeline aims to convert the series of RGB images output of the plant-imager to a reconstructed 3d object, here a plant, with the ultimate goal to obtain quantitative phenotype information.
It is composed of a sequence of different tasks, each having a specific function.
Some algorithms used during these tasks may be stochastic, hence their output might vary even tough we provide the same input.
As it can impact the results of the analysis and is often not easily traceable, it is of interest to be able to quantify it.

Two main things can be tested:
* With a proper metric, estimate how much different the outputs of a task can be given the same input.
* Evaluation of the repercussion in the phenotypic traits extraction of a pipeline including randomness.



## Prerequisite


* install romi `plant-3d-vision` (from [source](https://github.com/romi/plant-3d-vision) or using a [docker image](../docker/plantinterpreter_docker.md)) & read [install procedure](../install/plant_reconstruction_setup.md)
* Create and activate isolated python environment (see the procedure [here](../../install/create_env.md) )


## Step-by-step tutorial
The `robustness_comparison` script has been developed to quantify randomness in the pipeline and has 2 modes, it can either test the stochasticity of one task or of the full pipeline. 
Basically it compares outputs of a task given the same input (previous task output or acquisition output depending on the mode) on a fixed parameterizable number of replicates.


```
robustness_comparison -h
usage: robustness_comparison [-h] [-n REPLICATE_NUMBER] [-f] [-np]
                             [-db TEST_DATABASE] [--models MODELS]
                             scan
                             {Clean,Colmap,Undistorted,Masks,Segmentation2D,Voxels,PointCloud,TriangleMesh,CurveSkeleton,TreeGraph,AnglesAndInternodes,Segmentation2d,SegmentedPointCloud,ClusteredMesh,OrganSegmentation}
                             config_file


ROMI reconstruction & analysis pipeline repeatability test procedure. Analyse
the repeatability of a reconstruction & analysis pipeline by: 1. duplicating
the scan in a temporary folder (and cleaning it if necessary) 2. running the
pipeline up to the previous task of the task to test 3. copying this result to
a new database and replicate the dataset 4. repeating the task to test for
each replicate 5. comparing the results pair by pair. Comparison can be done
at the scale of the files but also with metrics if a reference can be set. To
create fully independent tests, we run the pipeline up to the task to test on
each replicate. Note that in order to use the ML pipeline, you will first have
to: 1. create an output directory 2. use the `--models` argument to copy the
CNN trained models required to run the pipeline.


positional arguments:
  scan                  scan to use for repeatability analysis
  {Clean,Colmap,Undistorted,Masks,Segmentation2D,Voxels,PointCloud,TriangleMesh,CurveSkeleton,TreeGraph,AnglesAndInternodes,Segmentation2d,SegmentedPointCloud,ClusteredMesh,OrganSegmentation}
                        task to test, should be in: Clean, Colmap,
                        Undistorted, Masks, Segmentation2D, Voxels,
                        PointCloud, TriangleMesh, CurveSkeleton, TreeGraph,
                        AnglesAndInternodes, Segmentation2d,
                        SegmentedPointCloud, ClusteredMesh, OrganSegmentation
  config_file           path to the TOML config file of the analysis pipeline


optional arguments:
  -h, --help            show this help message and exit
  -n REPLICATE_NUMBER, --replicate_number REPLICATE_NUMBER
                        number of replicate to use for repeatability analysis
  -f, --full_pipe       run the analysis pipeline on each replicate
                        independently
  -np, --no_pipeline    do not run the pipeline, only compare tasks outputs
  -db TEST_DATABASE, --test_database TEST_DATABASE
                        test database location to use. Use at your own risks!
  --models MODELS       models database location to use with ML pipeline.
```
The metrics used are the same as the ones for an evaluation against ground truth


### 1. Test of a single task
Example with the task TriangleMesh (whose goal is to compute a mesh from a point cloud):
```shell
robustness_comparison /path/db/scan TriangleMesh plant-3d-vision/config/pipeline.toml -n 10
```

Resulting:
```
path/
├── 20210628123840_rep_test_TriangleMesh/
│   ├── scan_0
│   ├── scan_1
│   ├── scan_2
│   ├── scan_3
│   ├── scan_4
│   ├── scan_5
│   ├── scan_6
│   ├── scan_7
│   ├── scan_8
│   ├── scan_9
│   ├── filebyfile_comparison.json
│   ├── romidb
│   ├── TriangleMesh_comparison.json
└── db/scan
```
The scan datasets are identical up to `PointCloud` then the `TriangleMesh` task is run separately on each one.
Results with the appropriate metric are in the `TriangleMesh_comparison.json` file.


### 2. Independent tests
If the goal is to see what are the impacts of randomness through the pipeline in the output of the task `TriangleMesh`, perform an independent test thanks to the -f parameter:
```shell
robustness_comparison /path/db/scan TriangleMesh plant-3d-vision/config/pipeline.toml -n 10 -f
```

With a similar tree result:
```
path/
├── 20210628123840_rep_test_TriangleMesh/
│   ├── scan_0
│   ├── scan_1
│   ├── scan_2
│   ├── scan_3
│   ├── scan_4
│   ├── scan_5
│   ├── scan_6
│   ├── scan_7
│   ├── scan_8
│   ├── scan_9
│   ├── filebyfile_comparison.json
│   ├── romidb
│   ├── TriangleMesh_comparison.json
└── db/scan
```

!!! Note
    To run tests on an existing database the -db parameter is configurable but be careful of what is to be tested