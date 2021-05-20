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

If you upgrade from an older install, you may have to install the Python docker SDK:
```shell
conda activate plant_scanner
python -m pip install docker
```

!!!important
    Make sure you can access the docker engine as a non-root user!
    On Linux:
    
    1. Create the docker group: `$ sudo groupadd docker`
    2. Add your user to the docker group: `$ sudo usermod -aG docker $USER`
    3. Log out and log back in so that your group membership is re-evaluated.
    
    Official instructions [here](https://docs.docker.com/engine/install/linux-postinstall/)

#### B - System install
If you are a warrior or a computer expert, you can follow the procedure from the official documentation [here](https://colmap.github.io/install.html#).
Make sure to use version 3.6.

!!!note 
    If you are using a conda environment, you can install `ceres-solver` dependency for COLMAP from the conda-forge channel:
```shell
conda activate plant_scanner
conda install ceres-solver -c conda-forge
```

!!!important
    By default we use the docker mechanism, to enable the system install you need to export the environment variable `COLMAP_EXE='colmap'`.


## Install ROMI packages with `pip`:

Activate your `plant_scanner` environment!

!!! note
    Since this is still under development, the packages are installed in "editable mode" with the `-e` option.

!!!important
    You need an active ROMI database to import the images fileset to reconstruct.
    If it's not done yet, fFollow the install instructions of a ROMI database ([here](plantdb_setup.md)).

### Install `romiscan` sources:
To start "reconstruction jobs", you have to install the `romiscan` package.

Here we use the submodules but if you wish to edit other packages than `romiscan`, _e.g._ `romidata`, install them from source!
```shell
conda activate plant_scanner
git clone --branch dev https://github.com/romi/romiscan.git
cd romiscan
git submodule init
git submodule update
python3 -m pip install -r requirements.txt
python3 -m pip install ./romidata/
python3 -m pip install ./romiseg/
python3 -m pip install ./romiscanner/
python3 -m pip install ./romicgal/
python3 -m pip install -e .
```

You should now be ready to performs "plant reconstructions" following the [dedicated](../tutorials/reconstruct_scan.md) user guide.


### Install `romicgal` sources
We use some algorithms from [CGAL](https://www.cgal.org/) and propose a minimal python wrapper called `romicgal`.
To install it:

```shell
conda activate plant_scanner
python3 -m pip install -e git+https://github.com/romi/romicgal.git@master
```

!!! note
    This takes some time since it has to download dependencies (`CGAL-0.5` & `boost-1.72.0`) and compile them.


### Install `romiseg` sources
To install the additional Machine Learning based segmentation module:

```shell
conda activate plant_scanner
python3 -m pip install -e git+https://github.com/romi/romiseg@dev
```

!!! warning
    If not using CUDA 10.*, you have to install the matching `pytorch` distribution.
    For example, for CUDA 9.2, use:
    ```bash
    conda activate plant_scanner
    pip install torch==1.4.0+cu92 -f https://download.pytorch.org/whl/torch_stable.html
    ```
