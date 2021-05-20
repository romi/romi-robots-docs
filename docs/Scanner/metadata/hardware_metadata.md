Hardware metadata & scan settings
=================================
Hardware metadata are informative of the hardware setup like the used camera, its firmwares or the workspace size.

## Definitions

Here is a list of hardware metadata and their definition:

* **frame**: scanner frame type and version, _eg_: "30profile v1";
* **X_motor**: type of motor used for the X axis, _eg_: "X-Carve NEMA23";
* **Y_motor**: type of motor used for the Y axis, _eg_: "X-Carve NEMA23";
* **Z_motor**: type of motor used for the Z axis, _eg_: "X-Carve NEMA23";
* **pan_motor**: , type of motor used for the camera pan axis, _eg_: "Dynamixel";
* **tilt_motor**: , type of motor used for the camera tilt axis, _eg_: "Gimball";
* **sensor**: type of sensor used during acquisition, _eg_: "Sony alpha";
* **scan_os**: , _eg_: "";

The metadata dictionary made of `frame`, `X_motor`, `Y_motor`, `Z_motor`, `pan_motor` & `tilt_motor` define the **hardware_id** used in the `README.md`.

The `sensor` metadata could be more detailed, for example as a dictionary or a reference to a **sensor_id** database?

## Configuration

!!! todo
    How is it defined in a TOML configuration file ?

## Database location

Located in `metadata/metadata.json` and found under the `scanner` top level section, it contains information about the hardware and software used for the scan:

* the used camera with `camera_args`, `camera_firmware`,  `camera_hardware` &  `camera_lens`
* the model and version of the scanning station with `id`
* list of hardware and software components and their versions with `cnc_args`, `cnc_firmware`, `cnc_hardware`, `frame`, `gimbal_args`, `gimbal_firmware`, `gimbal_hardware`
* the used workspace with `workspace`

## JSON example

Example of a `metadata/metadata.json` file for hardware metadata:

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
  Gather all camera parameters under a `camera` section? Gather all cnc parameters under a `cnc` section? Gather all gimbal parameters under a `gimbal` section?
