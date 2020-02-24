Reconstruction
==============

Follow this procedure to install requirements to reconstruct plants acquired using the 3D scanner.


## Install requirements
We advise to create a conda or virtual environment.

### A - Create a virtual environment
```bash
virtualenv -p /usr/bin/python3.7 scan3d && source reconstruct3d/bin/activate
```

### B - Create a conda environment:
```bash
conda create -n reconstruct3d python>=3.7
conda activate reconstruct3d
```

### Install `colmap`:

1. Clone the sources:
    ```bash
    git clone https://github.com/colmap/colmap
    ```

2. Install requirements:
    ```bash
    sudo apt-get install \
        git \
        cmake \
        build-essential \
        libboost-program-options-dev \
        libboost-filesystem-dev \
        libboost-graph-dev \
        libboost-regex-dev \
        libboost-system-dev \
        libboost-test-dev \
        libeigen3-dev \
        libsuitesparse-dev \
        libfreeimage-dev \
        libgoogle-glog-dev \
        libgflags-dev \
        libglew-dev \
        qtbase5-dev \
        libqt5opengl5-dev \
        libcgal-dev
    ```

#### OPTIONAL - Fix CMake configuration scripts of CGAL
Under Ubuntu 16.04/18.04 the CMake configuration scripts of CGAL are broken and you must also install the CGAL Qt5 package:

```bash
sudo apt-get install libcgal-qt5-dev
```

#### Install Ceres Solver:

1. Install _Ceres Solver_ requirements:
    ```bash
    sudo apt-get install libatlas-base-dev libsuitesparse-dev
    ```
2. Clone the sources:
    ```bash
    git clone https://ceres-solver.googlesource.com/ceres-solver
    ```
3. Checkout the latest tagged release:
    ```bash
    cd ceres-solver
    git checkout $(git describe --tags)
    ```
4. Compile the sources:
    ```bash
    mkdir build
    cd build
    cmake .. -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF
    make -j
    make install
    ```


#### Configure and compile COLMAP:
1. Clone the sources:
    ```bash
    git clone https://github.com/colmap/colmap.git
    ```
2. Checkout the `dev` branch:
    ```bash
    cd colmap
    git checkout dev
    ```
3. Compile and install COLMAP:
    ```bash
    mkdir build
    cd build
    ```
   To install system-wide (add `sudo` to `make install`):
    ```bash
    cmake ..
    ```
   In a conda environment, do:
    ```bash
   cmake .. -DCMAKE_INSTALL_PREFIX=${CONDA_PREFIX}
    ```
4. Compile and install COLMAP:
    ```bash
    make -j
    make install
    ```

Troubleshooting:
```bash
  - Ceres_DIR=<my_ceres_dir> \
  - PROFILING_ENABLED=OFF \
  - TESTS_ENABLED=OFF
```


### Optional - Use NVIDIA for OpenCL
If you want to use NVIDIA for OpenCL in the processing pipeline, install `pyopencl` from source, and configure it to use OpenCL 1.2 (NVIDIA does not
support the default OpenCL 2.0).

First, make sure you have python headers installed, on ubuntu:
```bash
sudo apt install python3.7-dev opencl-headers
```

Then install `pyopencl` from source, and configure it to use OpenCL 1.2:
1. Clone the sources:
    ```bash
    git clone https://github.com/inducer/pyopencl
    ```
2. Install dependencies:
    ```bash
    cd pyopencl
    git submodule update --init
    pip install pybind11 mako
    ```
3. Configure and install `pyopencl` to use OpenCL 1.2:
    ```bash
    ./configure.py --cl-pretend-version=1.2 # NVIDIA has bad OpenCL support and only provides OpenCL 1.2
    python setup.py install
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


### Install ROMI packages:

!!! info
    To install directly using `pip`, you need `ssh` access to the ROMI repository on GitHub!

1. Install `romidata`:
    ```bash
    pip install git+https://github.com/romi/data-storage.git@dev
    ```

2. Install `lettucethink`:
    ```bash
    pip install git+https://github.com/romi/lettucethink-python@dev
    ```

3. Install `Scan3D`:
    ```bash
    pip install git+https://github.com/romi/Scan3D@dev
    ```