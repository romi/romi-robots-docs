# Evaluate an analysis in a virtual world (both virtual plant and imager)


## Objective
Quantitative evaluation of a 3D reconstruction and/or automated measure from a phenotyping experiment is critical, from both developer and end-user perspectives. However, obtaining ground truth reference is often tedious (e.g. manual measurements, it must be anticipated (synchronous measures with image acquisition), and some type of data are just inacessible with available technologies (e.g. having a reference point cloud).

Virtual plants makes data acquisition inexpensive and allows to parametrize the type of data. By design, ground truth data can be easily extracted from these virtual datasets. We thus designed the `Virtual Plant Imager` to take images of any 3D object, as a digital twin of our real `plant imager`.

After reading this tutorial, you should be able to generate a single virtual plant dataset (including several ground truth reference) in order to evaluate the phenotyping results generated through an analysis pipeline made with our [plant-3d-vision](https://github.com/romi/plant-3d-vision) tool suite.

## Prerequisite

<div class="icon">
  <img src="/assets/images/ext/docker_logo2.png" alt="docker_logo">
  We highly recommend the use of docker containers to run ROMI software, if you wish to use the docker images we provide, have a look <a href="https://github.com/romi/plant-imager#docker">here</a>.
</div>

If it is not already done, you must be able to build and run the docker images of: 

* the `(Virtual) Plant Imager` by following these [instructions](https://github.com/romi/plant-imager#docker). This is required to generate the virtual data (initial plant 3D model, ground truth and RGB images).
* the `plant-3d-vision` by following these [instructions](https://github.com/romi/plant-3d-vision#Docker). This is required to reconstruct a 3D model from the virtual 2D images, as if they were images of real plants. This docker will also allow you to evaluate this reconstruction using the available virtual ground truth data.

## Step-by-step tutorial
**Principle**: 
You want to evaluate the results generated by an analysis pipeline made with our `plant-3d-vision` tool suite. Let's say that this pipeline is defined by a typical configuration file, `test_pipe.toml`. 

The idea is to generate images of a virtual 3D plant and provide these picture as input to the tested analysis pipeline. Technically, the `Virtual Plant Imager` relies on [Blender v2.93](https://www.blender.org/) to generate at set of (2D) RGB images from the plant 3d model, mimicking what a real camera would do on a real plant. Any virtual camera pose can be generated (ie. distance, angle), but virtual poses similar to the real robot (`plant imager`) are preferred. An HTTP server acts as an interface to drive Blender generation scripts.

The virtual plant 3D model (with some of its ground truth references) can be imported and given as an input. However, we provide an integrated procedure to generate a virtual 3D plant directly "on the fly" with [Lpy](https://lpy.readthedocs.io/en/latest/), using a Lpy model and customizable parameters. Some ground truth references will also be automatically generated.

Once this virtual plant has been virtually imaged, there are all data and metadata required to run an analysis with the tested pipeline. The results of this analysis will be compared to the virtual ground truth. Four type of [evaluations](../specifications/tasks/evaluation_tasks.md) are currently implemented :

  *   evaluation of a 2D segmentation
  *   evaluation of a 3D segmentation of the point cloud
  *   comparison of point cloud similarity
  *   evaluation of phyllotaxis measures (angles and internodes)

### 1. Prepare data into a proper database
First, create a working directory on your host machine, let's say `home/host/path/my_virtual_db`.
You can find an example of such a directory [here](https://github.com/romi/plant-imager/tree/master/database_example).

This working directory is a proper ["romi" database](../install/plantdb_setup.md#Initialize-a-ROMI-database) which contains additional data for the virtual plant generation and/or imaging grouped in a so-called ``vscan_data` folder:

**Legend**: 

*   (*) the name is fixed and cannot be changed
*   (!) the folder/file must exist (no tag means that the folder is not required for the program to run)

```
my_virtual_db/
│   romidb (!*) # a (empty) marker file for recognition by the plantdb module
└───vscan_data/ (!*) 
│   └───hdri/ (*)
│       │   hdri_file1.hdr
│       │   hdri_file2.hdr
│       │   etc...
│   └───lpy/ (*)
│       │   my_plant_species_model.lpy
│   └───obj/ (*)
│       │   VirtualPlant.obj
│       │   VirtualPlant_mtl
│   └───metadata/(!*)
│       │   hdri.json
│       │   lpy.json
│       │   obj.json
│       │   palette.json
│       │   scenes.json
│   └───palette/ (*)
│       │   my_plant_species_model.png
│   └───scenes/ (*)
│   files.json
```
#### 1.1 quick ready-to-use example
**Recommended if you are not familiar with the virtual plant imager**. 
You can directly obtain a functional working directory from the repository of the [plant-imager](https://github.com/romi/plant-imager) you cloned in your host machine

So if your working directory is named `my_virtual_db`, execute in a terminal:
```shell
cd plant-imager # enter the cloned repository in your host machine
cp -r database_example home/host/path/my_virtual_db
```
To skip details and directly run the `virtual plant imager`, **go now to section [2.]**(#2-generate-virtual-images-from-a-lpy-virtual-plant-in-a-virtual-scene)
#### 1.2 Customize data of the virtual plant and/or of the virtual images 

!!! warning
    For advanced users. If you modify data, you most likely need to modify the configuration .toml file downstream. 

You can modify and enrich the virtual dataset in several manner (modifying the LPy model and parameters, importing your own model and avoiding Lpy-generation, change background scenes, etc...).
For all these options, please refer to the [specifications](../specifications/virtual-plant-imager.md) of the `virtual plant imager`.

### 2. Generate virtual images from a (Lpy) virtual plant in a virtual scene

Start the docker container of the `plant-imager` with your database mounted:

```shell
cd plant-imager/docker
./run.sh -db /home/host/path/my_virtual_db  # This will map your working databse to the `db` directory located in the docker's user home
```
Then, in this docker container, generate the virtual dataset by running the following command:

```shell
(lpyEnv) user@5c9e389f223d  romi_run_task --config plant-imager/configs/vscan_lpy_blender.toml VirtualScan db/my_virtual_plant # Run VirtualScan by specifying the output folder 'my_virtual_plant'
```

The computation can take a few minutes, depending on your system capacities. if it works, the terminal should display something like that:
```shell
===== Luigi Execution Summary =====

Scheduled 4 tasks of which:
* 2 complete ones were encountered:
    - 1 LpyFileset(scan_id=vscan_data)
    - 1 PaletteFileset(scan_id=vscan_data)
* 2 ran successfully:
    - 1 VirtualPlant(...)
    - 1 VirtualScan(...)

This progress looks :) because there were no failed tasks or missing dependencies
```
**Results**: in your database, a new folder (here called my_virtual_plant) should have been created, that contain data and metadata related to the virtual image acquisition of this virtual plant !

```
my_virtual_db
│   romidb
└───vscan_data/
└───my_virtual_plant/
│   ├── images/
│   ├── metadata/
│   │   └── images/
│   │   └── images.json
│   └── files.json
│   └── scan.toml
```

With the default parameters provided with this example (Lpy model and configuration file), there is only one generated plant, which has the following main characteristics

*   It is a model of an *Arabidopsis thaliana* plant
*   It has only a main stem and no lateral branches (simplified architecture)
*   It is a mature plant, that has grown an elongated inflorescence stem bearing several mature fruit (called a 'silique', the typical pod of the *Brassicaceae* family) and still has some flowers at the very tip.

In the next two sections, we point to simple paramaters of the configuration [file](https://github.com/romi/plant-imager/blob/master/configs/vscan_lpy_blender.toml) used for this task to modify either the virtual plant or 
the virtual imaging.

#### 2.1 (optional) how to modify the virtual plant with LPy parameters

!!! Note
    Detailed description can be found here

Below are the main lpy parameters that can be customized to change how the virtual plant looks like (age, size, branching, etc...).

```toml
[VirtualPlant.lpy_globals]
BRANCHON = false
MEAN_NB_DAYS = 70
STDEV_NB_DAYS = 5
BETA = 51
INTERNODE_LENGTH = 1.3
STEM_DIAMETER = 0.09
```

#### 2.2 (optional) how to modify the virtual imaging performed by the virtual imager

!!! Note
    Detailed description can be found here

Below are the main lpy parameters that can be customized to change how the virtual images are taken (path, background scenes, resolution, etc...)

virtual camera path
[ScanPath]
class_name = "Circle"
[ScanPath.kwargs]
center_x = -2
center_y = 3
z = 65
tilt = 8
radius = 75
n_points = 18

### 3. Running a reconstruction pipeline on the virtual dataset
Once you have a virtual dataset of images that all look like a real one, you can analyze it like a real one with romi pipelines from our `plant-3d-vision` tool suite !

[Remember](#step-by-step-tutorial) that the pipeline you want to evaluate is defined by the following configuration file: `test_pipe.toml`.

To adapt to the virtual imaging and focus the evaluation to the downstream image analysis and 3D reconstruction, you can adapt the configuration file to include ground truth from virtual imaging to use ground truth poses. Create a new configuration file for the evaluation and modify it as follows:

```shell
cp test_pipe.toml test_pipe_veval.toml #copy and rename the configuration file of the pipeline you want to test 
```
In the newly created `test_pipe_veval.toml`, deactivate use of colmap poses for the volume carving algorithm ([Voxel] Task of the pipeline).
```toml
[Voxels]
use_colmap_poses = false
[Masks]
upstream_task = Scan
```

Then the analysis pipeline can be run as usual except that `colmap` will not be run :

```shell
romi_run_task \ #romi pipeline scheduler 
--config path/to/test_pipe_veval.toml \ # configuration of the pipeline to evaluate
AnglesAndInternodes \ #Last task to execute
/path/to/my_virtual_plant #folder inside the database on which the analysis will be run
```

This run should process all dependencies and generates notably a segmented point cloud and measures of the phyllotaxis (angles and internodes) ! 

!!! Note
    any available romi Tasks for image analysis can be runned here.
    Please refer to the [list of Tasks](../specifications/tasks/index.md) implemented in our romi software suite.

!!! Note
    The command line can be executed in docker container or in a terminal if you have activated the correct virtual environments and proceeded to local installation of the software.

    Please refer to this [tutorial](../tutorials/reconstruct_scan.md) if you encounter problems to run pipeline from our `plant-3d-vision` tool suite.



After execution, the terminal should display luigi execution summary, as in this example:
```shell
===== Luigi Execution Summary =====

Scheduled 8 tasks of which:
* 2 complete ones were encountered:
    - 1 ImagesFilesetExists(scan_id=, fileset_id=images)
    - 1 ModelFileset(scan_id=models)
* 6 ran successfully:
    - 1 AnglesAndInternodes(...)
    - 1 OrganSegmentation(scan_id=, upstream_task=SegmentedPointCloud, eps=2.0, min_points=5)
    - 1 PointCloud(...)
    - 1 Segmentation2D(...)
    - 1 SegmentedPointCloud(scan_id=, upstream_task=PointCloud, upstream_segmentation=Segmentation2D, use_colmap_poses=False)
    ...

This progress looks :) because there were no failed tasks or missing dependencies

===== Luigi Execution Summary =====
```
**Results**: new subfolders and metadata resulting from the analysis should have been created in the folder of the analyzed plant dataset (called `my_virtual_plant` in this example).

The particular data generated depends on the pipeline you called. We provide an example here with a pipeline involving machine-learning based segmentation of 2D images and proceeding up to phyllotaxis measures (angles & internodes.)

*legend*: 
  * (.) indicates data that were already present before the run of the pipeline (but the data content may have been modified)
  * folder names generated by the analysis generally start with the corresponding Task name end with a hashcode to keep track of task execution by the Luigi scheduler (e.g. _1_0_2_0_0_1_5f7aad388e). Such code is replaced by '_hashcode' suffix in the example below

```
my_virtual_db
│   romidb (.)
└───vscan_data/ (.)
└───my_virtual_plant/ (.)
│   ├── images/ (.)
│   ├── metadata/ (.)
│   ├── AnglesAndInternodes_hashcode/
│   ├── OrganSegmentation_hashcode/
│   ├── PointCloud_hashcode/
│   ├── Segmentation2D_hashcode/
│   ├── PointCloudGroundTruth_100000__VirtualPlantObj_hashcode/
│   ├── SegmentedPointCloud__Segmentation2D_PointCloud_3a1e8e0010/
│   ├── VirtualPlant/
│   ├── VirtualPlant_arabidopsis_note___BRANCHON___fal___angles____inte_hashcode/
│   ├── Voxels_False___background_____False_hashcode/
│   └── files.json (.)
│   └── scan.toml (.)
│   └── pipeline.toml
```

### 4. Evaluate the quality of the construction by comparing to the virtual ground truth data
(work in progress)

Once the analysis results are generated, you can now compare this results to the expected ground truth reference of the virtual plant.

Several Evaluation Tasks have been developed by romi: check the [list](../specifications/tasks/evaluation_tasks.md) to know which results are evaluating each of them.

In the below example, we would like to evaluate the point-cloud reconstruction, so we run:

```shell
romi_run_task \ #romi pipeline scheduler 
--config path/to/test_pipe_veval.toml \ # configuration of the pipeline to evaluate 
PointCloudEvaluation \ #evaluation task of to run
/path/to/my_virtual_plant #analyzed data folder of the database that you want to evaluate
```
!!! Note
    Please refer to this [tutorial] if you encounter problems to run pipeline from our `plant-3d-vision` tool suite.

### 5. View and scrutinize in 3D all data generated  (images, reconstruction and evaluation)
(work in progress)
Use of the plant-3d-explorer
