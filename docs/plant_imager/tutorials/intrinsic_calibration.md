# Intrinsic calibration

Some cameras introduce significant distortion to images.
The two major kinds of distortion are **radial distortion** and **tangential distortion**.

With _radial distortion_, straight lines appear curved while with _tangential distortion_ some objects of the image may appear closer than they are in reality.

<div class="polaroid">
  <img src="https://docs.opencv.org/4.x/calib_radial.jpg" alt="ChArUco board example"/>
  <div class="container">
    <p>Illustration of an image captured with radial distortion as shown by the straight red lines added on top the picture afterward.
    <br><u>Source</u>: OpenCV Python tutorial on <a href="https://docs.opencv.org/4.x/dc/dbb/tutorial_py_calibration.html">camera calibration</a>.</p>
  </div>
</div>


## Objective
Correcting these "aberrations" prior to image processing can be a good idea to improve **quality** and **accuracy** of the reconstructed 3D scenes by _structure from motion_ algorithms.

In this tutorial, you will learn how to **estimate the intrinsic camera parameters** to calibrate image acquisition for downstream analysis and how to re-use it for a reconstruction pipeline, provided that the set-up is the same (same camera, optics, image size...).


## Prerequisite

* Install the [`plant-imager`](https://github.com/romi/plant-imager) ROMI library required to perform _image acquisitions_ together with the _Plant Imager hardware_.

* Install the [`plant-3d-vision`](https://github.com/romi/plant-3d-vision) ROMI library required to perform _intrinsic calibration_.

* Set up a ROMI `plantdb` local [database](../specifications/data.md) or quickly create it (under `/data/ROMI/DB`) with the following commands:
    ```shell
    export DB_LOCATION=/data/ROMI/DB
    mkdir $DB_LOCATION
    touch $DB_LOCATION/romidb
    ```

<div class="icon">
  <img src="/assets/images/ext/docker_logo2.png" alt="docker_logo">
  We highly recommend the use of docker containers to run ROMI software, if you wish to use the docker images we provide, have a look <a href="https://github.com/romi/plant-imager#docker">here</a>.
</div>


## Step-by-step tutorial

### 1. Make a ChArUco board and print it
A ChArUco board is the combination of a chess board and of ArUco markers.

<figure>
    <img src="/assets/images/charuco_board_4x4_14by10_2_1.5.png" alt="ChArUco board example" width="600" /> 
    <figcaption>An example of a 14x10 ChArUco board with 20mm chess square and 15mm 4x4 ArUco markers.</figcaption>
</figure>

The previous figure shows the default board that we will use in this tutorial.

To create it, you have to run the `create_charuco_board` CLI as follows:
```shell
create_charuco_board plant-3d-vision/config/intrinsic_calibration.toml
```
This will create a file named `charuco_board.png` in the current working directory.

We strongly advise to **use the same** TOML configuration file with `create_charuco_board` & `romi_run_task` commands to avoid inadvertently changing parameter values.
Also, you will later need it for the estimation of the intrinsic camera parameters.

An example of `intrinsic_calibration.toml` configuration file is:
```toml
[CreateCharucoBoard]
n_squares_x = "14"  # Number of chessboard squares in X direction.
n_squares_y = "10"  # Number of chessboard squares in Y direction.
square_length = "2."  # Length of square side, in cm
marker_length = "1.5"  # Length of marker side, in cm
aruco_pattern = "DICT_4X4_1000"  # 'DICT_4X4_50', 'DICT_4X4_100', 'DICT_4X4_250', 'DICT_4X4_1000'

[DetectCharuco]
upstream_task = "ImagesFilesetExists"
board_fileset = "CreateCharucoBoard"
min_n_corners = "20"  # Minimum number of detected corners to export them

[IntrinsicCalibration]
upstream_task = "DetectCharuco"
board_fileset = "CreateCharucoBoard"
```

You may now **print the ChArUco board image**.
Pay attention to use a software (like GIMP) that allows you to set the actual size of the image you want to print.
With the previous configuration it should be:

 - width : `n_squares_x * square_length = 14 * 2. = 28cm`
 - height : `n_squares_y * square_length = 10 * 2. = 20cm`

Finally, **tape it flat onto something solid** in order to avoid deformation of the printed pattern!


### 2. Scan the ChArUco board
To scan your newly printed ChArUco board, use the `IntrinsicCalibrationScan` task from `plant_imager`:
```shell
romi_run_task IntrinsicCalibrationScan $DB_LOCATION/intrinsic_calib_1 --config plant-3d-vision/config/scan.toml
```

The camera should move to the center front of the _plant imager_ where you will hold your pattern and take `20` pictures (according to the previous configuration).
Try to take pictures of the board in different positions.

<div class="responsive">
  <div class="gallery">
    <a target="_blank" href="/assets/images/charuco_gallery/00000_rgb.jpg">
      <img src="/assets/images/charuco_gallery/00000_rgb.jpg" alt="charuco board example" height="400">
    </a>
    <div class="desc">00000_rgb.jpg</div>
  </div>
</div>

<div class="responsive">
  <div class="gallery">
    <a target="_blank" href="/assets/images/charuco_gallery/00003_rgb.jpg">
      <img src="/assets/images/charuco_gallery/00003_rgb.jpg" alt="charuco board example" height="400">
    </a>
    <div class="desc">00003_rgb.jpg</div>
  </div>
</div>

<div class="responsive">
  <div class="gallery">
    <a target="_blank" href="/assets/images/charuco_gallery/00005_rgb.jpg">
      <img src="/assets/images/charuco_gallery/00005_rgb.jpg" alt="charuco board example" height="400">
    </a>
    <div class="desc">00005_rgb.jpg</div>
  </div>
</div>

<div class="responsive">
  <div class="gallery">
    <a target="_blank" href="/assets/images/charuco_gallery/00014_rgb.jpg">
      <img src="/assets/images/charuco_gallery/00014_rgb.jpg" alt="charuco board example" height="400">
    </a>
    <div class="desc">00014_rgb.jpg</div>
  </div>
</div>


As illustrated by the previous image examples, it is not required to have the whole board in the picture, the ArUco markers will be used to detect the occluded sections!

An example for the `scan.toml` configuration file is:
```toml
[IntrinsicCalibrationScan]
n_poses = 20  # Number of acquisition of the printed ChArUco board
offset = 5

[CalibrationScan]
n_points_line = 11
offset = 5

[ScanPath]
class_name = "Circle"

[ScanPath.kwargs]
center_x = 375
center_y = 375
z = 90
tilt = 0
radius = 300
n_points = 36

[Scan.scanner.camera]
module = "plantimager.sony"  # RX-0 camera

[Scan.scanner.gimbal]
module = "plantimager.blgimbal"  # plant imager hardware v2

[Scan.scanner.cnc]
module = "plantimager.grbl"  # plant imager hardware v2

[Scan.metadata.object]
species = "none"
seed_stock = "none"
plant_id = "test"
growth_environment = "none"
growth_conditions = "None"
treatment = "none"
DAG = 0
sample = "test_sample"
experiment_id = "None"
dataset_id = "test"

[Scan.metadata.hardware]
frame = "30profile v2"
X_motor = "X-Carve NEMA23"
Y_motor = "X-Carve NEMA23"
Z_motor = "X-Carve NEMA23"
pan_motor = "iPower Motor GM4108H-120T Brushless Gimbal Motor"
tilt_motor = "None"
sensor = "Sony RX-0"

[Scan.metadata.workspace]
x = [ 100, 500,]
y = [ 100, 500,]
z = [ -300, 100,]

[Scan.scanner.camera.kwargs]
device_ip = "192.168.122.1"
api_port = "10000"
postview = true
use_flashair = false
rotation = 270

[Scan.scanner.gimbal.kwargs]
port = "/dev/ttyACM1"
has_tilt = false
zero_pan = 0
invert_rotation = true

[Scan.scanner.cnc.kwargs]
port = "/dev/ttyACM0"
baud_rate = 115200
homing = true
```

### 3. Performs the camera parameters estimation
You may now **estimate the camera parameters**, for a given _camera model_ with:
```shell
romi_run_task IntrinsicCalibration $DB_LOCATION/intrinsic_calib_1 --config plant-3d-vision/config/intrinsic_calibration.toml
```
This should generate a `camera_model.json` inside the `$DB_LOCATION/intrinsic_calib_1/camera_model` folder.

An example of a `camera_model.json` file is:
```json
{
    "model": "OPENCV",
    "RMS_error": 0.3484289537533634,
    "camera_matrix": [
        [
            1201.7588127324675,
            0.0,
            702.5429671940506
        ],
        [
            0.0,
            1199.117692017527,
            536.7266695161917
        ],
        [
            0.0,
            0.0,
            1.0
        ]
    ],
    "distortion": [
        0.021462456820485233,
        -0.04707700665017203,
        -0.00014475851274869323,
        -0.0011459776173976073,
        0.0
    ],
    "height": 1440,
    "width": 1080
}
```

!!! important
    Do not hesitate to make several independent attempts at camera calibration, like 3 to 5, and choose the one with the lowest overall RMS error.
    Obviously, _independent_ here means that you should perform multiple scans of the board and camera parameters estimation.