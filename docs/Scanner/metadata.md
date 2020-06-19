Metadata are stored hierarchically. We currently use the JSON format. 


## ROMI scanner metadata

There are many JSON files containing metadata in the `metadata` directory attached to a dataset.

The first you should consider is `metadata/metadata.json`.
Its content and meaning is explained in the [general metadata](#general-metadata) section. 

Then there are the JSON files attached to each task, *e.g.* `Colmap_True____feature_extrac_3bbfcb1413.json`, they contain the parameter used to run this task. 
Their content and meaning is explained in the [task metadata](#tasks-metadata) section. 

!!! todo
    Explain what are & who produce:
    
    - the image JSON file `metadata/images.json`
    - the image JSON files found under `metadata/images/*.json`
    - the visualization JSON file `metadata/Visualization.json`
    - the visualization JSON files found under `metadata/Visualization/*.json`


## General metadata

### Setup
Found under the `scanner` top level section, it contains information about the hardware and software used for the scan:

- the used camera with `camera_args`, `camera_firmware`,  `camera_hardware` &  `camera_lens`
- the model and version of the scanning station with `id`
- list of hardware and software components and their versions with `cnc_args`, `cnc_firmware`, `cnc_hardware`, `frame`, `gimbal_args`, `gimbal_firmware`, `gimbal_hardware`
- the used workspace with `workspace`

Example
```json
    "scanner": {
        "camera_args": {
            "api_url": "http://192.168.122.1:8080"
        },
        "camera_firmware": "sony_wifi",
        "camera_hardware": "Sony Alpha 5100",
        "camera_lens": "16-35 stock",
        "cnc_args": {
            "homing": true,
            "port": "/dev/ttyUSB1"
        },
        "cnc_firmware": "grbl-v1.1",
        "cnc_hardware": "xcarve-v2",
        "frame": "alu 40mm",
        "gimbal_args": {
            "baud_rate": 57600,
            "dev": "/dev/ttyUSB0",
            "tilt0": 3072
        },
        "gimbal_firmware": "dynamixel-usb2dynamixel",
        "gimbal_hardware": "dynamixel",
        "id": "lyon_1",
        "workspace": {
            "x": [
                200,
                600
            ],
            "y": [
                200,
                600
            ],
            "z": [
                -180,
                260
            ]
        }
    }
```

!!! todo
    Gather all camera parameters under a `camera` section?
    Gather all cnc parameters under a `cnc` section?
    Gather all gimbal parameters under a `gimbal` section?


### Biology
Found under the `object` top level section, it contains biologically relevant information such as the studied species, its age and growth conditions.
This information are not restricted in their format but should contain a minimal set of entries.

!!! todo
    Defines the minimal set of entries! Use the MIAPPE standard?

Example:
```json
    "object": {
        "age": "62d",
        "culture": "LD",
        "environment": "Lyon indoor",
        "experiment_id": "living plant",
        "object": "plant",
        "plant_id": "Col0_26_10_2018_B",
        "sample": "main stem",
        "species": "Arabidopsis thaliana",
        "stock": "186AV.L1",
        "treatment": "none"
    }
```


### Scanning operation
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
    Where are the:
    
    - list of positions of camera, as given by scanning hardware
    - list of position of camera, as computed by the software


### Reconstruction
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


### Measures and results
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


### Performance analysis

- Duration


### Other

- Observations of the person doing the scan


## Tasks metadata
These JSON files contain the parameter used to run the task and are produced by each task.

!!! todo
    Explains the meaning of the weird tag associated to the task name!


## Images metadata
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


## Visualization metadata
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

