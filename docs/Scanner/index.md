Plant scanner overview
======================


## User story

1. The user put his/her plant inside the scanner and run **acquisitions**, which returns a set of images per plant.
2. These images are uploaded to a **central database**.
3. The user **defines a pipeline** to reconstruct and quantify plants architecture by choosing among a set of predefined methods and algorithms. These instructions may be run by a distant server.
4. Finally the user can access the acquisitions, reconstructions & quantitative data by connecting to a visualization server using his/her computer

## Modular architecture
As we don't want to always have to install every repository from the ROMI project, we need to properly organize our code to make it modular.
For example, there is no point to install the `lettucethink-python` package on a server used to perform *plant reconstruction tasks* and that is not "attached" to the RPS.

### Modular design
The following figure shows each independent module and the way they interact.

<img src="/assets/images/intract_plan.png" alt="Plant scanner overview" width="800" />

### Module details
Each of the following modules should be seen as separate virtual machines or containers able to communicates.

| Validated | Module Name      | Container Name   | ROMI Packages                        |
|:---------:|------------------|------------------|--------------------------------------|
|           | DB               | romi_db          | `data-storage`                       |
|           | PlantScanner     | romi_scan        | `lettucethink-python`, `romiscanner` |
|           | SmartInterpreter | romi_interpreter | `Scan3D`, `romiseg`                  |
|           | Visualizer       | romi_viz         | `3d-plantviewer`                     |
|           | VirtualScanner   | romi_virtual     | `VirtualPlants`, `romiscanner`       |

!!! info
    The previous module container or package names, are still open to discussion!


#### DB
Should be totally independent of the rest since it could be use with other projects trough the abstract class `DB` or even the local database class `FSDB`.

#### PlantScanner
It requires a physical connection to the hardware that is should control and needs a database to export acquired datasets (plant images).

#### SmartInterpreter
It requires connection to a database to import datasets to process and export results.

#### VirtualScanner
It requires a connection to a database to export generated datasets (virtual plant images). In case of machine learning methods, a database would also provides training datasets.

#### Visualizer
It requires a database with datasets to browse and represent.


## Semantics

We hereafter defines the semantic, names and abbreviations to use in the projects documentations and communications.

### Macroscopic & non-technical
- [ ] **ROMI Softwares**: the whole set of software developed by ROMI;
- [ ] **ROMI Hardwares**: the three types of robots developed by ROMI, namely the "cable bot", the "rover" and the "scanner";
- [ ] **ROMI Scanner Softwares** - the set of software developed by the "scanner group";
- [ ] **ROMI Plant Scanner** - RPS: the hardware that enable (automatic) acquisition of a set of 2D or 3D images of the plant;
- [ ] **(Single) Plant Reconstruction Pipeline** - (S)PRP: the set of methods (and packages?) used to performs a 3D reconstruction of a plant using data from the *ROMI Plant Scanner*;
- [ ] **Plant Phenotyping Pipeline** - PPP or P^3^: the set of methods (and packages?) used to performs plant phenotyping (traits quantification) from the obtained 3D reconstruction;
- [ ] **Virtual Plant Image Generator** - VPIG: the set of methods (and packages?) used to generate sets of images in a similar fashion than the RPS;


### Repository & packages

| Validated | Repository          | Package             | Description                                                                                                |
|:---------:|---------------------|---------------------|------------------------------------------------------------------------------------------------------------|
|           | data-storage        | romidata            | The database API used in the ROMI project, as well as classes for data processing using luigi.             |
|           | Scan3D              | romiscan            | This repo gathers the elements used to run 3D scan of individual plants by ROMI partners.                  |
|           | romiscanner         | romiscanner         | Hardware interface for the 3D Scanner, as well as virtual scanner                                          |
|           | lettucethink-python | lettucethink-python | Python tools and controllers for the lettucethink robot                                                    |
|           | Segmentation        | romiseg             | Virtual plant segmentation methods using 2D images generated from the virtual scanner and neural networks. |
|           | 3d-plantviewer      | ?                   | Browser application to visualize 3D scanned plants                                                         |
|           | VirtualPlants       | ?                   | Models of various plants in LPy                                                                            |

!!! info
    The previous names, repository or package, is still open to discussion!


### Database related
- [ ] database: the database itself;
- [ ] datasets/project: a set of images and the pipelines results;
- [ ] fileset: a set of files (*eg.* a set of RGB images of a plant);
- [ ] plant metadata: set of FAIR metadata attached to the plant (*eg.* species, age, growth conditions...);
- [ ] acquisition metadata: set of metadata attached to the acquisition procedure & hardware configuration (*eg.* version of the CNC controller, camera settings, ...);

!!! danger
    datasets/project are called "scan" for now!
