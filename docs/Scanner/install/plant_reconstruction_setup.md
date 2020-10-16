Install ROMI software for plants reconstruction
===============================================

To follows this guide you should have an existing `conda` or a Python `venv`, see [here](create_env.md).

We prefers to use conda and will use examples command lines with it.
Simply replace the `conda activate plant_scanner` commands with `source plant_scanner/bin/activate`.

For the sake of clarity the environment will be called `plant_scanner`.


## Requirements:

### COLMAP
To save you the hassle of installing COLMAP & its dependencies, we wrote a mechanism allowing you to run the COLMAP command straight into a docker container where its already done!

!!!note
    Choose between option A (recommended) OR B! 

#### A - Use of docker image
You can use a pre-built docker image with COLMAP & its dependencies installed (named `geki/colmap`).
This require to install the docker-engine.
To do so, follows the official instructions here: https://docs.docker.com/get-docker/

It uses the Python docker SDK `docker` available on [PyPi](https://pypi.org/project/docker/), to learn more read the [official](https://docker-py.readthedocs.io/en/stable/) documentation.

If you upgrade from an older install:
```bash
conda activate plant_scanner
python -m pip install docker
```

#### B - System install
If you are a warrior or a computer expert, you can follow the procedure from the official documentation [here](https://colmap.github.io/install.html#).
Make sure to use version 3.6.

!!!note 
    If you are using a conda environment, you can install `ceres-solver` dependency for COLMAP from the conda-forge channel:
```bash
conda activate plant_scanner
conda install ceres-solver -c conda-forge
```

!!!important
    By default we use the docker mechanism, to enable the system install you need to export the environment variable `COLMAP_EXE='colmap'`.

### OpenCL
Official documentation [here](https://documen.tician.de/pyopencl/).. GOOD LUCK!

!!!warning
    These instructions require EXTRA ATTENTION from the developers as they changed many time & differs from those used in the romiscan `Dockerfile`!

!!!note
    Why don't we use `pyopencl` from conda or PyPi ? From the official doc:
    > By far the easiest way to install PyOpenCL is to use the packages available in Conda Forge.

You have to install `pyopencl` from source, and configure it to use OpenCL 1.2 (NVIDIA does not support the default OpenCL 2.0).

First, make sure you have python headers installed, on ubuntu:
```bash
sudo apt install python3.7-dev
```

To install `pyopencl` from source:
```bash
conda activate plant_scanner
git clone https://github.com/inducer/pyopencl
cd pyopencl
git submodule update --init
pip install pybind11
python -m pip install .
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

Activate your `plant_scanner` environment!

!!! note
    Since this is still under development, the packages are installed in "editable mode" with the `-e` option.

!!!important
    You need an active ROMI database to import the images fileset to reconstruct.
    If it's not done yet, fFollow the install instructions of a ROMI database ([here](romidb_setup.md)).

### Install `romicgal` sources:
We use some algorithms from [CGAL](https://www.cgal.org/) and propose a minimal python wrapper called `romicgal`.
To install it:

```bash
conda activate plant_scanner
python3 -m pip install -e git+https://github.com/romi/romicgal.git@dev
```

!!! note
    This takes some time since it has to download dependencies (`CGAL-0.5` & `boost-1.72.0`) and compile them.

### Install `romiscan` sources:
To start "reconstruction jobs", you have to install the `romiscan` package:

```bash
conda activate plant_scanner
git clone --branch dev https://github.com/romi/romiscan.git
python3 -m pip install -r romiscan/requirements.txt
python3 -m pip install -e romiscan/.
```

You should now be ready to performs "plant reconstructions" following the [dedicated](../tutorials/reconstruct_scan.md) user guide.

### Install `romiseg` sources:
To install the additional Machine Learning based segmentation module:
```bash
conda activate plant_scanner
python3 -m pip install git+https://github.com/romi/romiseg@dev
```

!!! warning
    If not using CUDA 10.*, you have to install the matching `pytorch` distribution.
    For example, for CUDA 9.2, use:
    ```bash
    conda activate plant_scanner
    pip install torch==1.4.0+cu92 -f https://download.pytorch.org/whl/torch_stable.html
    ```
