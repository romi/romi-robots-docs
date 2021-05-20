Install ROMI software for virtual plants acquisition & reconstruction
=====================================================================

To follows this guide you should have a `conda` or a Python `venv`, see [here](create_env.md).

For the sake of clarity the environment will be called `virtual_plants`.

## Notice for using the virtual scanner

If you want to use the virtual scanner, the modified python version bundled with `blender` and the environment python version have to match.

To obtain the python version bundled with your distribution of blender, type:

```shell
blender -b --python-expr "import sys; print(sys.version)"
```

It will output something like:

```
Blender 2.82 (sub 7) (hash 5b416ffb848e built 2020-02-14 16:19:45)
ALSA lib pcm_dmix.c:1089:(snd_pcm_dmix_open) unable to open slave
3.8.1 (default, Jan 22 2020, 06:38:00) 
[GCC 9.2.0]

Blender quit
```

In this case, this means Blender bundle Python 3.8, and you should too.

In the following, we will assume that you are using conda environments. If not, adapt with corresponding virtualenv commands.

## Install ROMI packages with `pip`:

Activate your `virtual_plants` environment!

!!! note
    Since this is still under development, the packages are installed in "editable mode" with the `-e` option.

### Install `openalea.lpy`

If you're using `python>=3.7` and `conda`, just install `lpy` from conda:

```shell
conda install -c conda-forge -c fredboudon openalea.lpy
```

### Install `romicgal` sources

To pilot the hardware you have to install the `plantimager`package:

```shell
python3 -m pip install -e git+https://github.com/romi/romicgal.git@dev
```

!!! note
    This takes some time since it has to download dependencies (`CGAL-0.5` & `boost-1.72.0`) and compile them.

### Install `plant3dvision` sources

To start "acquisition jobs", you have to install the `plant3dvision` package:

```shell
python3 -m pip install -e git+https://github.com/romi/plant3dvision.git@dev
```

### Install `plantdb` sources

Since we will need an active database to export the acquisitions, you have to install the `plantdb` package:

```shell
python3 -m pip install -e git+https://github.com/romi/plantdb.git@dev
```

### Install `romiseg` sources

To install the additional segmentation module:

```shell
python3 -m pip install git+https://github.com/romi/romiseg@dev
```

!!! warning
    If not using CUDA 10.*, you have to install the matching `pytorch` distribution. For example, for CUDA 9.2, use:
    ```shell
    pip install torch==1.4.0+cu92 -f https://download.pytorch.org/whl/torch_stable.html
    ```

## Example database

To quickly create an example DB you can use:

```shell
wget https://db.romi-project.eu/models/test_db.tar.gz
tar -xf test_db.tar.gz
```

This will create a `integration_tests` folder with a ready to use test database.

You should now be ready to perform tasks on virtual plants such as "creation", "acquisition" & "reconstruction" following the [dedicated](../tutorials/virtual_plant_imager_single_dataset.md) user guide.