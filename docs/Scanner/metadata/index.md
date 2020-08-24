FAIR data for the ROMI plant scanner project
============================================

## FAIR data
We aim at using FAIR data principles in the ROMI plant scanner project.

Quoting the [GoFAIR](https://www.go-fair.org/fair-principles/) website:

!!!quote 
    In 2016, the "[FAIR Guiding Principles for scientific data management and stewardship](http://www.nature.com/articles/sdata201618)" were published in Scientific Data.
    The authors intended to provide guidelines to improve the **Findability**, **Accessibility**, **Interoperability**, and **Reuse** of digital assets.
     The principles emphasise machine-actionability (i.e., the capacity of computational systems to find, access, interoperate, and reuse data with none or minimal human intervention) because humans increasingly rely on computational support to deal with data as a result of the increase in volume, complexity, and creation speed of data.

In our context, a biological dataset is a set of RAW images (eg: RGB images), used to reconstruct the plant 3D structure, associated with a set of metadata of different nature: biological, hardware & software.


## ROMI plant scanner metadata
Metadata are stored hierarchically.
We currently use the JSON format. 

There are many JSON files containing metadata in the `metadata` directory attached to a dataset.


### General metadata
The first you should consider is `metadata/metadata.json`.
Its top-level entries are:

* "scanner", the hardware metadata (see [here](hardware_metadata.md))
* "object", the biological metadata (see [here](biological_metadata.md))
* "path", the parameter values used for the task `Scan` (see [here](#scanning-operation))
* "computed",  the parameter values used for the task `Colmap` (see [here](#colmap-reconstruction))
* "measures",  the parameter values used for the task `AnglesAndInternodes` (see [here](#measures-of-angles-and-internodes))

!!! todo
    Remove top-level entries "path", "computed" & "measures", they look like duplicates from their respective task metadata.

#### Scanning operation
Found under the `path` top level section, it contains:

- the trajectory of the camera under `path`

Example:
```json
    "path": {
        "args": {
            "filetype": "jpg",
            "num_points": 72,
            "radius": 350,
            "tilt": 0.45,
            "xc": 400,
            "yc": 400,
            "z": 0
        },
        "id": "circular_72",
        "type": "circular"
    }
```

!!! todo
    Potential duplication from the `Scan` task metadata!


#### Colmap reconstruction
Found under the `computed` top level section, it contains the `camera_model` used by Colmap.

Example:
```json
    "computed": {
        "camera_model": {
            "height": 1080,
            "id": 1,
            "model": "OPENCV",
            "params": [
                1102.2709767952233,
                1102.2709767952233,
                808.0,
                540.0,
                -0.015118876273724434,
                -0.015118876273724434,
                0.0,
                0.0
            ],
            "width": 1616
        }
    }
```

!!! todo
    Potential duplication from the `Colmap` task metadata!


#### Measures of angles and internodes
Found under the `measures` top level section:
- Measured angles are under `angles`
- Measured internodes are under `internodes`

Example:
```json
    "measures": {
        "angles": [
            2.6179938779914944,
            1.3089969389957472,
            ...
            2.0943951023931953
        ],
        "internodes": [
            41,
            32,
            ...
            1
        ]
    }
```

!!! todo
    Potential duplication from the `AnglesAndInternodes` task metadata!


### Tasks metadata
Then there are the JSON files attached to each task, *e.g.* `Colmap_True____feature_extrac_3bbfcb1413.json`, they contain the parameter used to run this task. 
Their content and meaning is explained in the [task metadata](tasks_metadata.md) section. 

### Images metadata
The image JSON file `metadata/images.json` contains ??? and is produced by ???.

Example:
```json
{
    "task_params": {
        "fileset_id": "images",
        "output_file_id": "out",
        "scan_id": ""
    }
}
```

Found under the `metadata/images` directory, these JSON files contains  ??? and is produced by ???.

!!! note
    Sub-section `camera_model` seems redundant with same section in [reconstruction](#reconstruction).

Example:
```json
{
    "calibrated_pose": [
        49.04537654162613,
        401.1470121046677,
        -0.10613970524327433
    ],
    "colmap_camera": {
        "camera_model": {
            "height": 1080,
            "id": 1,
            "model": "OPENCV",
            "params": [
                1106.9593323985682,
                1106.9593323985682,
                808.0,
                540.0,
                -0.012379986602455324,
                -0.012379986602455324,
                0.0,
                0.0
            ],
            "width": 1616
        },
        "rotmat": [
            [
                -0.07758281248083276,
                0.9961595266033345,
                0.040584538496628464
            ],
            [
                -0.4230067224604736,
                -0.069751540308706,
                0.9034378979087665
            ],
            [
                0.9027991027691664,
                0.05292372040950383,
                0.42679369706827314
            ]
        ],
        "tvec": [
            -397.2357284138349,
            49.50722946972662,
            -66.64522999892229
        ]
    },
    "pose": [
        50.0,
        400.0,
        0,
        0.0,
        0.45
    ]
}
```


### Visualization metadata
The visualization JSON file `metadata/Visualization.json` contains ??? and is produced by ???.

!!! important
    Run the `Visualization` task to complete this section!

Example:
```json
{
    "files": {
        "angles": "AnglesAndInternodes",
        "images": [
            "image_rgb-000",
            "image_rgb-001",
            ...
            "image_rgb-071"
        ],
        "mesh": "TriangleMesh",
        "point_cloud": "PointCloud",
        "poses": "images",
        "skeleton": "CurveSkeleton",
        "thumbnails": [
            "thumbnail_rgb-000",
            "thumbnail_rgb-001",
            ...
            "thumbnail_rgb-071"
        ],
        "zip": "scan"
    }
}
```

Found under the `metadata/Visualization/` directory, there are two category of JSON files:
 
 - `image_*.json` contains  ??? and is produced by ???.
 - `thumbnail_*.json` contains  ??? and is produced by ???.

Example for `image_*.json`:
```json
{
    "image_id": "rgb-000"
}
```

Example for `thumbnail_*.json`:
```json
{
    "image_id": "rgb-000"
}
```


### Other metadata

!!! todo
    Explain what are & who produce:
    
    - the image JSON file `metadata/images.json`
    - the image JSON files found under `metadata/images/*.json`
    - the visualization JSON file `metadata/Visualization.json`
    - the visualization JSON files found under `metadata/Visualization/*.json`

