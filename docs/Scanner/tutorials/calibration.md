Extrinsic calibration
=================

## Objective

In order to correct errors that might be induced by the hardware setup, a procedure of extrinsic calibration has been developed.
We will see in this section how to do a calibration scan and use it in the further analysis.

## Prerequisite
The *Colmap* structure from motion algorithm is used during the 3d reconstruction (detailed here) and allows us to obtain more accurate positions of the camera than the ones returned by the robot. 
Those computed positions are determined up to a scaling and roto-translation of the world and as a result, present a problem for measuring real world unit quantities. 
To have the closest from reality scaling possible, the positions of the robotic arm when following the path are given to Colmap but are as accurate as the encoder allows them to be. 
So each camera pose is aligned with the corresponding CNC arm position. 
That can lead to a bias in scaling induced by the offset between the camera optical center and the CNC arm as represented in the following picture:    
![Offset between camera and robotic arm](../../assets/images/calibration_camera_offset.png){width=600 loading=lazy} 

It is particularly true when doing circular path (which is often the case with the phenotyping station). 
Indeed, because of that offset, the distance between 2 camera poses is bigger than it should be and as a result, the reconstructed the object is bigger than it is in real life (with a relative error of 2d / D). 
To correct that, a procedure has been developed to perform an extrinsic calibration and apply the results for further scans.

## Step-by-step tutorial

### 1. Calibration Scan
Because the bias is mainly induced by making a circular scan, one way to avoid it is to do a calibration scan with first a path constituted of lines (2 orthogonal lines in our case) followed by the path that will be used by other scans.  

![Calibration scan diagram](../../assets/images/calibration_scan_figure.png){width=600 loading=lazy}

To do so, run the CalibrationScan task the same way as for a regular Scan:

```shell
romi_run_task --config config/hardware.toml CalibrationScan /path/to/db/calibration_scan_id/
```

For Colmap in order to get the maximum reference points from the scene, you might want to scan several "recognizable" objects.

### 2. Get circular poses from path lines with Colmap

Then thanks to the linear path added to the circular one, it is possible to retrieve accurate poses from Colmap with a proper scaling:

```shell
romi_run_task --config config/geom_pipe_full.toml Colmap /path/to/db/calibration_scan_id/
```

### 3. Use the poses extracted from the calibration scan
We can now use the calibrated poses for the 3d reconstruction (full process detailed [here](reconstruct_scan.md)) of other scans, just add the *Colmap* section in the configuration toml file for reconstruction:

```toml
[Colmap]
calibration_scan_id = "calibration_scan_id"
```

These two image set must be in the same DB.