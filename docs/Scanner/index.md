# Plant Phenotyping

![Dense COLMAP reconstruction](../assets/images/colmap_arabidopsis.png){width=800 loading=lazy}

!!! abstract
    Within the ROMI project, some work packages are oriented towards the development of a plant phenotyping platform adapted to single potted plants.
    To achieve this goal, the team developed a suite of tools presented hereafter.

1. The user put his/her plant inside the scanner and run **acquisitions**, which returns a set of images per plant.
2. These images are uploaded to a **central database**.
3. The user **defines a pipeline** to reconstruct and quantify plants architecture by choosing among a set of predefined methods and algorithms. These instructions may be run by a distant server.
4. Finally the user can access the acquisitions, reconstructions & quantitative data by connecting to a visualization server using his/her computer

## Modular architecture
We aim at making our software architecture modular to make it more flexible and suitable to several applications from the ROMI project when possible.

[PlantDB :material-database-outline:](modules/plantdb.md){ .md-button }
[Plant 3D Explorer :material-file-tree-outline:](modules/plant_3d_explorer.md){ .md-button }

[Plant Imager :material-robot-excited-outline:](modules/plant_imager.md){ .md-button }
[Virtual Plant Imager :material-camera-iris:](modules/virtual_plant_imager.md){ .md-button }
[Plant 3D Vision :material-pine-tree-box:](modules/plant_3d_vision.md){ .md-button }


| Module Name      |  ROMI Packages                     |  Dependencies                                                 |
|------------------|------------------------------------|---------------------------------------------------------------|
| DB               | `romidata`                         | `luigi`, `flask`                                              |
| SmartInterpreter | `romiscan`, `romiseg`, `romicgal`  | `luigi`, `pytorch`, `labelme`, `tensorboard`                  |
| Visualizer       | `3d-plantviewer`                   | `npm`                                                         |
| PlantScanner     | `romiscanner`                      | `pyserial`                                                    |
| VirtualScanner   | `romiscanner`                      | `openalea.plantgl`, `openalea.lpy`, `bpy` (blender), `flask`  |

![Plant Phenotyping platform](../assets/images/interact_plan_landscape.png)


#### PlantDB
Should be totally independent of the rest since it could be uses in other parts of the ROMI project (Rover, Cable bot, ...) trough the abstract class `DB` or even the local database class `FSDB`.

#### PlantScanner
It requires a physical connection to the hardware (`pyserial`) to control. It also needs an active ROMI database to export acquired datasets (plant images).

#### Virtual Plant Imager
It requires a connection to an active ROMI database to export generated datasets (virtual plant images). In case of machine learning methods, a database would also provides training datasets.

#### Plant 3D Vision
It requires connection to an active ROMI database to import datasets to process and export the results.
Two plant reconstruction approaches are available in the SmartInterpreter:

1. Geometry based, try to infer the plant's geometry using structure from motion algorithms and space carving to first reconstruct a point cloud. 
2. Machine learning based, try to infer the plant's geometry using semantic (organ) segmentation of pictures and space carving to first reconstruct a labelled point cloud.

Then meshing and skeletonization finally enables to extract the plant's phyllotaxis.

#### Plant 3D Explorer
It requires a database with datasets to browse and represent.


## Glossary

We hereafter defines the semantic, names and abbreviations to use in the projects documentations and communications.

ROMI Software
: the whole set of software developed by ROMI;

ROMI Hardware
: the three types of robots developed by ROMI, namely the "cable bot", the "rover" and the "plant imager";


### Database related

database
: the database itself;

scan
: a set of images, and the pipelines results;

fileset
: a set of files (*e.g.* a set of RGB images of a plant);

file
: a file (*e.g.* an RGB image of a plant);

plant metadata
: set of FAIR metadata attached to the plant (*e.g.* species, age, growth conditions...);

acquisition metadata
: set of metadata attached to the acquisition procedure & hardware configuration (*e.g.* version of the CNC controller, camera settings, ...);

!!! danger
    "scans" could be renamed "dataset" or !


## Research oriented user story

1. The user put his/her plant inside the scanner and run **acquisitions**, which returns a set of images per plant.
2. These images are uploaded to a **central database**.
3. The user **defines a pipeline** to reconstruct and quantify plants architecture by choosing among a set of predefined methods and algorithms. These instructions may be run by a distant server.
4. Finally the user can access the acquisitions, reconstructions & quantitative data by connecting to a visualization server using his/her computer
