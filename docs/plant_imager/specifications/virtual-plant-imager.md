Instructions and main specifications for the virtual plant imager
===============================

!!! warning 
    clearly separate Lpy and the VPI

## General description 
The `Virtual Plant Imager` functions as a digital twin of the real romi robot `Plant imager`: it takes rgb images of one to several virtual 3D plant models and generate all data and metadata necessary to proceed downstream with a training of a neural network or with an analysis pipeline of the `plant-3d-vision` tool suite.

* As **input**, it takes a 3D model (`.obj`) file ;

* As **output**, it provides one to several datasets in a [romi database format](/docs/plant_imager/install/plantdb_setup.md#Initialize-a-ROMI-database), ready for downstream use (training or analysis).
```
db/
├── virtual_imageset/
│   ├── images/
│   ├── metadata/
│   │   └── images/
│   │   └── images.json
│   └── files.json
│   └── scan.json
└── romidb
```

The `Virtual Plant Imager` relies on [Blender v2.81a](https://www.blender.org/) to generate at set of (2D) RGB images from a plant 3d model. An HTTP server acts as an interface to drive Blender generation scripts.

!!! Note
    The `Virtual Plant Imager` is closely integrated with the plant generator [Lpy](https://lpy.readthedocs.io/en/latest/). For information related to the generation of virtual 3D model of plants, you will be redirected to other LPy documentation.
 
## Input data (for romi_run_task VirtualScan)
As for all ROMI tools, the `Virtual Plant Imager` requires a proper database to store, access and generate new data.
Let's call `virtual_db` this database. In particular, it contains data for the virtual plant generation and/or imaging grouped in a so-called ``vscan_data`` folder:

**Legend**: 

*   (*) the name is fixed and cannot be changed
*   (!) the folder/file must exist (no tag means that the folder is not required for the program to run)

```
virtual_db
│   romidb (!*) # a (empty) marker file for recognition by the plantdb module
└───vscan_data (!*) 
│   └───hdri (*)
│       │   hdri_file1.hdr
│       │   hdri_file2.hdr
│       │   etc...
│   └───lpy (*)
│       │   my_plant_species_model.lpy
│   └───obj (*)
│       │   VirtualPlant.obj
│       │   VirtualPlant_mtl
│   └───metadata (!*)
│       │   hdri.json
│       │   lpy.json
│       │   obj.json
│       │   palette.json
│       │   scenes.json
│   └───palette (*)
│       │   my_plant_species_model.png
│   └───scenes (*)
│   files.json
```
Following sections detail the content of each files and subfolders.
##### hdri
If no hdri files are provided, a uniform black background will be applied. Even if they are provided, hdri backgrounds can be deactivated in the `.toml` file (related romi_run task: `VirtualScan`) and the default black background will be applied.

New background HDRI files can be downloaded from [hdri haven](https://hdrihaven.com/) and store in the `hdri` folder. Limited resolution is enough for downstream applications (we recommend 2K resolution, 6.2 MB total download).

! Note 
if there are several hdri files -> which one is used ?

##### lpy
`.lpy` files contain a parametric model of a plant that [Lpy](https://lpy.readthedocs.io/en/latest/) will use to generate a 3D model as an .obj file.
With the above data_example, we provide the file `arabidopsis_notex.lpy`, a Lpy model for the laboratory model plant *Arabidopsis thaliana* (copyright C. Godin, Inria - RDP Mosaic).

You can replace this file with any other Lpy model file. The correct name of the file must then be specified in the configuration .toml file (see below)

```toml
[VirtualPlant]
lpy_file_id = "arabidopsis_notex" #base name of the .lpy to be used by Lpy
```

If you do not want to use Lpy to generate your virtual plant, you can also directly import your custom 3D plant (generated elsewhere), which must be at the .obj format. In this case, lpy subfolder is dispensable, store data in the `obj` subfolder (see next)

##### obj
Alternatively to Lpy-generated, custom 3D plant model can be provided. Data must consist in a `obj` and a `mtl` files.

In the `.obj`, each semantic type of label desired to segment the plant must correspond to a distinct mesh.
Each of these meshes must have a single material whose name is the name of the label.


(note QUESTION: and then, what are the groundtruth ? how are they provided ?)

##### metadata
lpy.json
```json
{
    "task_params": {
        "output_file_id": "out",
        "scan_id": "vscan_data"
    }
}
```
other files (hdri/palette/scenes.json):
```json
{
    "task_parameters": {},
    "task_params": {
        "output_file_id": "out",
        "scan_id": "vscan_data"
    }
}
```

##### palette
a `.png` file containing textures that will LPy will apply on the virtual plant.

##### scenes

##### files.json
fileset descriptor with "id" definitions.

```json
{
    "filesets": [
        {
            "files": [
                {
                    "file": "felsenlabyrinth_2k.hdr",
                    "id": "felsenlabyrinth_2k"
                },
                {
                    "file": "forest_slope_2k.hdr",
                    "id": "forest_slope_2k"
                }
            ],
            "id": "hdri"
        },
        {
            "files": [
                {
                    "file": "arabidopsis_notex.lpy",
                    "id": "arabidopsis_notex"
                }
            ],
            "id": "lpy"
        },
        {
            "etc..."
        }
    ]    
}
```
## Running the virtual plant imager

### Basic command lines 
 **Corresponding task with romi_run_task**:  `VirtualScan`
 ```shell
 romi_run_task VirtualScan \
 --config vpi_single_dataset.toml  \
 path/to/db/generated_dataset
 ```
the content of the configuration file `vpi_single_dataset.toml` will be detailed un the next section
 ### configuration file for the Task Virtual Scan
see also the page on specifications>tasks>VPI (does not exist yet, to be created)
 