How to use the plant reconstruction and analysis pipeline?
==========================================================

## Getting started

To follows this guide you should have:

* installed the necessary ROMI software [here](../install/plant_reconstruction_setup.md)
* access to a database with a "plant acquisition" to reconstruct (or use the provided examples)


## Reconstruction pipeline

### Test database
To quickly create an example DB you can use:
```bash
wget https://db.romi-project.eu/models/test_db.tar.gz
tar -xf test_db.tar.gz
```
This will create a `integration_tests` folder with a ready to use test database. 


### Cleaning a dataset
If you made a mess, had a failure or just want to start fresh with your dataset, no need to save a copy on the side, you can use the `Clean` task:
```bash
romi_run_task Clean integration_tests/2019-02-01_10-56-33 \
    --config Scan3D/config/original_pipe_0.toml --local-scheduler
``` 
Here the config may use the `[Clean]` section where you can defines the `force` option:
```toml
[Clean]
force=true
```
If `true` the `Clean` task will run silently, else in interactive mode.


### Geometric pipeline

#### Real scan dataset
The full *geometric pipeline*, _ie._ all the way to angles and internodes measurement, can be called on real dataset with:
```bash
romi_run_task AnglesAndInternodes integration_tests/2019-02-01_10-56-33 \
    --config Scan3D/config/original_pipe_0.toml --local-scheduler
```

!!! note
    This example uses a real scan dataset from the test database.

#### Virtual plant dataset
The full *geometric pipeline*, _ie._ all the way to angles and internodes measurement, can be called on a virtual dataset with:
```bash
romi_run_task AnglesAndInternodes integration_tests/arabidopsis_26 \
    --config Scan3D/config/original_pipe_0.toml --local-scheduler
```

!!! note
    This example uses a virtual scan dataset from the test database.

!!! warning
    If you get something like this during the `Voxel` tasks:
    ```
    Choose platform:
    [0] <pyopencl.Platform 'NVIDIA CUDA' at 0x55d904d5af50>
    Choice [0]:
    ```
    that mean you need to specify the environment variable `PYOPENCL_CTX='0'`

### Machine Learning pipeline

!!! warning
    This requires a trained PyTorch model!
     
!!! note
    A trained model, to place under `<dataset>/models/models`, is accessible here: https://media.romi-project.eu/data/Resnetdataset_gl_png_896_896_epoch50.pt

#### Real scan dataset
The full *geometric pipeline*, _ie._ all the way to angles and internodes measurement, can be called on real dataset with:
```bash
romi_run_task PointCloud integration_tests/2019-02-01_10-56-33 
    --config Scan3D/config/ml_pipe_vplants_3.toml --local-scheduler
```

!!! note
    This example uses a real scan dataset from the test database.

#### Virtual plant dataset
The full *geometric pipeline*, _ie._ all the way to angles and internodes measurement, can be called on a virtual dataset with:
```bash
romi_run_task PointCloud integration_tests/arabidopsis_26 \
    --config Scan3D/config/ml_pipe_vplants_3.toml --local-scheduler
```

!!! note
    This example uses a virtual scan dataset from the test database.


## Use docker containers

### Colmap docker

Assuming you are in the test database folder, you can test a colmap docker image as follows:
```bash
docker run --gpus all -it \
    -w /db_test -v `pwd`:/db_test \
    colmap/colmap bash
``` 

If you want to provide the path to the images directory, replace `pwd` by the path.

Then inside the running container you can test a colmap command such as:
```bash
colmap feature_extractor \
    --image_path 2019-02-01_10-56-33/images/ \
    --database_path colmap_test.db \
    --SiftExtraction.use_gpu 1
```

### romiscan docker

!!! warning
    No `romiscan` docker image is available yet from `roboticsmicrofarms` docker hub repository since it is still under development and super heavy ~9 Go !! So you have to build it locally

#### Local build
To build the `romiscan:0.7` docker container, in a terminal run following command from 'docker/' folder:
```bash
docker build -t romiscan:0.7 .
``` 

!!! warning
    This rely on NVIDIA CUDA technology so you need an NVIDIA GPU that is CUDA capable. Moreover, if you don't have CUDA 10.2 driver installed, ou will have to change the base container (colmap/colmap by default) to match your version (or update your drivers if possible).

To test correct access to NVIDIA GPU resources from built image:
```bash
docker run -it --gpus all romiscan:0.7 nvidia-smi
```

#### Test procedure
To start the `romiscan:0.7` docker container and run the automatic test defined in `Scan3D/tests/check_pipe.sh`:
```bash
docker run --runtime=nvidia --gpus all -it romiscan:0.7
``` 

#### Interactive use
It is also possible to use this container to performs "reconstruction tasks" as you would with a local install on your machine.
To start the `romiscan:0.7` docker container and access a `bash` terminal as `romi` user:
```bash
docker run --runtime=nvidia --gpus all -it \
    -v `pwd`:/home/romi/db \
    --env PYOPENCL_CTX='0' \
    romiscan:0.7 bash
``` 

!!! note
    This create a `db` directory in the `romi` user home directory and mount the actual directory you are in (`pwd`) in this `home/romi/db` directory. So call this from within your local database directory or replace `pwd` with its path.

!!! note
    You may want to set `PYOPENCL_CTX='0'` as environment variable to automatically select it as `pyopencl.Platform`. To do so, just add `--env PYOPENCL_CTX='0'` before `romiscan:0.7 bash`.

You can now call "romi tasks" within the running docker container.
For example, to run the full *geometric pipeline* on the "real dataset example" named `2019-02-01_10-56-33`:
```bash
romi_run_task AnglesAndInternodes db/2019-02-01_10-56-33 \
    --config Scan3D/config/original_pipe_0.toml --local-scheduler
```

You may want to "clean" the dataset first:
```bash
romi_run_task Clean db/2019-02-01_10-56-33 \
    --config Scan3D/config/original_pipe_0.toml --local-scheduler
```
