Plant reconstruction and analysis pipeline
===

## Getting started

To follows this guide you should have:

* installed the necessary ROMI software [here](../install/plant_reconstruction_setup.md) or followed the instructions for the docker image [here](../docker/plantinterpreter_docker.md)
* access to a database with a "plant acquisition" to reconstruct (or use the provided examples)


## Reconstruction pipeline


### Cleaning a dataset
If you made a mess, had a failure or just want to start fresh with your dataset, no need to save a copy on the side, you can use the `Clean` task:
```bash
romi_run_task Clean integration_tests/2019-02-01_10-56-33 \
    --config romiscan/config/original_pipe_0.toml --local-scheduler
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
    --config romiscan/config/original_pipe_0.toml --local-scheduler
```

!!! note
    This example uses a real scan dataset from the test database.

#### Virtual plant dataset
The full *geometric pipeline*, _ie._ all the way to angles and internodes measurement, can be called on a virtual dataset with:
```bash
romi_run_task AnglesAndInternodes integration_tests/arabidopsis_26 \
    --config romiscan/config/original_pipe_0.toml --local-scheduler
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
    This requires the installation of the `romiseg` libraries (see here for install [instructions](../install/plant_reconstruction_setup.md#install-romiseg-sources)) and a trained PyTorch model!
     
!!! note
    A trained model, to place under `<dataset>/models/models`, is accessible here: https://media.romi-project.eu/data/Resnetdataset_gl_png_896_896_epoch50.pt

#### Real scan dataset
The full *geometric pipeline*, _ie._ all the way to angles and internodes measurement, can be called on real dataset with:
```bash
romi_run_task PointCloud integration_tests/2019-02-01_10-56-33 
    --config romiscan/config/ml_pipe_vplants_3.toml --local-scheduler
```

!!! note
    This example uses a real scan dataset from the test database.

#### Virtual plant dataset
The full *geometric pipeline*, _ie._ all the way to angles and internodes measurement, can be called on a virtual dataset with:
```bash
romi_run_task PointCloud integration_tests/arabidopsis_26 \
    --config romiscan/config/ml_pipe_vplants_3.toml --local-scheduler
```

!!! note
    This example uses a virtual scan dataset from the test database.

