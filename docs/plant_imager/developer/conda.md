Conda
=====

Recipes to build conda packages can be found [here](https://github.com/romi/conda_recipes.git).

Follow these instructions to build conda packages.

!!! warning
    Conda packages should be built from the `base` environment.
    ```shell
    conda activate base
    ```

## Requirements

### Install `conda-build`:

Install `conda-build`, in the `base` environment, to be able to build conda package:

```shell
conda install conda-build
```

**WARNING:** For macOS, follow these [instructions](https://docs.conda.io/projects/conda-build/en/latest/resources/compiler-tools.html#macos-sdk) to install the
required `macOS 10.9 SDK`.

### Optional - Install `anaconda-client`:

To be able to upload your package on anaconda cloud you need to install `anaconda-client`:

```shell
conda install anaconda-client
```

## Build conda packages:

### Build `lettucethink`:

Using the given recipe, it is easy to build the `lettucethink-python` conda package:

```shell
cd conda_recipes/
conda build lettucethink/ --user romi-eu
```

### Build `plantdb`:

Using the given recipe, it is easy to build the `plantdb` conda package:

```shell
cd conda_recipes/
conda build plantdb/ -c romi-eu -c open3d-admin --user romi-eu
```

### Build `plant3dvision`:

Using the given recipe, it is easy to build the `plant3dvision` conda package:

```shell
cd conda_recipes/
conda build plant3dvision/ -c romi-eu -c conda-forge -c open3d-admin --user romi-eu
```

### Build `romi-plantviz`:

Using the given recipe, it is easy to build the `romi-plantviz` conda package:

```shell
cd conda_recipes/
conda build romi-plantviz/ -c romi-eu -c conda-forge --user romi-eu
```

### Optional - Build `dirsync` package:

To build `dirsync` you have to install `hgsvn`:

```shell
sudo apt install hgsvn 
```

Using the given recipe, it is easy to build the `dirsync` conda package:

```shell
cd conda_recipes
conda build dirsync/recipe/ --user romi-eu
```

### Optional - Build `opencv-python` package:

To build `opencv-python` you have to install `qt4-qmake`:

```shell
sudo apt install qt4-qmake qt4-default
```

Using the given recipe, it is easy to build the `opencv-python` conda package:

```shell
cd conda_recipes
conda build opencv-python/ -c conda-forge --user romi-eu
```

## Conda useful commands:

### Purge built packages:

```shell
conda build purge
```

### Clean cache & unused packages:

```shell
conda clean --all
```
