Install ROMI software for plants reconstruction
===============================================

To follows this guide you should have a `conda` or a Python `venv`, see [here](create_conda_env.md).

For the sake of clarity the environment will be called `plant_reconstruct`.


## Install required dependencies `colmap`:
Follow the procedure from the official documentation [here](https://colmap.github.io/install.html#).
Make sure to use version 3.6.

!!!todo
    use COLMAP python build [script](https://colmap.github.io/install.html#build-script) to make conda package?

!!!note 
    If you are using a conda environment, you can install `ceres-solver` dependency for COLMAP from the conda-forge channel:
```bash
conda install ceres-solver -c conda-forge
```

If you want to use NVIDIA for OpenCL in the processing pipeline, install `pyopencl` from source, and configure it to use OpenCL 1.2 (NVIDIA does not support the default OpenCL 2.0).

First, make sure you have python headers installed, on ubuntu:
```bash
sudo apt install python3.7-dev
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


## Install ROMI packages with `pip`:

Activate your `plant_reconstruct` environment!

!!! note
    Since this is still under development, the packages are installed in "editable mode" with the `-e` option.

### Install `romicgal` sources:
To pilot the hardware you have to install the `romiscanner`package:

```bash
python3 -m pip install -e git+https://github.com/romi/romicgal.git@dev
```

!!! note
    This takes some time since it has to download dependencies (`CGAL-0.5` & `boost-1.72.0`) and compile them.

### Install `romiscan` sources:
To start "acquisition jobs", you have to install the `romiscan` package:

```bash
python3 -m pip install -e git+https://github.com/romi/romiscan.git@dev
```

### Install `romidata` sources:
Since we will need an active database to export the acquisitions, you have to install the `romidata` package:
```bash
python3 -m pip install -e git+https://github.com/romi/romidata.git@dev
```

### Install `romiseg` sources:
To install the additional segmentation module:
```bash
python3 -m pip install git+https://github.com/romi/romiseg@dev
```
!!! warning
    If not using CUDA 10.*, you have to install the matching `pytorch` distribution.
    For example, for CUDA 9.2, use:
    ```bash
    pip install torch==1.4.0+cu92 -f https://download.pytorch.org/whl/torch_stable.html
    ```


## Example database
To quickly create an example DB you can use:
```bash
wget https://db.romi-project.eu/models/test_db.tar.gz
tar -xf test_db.tar.gz
```
This will create a `integration_tests` folder with a ready to use test database. 

You should now be ready to performs "plant acquisitions" following the [dedicated](../how_to/hardware_scan.md) user guide.