Metadata is stored hierarchically. We currently use the JSON format. 

MIAPPE

## ROMI

### Setup
Found under the `scanner` top level section, it contains information about the hardware and software used for the scan:

- the used camera with `camera_args`, `camera_firmware`,  `camera_hardware` &  `camera_lens`
- the model and version of the scanning station with `id`
- list of hardware and software components and their versions with `cnc_args`, `cnc_firmware`, `cnc_hardware`, `frame`, `gimbal_args`, `gimbal_firmware`, `gimbal_hardware`
- the used workspace with `workspace`

Example
```toml
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
```toml
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
```toml
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
```toml
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
```toml
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


## Example

This is an example of a file `metadata.json` found under `<dataset_id>/metadata/`:
```json
{
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
    },
    "measures": {
        "angles": [
            2.6179938779914944,
            1.3089969389957472,
            1.6580627893946132,
            1.3089969389957472,
            2.356194490192345,
            2.443460952792061,
            1.6580627893946132,
            2.356194490192345,
            2.8797932657906435,
            1.9198621771937625,
            2.007128639793479,
            2.96705972839036,
            2.530727415391778,
            2.1816615649929116,
            2.1816615649929116,
            2.1816615649929116,
            2.443460952792061,
            2.1816615649929116,
            1.0471975511965976,
            3.2288591161895095,
            2.0943951023931953,
            2.705260340591211,
            2.0943951023931953
        ],
        "internodes": [
            41,
            32,
            28,
            17,
            9,
            9,
            18,
            7,
            9,
            11,
            14,
            11,
            9,
            9,
            6,
            15,
            8,
            4,
            12,
            3,
            4,
            5,
            1
        ]
    },
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
    },
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
    },
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
}```