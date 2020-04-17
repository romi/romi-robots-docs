How to use the plant reconstruction and analysis pipeline?
=======

## Getting started

To follows this guide you should have a `conda` or a Python `venv`, see [here](/Scanner/how-to/#how-to-install-romi-packages)

### Install required dependencies `colmap`:
Follow the procedure from the official documentation [here](https://colmap.github.io/install.html#).
Make sure to use version 3.6.

TODO: use COLMAP python build [script](https://colmap.github.io/install.html#build-script) to make conda package?

Note: If you are using a conda environment, you can install `ceres-solver` dependency for COLMAP from the conda-forge channel:
```bash
conda install ceres-solver -c conda-forge
```

If you want to use NVIDIA for OpenCL in the processing pipeline, install `pyopencl` from source, and configure it to use OpenCL 1.2 (NVIDIA does not support the default OpenCL 2.0).

First, make sure you have python headers installed, on ubuntu:
```bash
apt install python3.7-dev
```

Then install `pyopencl` from source, and configure it to use OpenCL 1.2:
```bash
git clone https://github.com/inducer/pyopencl
cd pyopencl
git submodule update --init
pip install pybind11 mako
./configure.py --cl-pretend-version=1.2 # NVIDIA has bad OpenCL support and only provides OpenCL 1.2
python setup.py install
cd ..
```

**Troubeshooting:**

 - If you have an error `[...] src/wrap_cl.hpp:57:10: fatal error: CL/cl.h [...]` you are missing the OpenCL headers: 
     ```bash
     sudo apt install opencl-headers
     ```
 - If you have an error `[...]compiler_compat/ld: cannot find -lOpenCL [...]`:
      ```bash
     sudo apt install ocl-icd-libopencl1
     ```


### Install ROMI packages with `pip`:
This can be done both in the Python `venv` and the `conda` environment. 

#### Install `data-storage` sources:
Since we will need an active database to performs the reconstruction, we install it as follows:
```bash
pip install git+https://github.com/romi/data-storage.git@dev
```

#### Install `romiscanner` sources:
```bash
pip install git+https://github.com/romi/romiscanner
```

#### Install `cgal_bindings_skeletonization` sources:
```bash
pip install git+https://github.com/romi/cgal_bindings_skeletonization
```

!!! note
    This takes some time since it has to download dependencies (`CGAL-0.5` & `boost-1.72.0`) and compile them.

#### Install `Scan3D` sources:
```bash
pip install git+https://github.com/romi/Scan3D@dev
```

#### OPTIONAL - Install `romiseg` sources:
To install the additional segmentation module:
```bash
pip install git+https://github.com/romi/Segmentation@dev
```
!!! warning
    If not using CUDA 10.*, you have to install the matching `pytorch` distribution.
    For example, for CUDA 9.2, use:
    ```bash
    pip install torch==1.4.0+cu92 -f https://download.pytorch.org/whl/torch_stable.html
    ```

## Reconstruction pipeline

### Test database:
To quickly create an example DB you can use:
```bash
wget https://db.romi-project.eu/models/test_db.tar.gz
tar -xf test_db.tar.gz
```
This will create a `integration_tests` folder with a ready to use test database. 


### Geometric pipeline

#### Real scan dataset
The full *geometric pipeline*, _ie._ all the way to angles and internodes measurement, can be called on real dataset with:
```bash
romi_run_task --config Scan3D/config/original_pipe_0.toml AnglesAndInternodes integration_tests/2019-02-01_10-56-33 --local-scheduler
```
!!! note
    This example uses a real scan dataset from the test database.

#### Virtual plant dataset
The full *geometric pipeline*, _ie._ all the way to angles and internodes measurement, can be called on a virtual dataset with:
```bash
romi_run_task --config Scan3D/config/original_pipe_0.toml AnglesAndInternodes integration_tests/arabidopsis_26 --local-scheduler
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

#### Real scan dataset
The full *geometric pipeline*, _ie._ all the way to angles and internodes measurement, can be called on real dataset with:
```bash
romi_run_task --config Scan3D/config/original_pipe_1.toml AnglesAndInternodes integration_tests/2019-02-01_10-56-33 --local-scheduler
```
!!! note
    This example uses a real scan dataset from the test database.

#### Virtual plant dataset
The full *geometric pipeline*, _ie._ all the way to angles and internodes measurement, can be called on a virtual dataset with:
```bash
romi_run_task --config Scan3D/config/original_pipe_1.toml AnglesAndInternodes integration_tests/arabidopsis_26 --local-scheduler
```
!!! note
    This example uses a virtual scan dataset from the test database.
