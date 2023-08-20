Docker container for ROMI plantinterpreter
==========================================

!!! important
    An **existing local database directory is required**, it will be mounted at container startup.
    To see how to create a local database directory, look [here](/plant_imager/install/plantdb_setup/#initialize-a-romi-database).

## Use pre-built docker image

Assuming you have a valid ROMI database directory under `/data/ROMI/DB`, you can easily download and start the pre-built `roboticsmicrofarms/plant-3d-vision` docker image with:

```shell
export ROMI_DB=/data/ROMI/DB
docker run --runtime=nvidia --gpus all \
  --env PYOPENCL_CTX='0' \
  -v $ROMI_DB:/myapp/db \
  -it roboticsmicrofarms/plant-3d-vision:latest
```

This should start the latest pre-built `roboticsmicrofarms/plant-3d-vision` docker image in interactive mode.
The database location inside the docker container is `/myapp/db`.

!!! note
    `-v $ROMI_DB:/myapp/db` performs a **bind mount** to enable access to the local database by the docker image.
    See the official [documentation](https://docs.docker.com/storage/bind-mounts/).

## Build docker image

We provide a convenience bash script to ease the build of `roboticsmicrofarms/plant-3d-vision` docker image.
You can choose to use this script OR to "manually" call the `docker build` command.

### Provided convenience `build.sh` script

To build the image with the provided build script, from the root directory:

```shell
./docker/build.sh
```

You can also pass some options, use `./docker/build.sh -h` to get more details about usage, options and default values.

!!! tips 
    To be sure to always pull the latest parent image, you may add the `--pull` option!

### Manually call the `docker build` command

To build the image, from the root directory:

```shell
export VTAG="latest"
docker build -t roboticsmicrofarms/plant-3d-vision:$VTAG .
```

## Publish docker image

Push it on docker hub:

```shell
docker push roboticsmicrofarms/plantdb:$VTAG
```

This requires a valid account & token on dockerhub!

## Usage

### Requirements

To run it, you need to have a valid local ROMI database, look [here](/plant_imager/install/plantdb_setup/#initialize-a-romi-database) for instructions and [here](https://db.romi-project.eu/models/test_db.tar.gz) for an example database.

### Starting the `plant-3d-vision` docker image

#### Provided `run.sh` script

To start the container, in interactive mode, with the provided run script in `plant3dvision/docker`, use:

```shell
./run.sh
```

You can also pass some options, use `./run.sh -h` to get more details about usage and options, notably to mount a local romi database.

##### NVIDIA GPU test

To make sure the started container will be able to access the host GPU, use:

```shell
./run.sh  --gpu_test
```

##### Pipelines tests

To performs test reconstructions, you have several possibilities:

* test the geometric pipeline:
    ```shell
    ./run.sh  --geom_pipeline_test
    ```
* test the machine learning pipeline:
    ```shell
    ./run.sh  --ml_pipeline_test
    ```
* test both pipelines:
    ```shell
    ./run.sh  --pipeline_test
    ```

!!! note
    This use test data & test models (for ML) provided with `plant3dvision` in `plant3dvision/tests/testdata`.

#### Manually

Assuming you have a valid ROMI database directory under `/data/ROMI/DB`, you can start the `roboticsmicrofarms/plant-3d-vision` docker image with:

```shell
export ROMI_DB=/data/ROMI/DB
docker run --runtime=nvidia --gpus all \
  --env PYOPENCL_CTX='0' \
  -v $ROMI_DB:/myapp/db \
  -it roboticsmicrofarms/plant-3d-vision:$VTAG bash
```

This should start the built `roboticsmicrofarms/plant-3d-vision` docker image in interactive mode.
The database location inside the docker container is `~/db`.

Note that:

- you are using the docker image `roboticsmicrofarms/plant-3d-vision:$VTAG`
- you mount the host directory `$ROMI_DB` "inside" the running container in the `~/db` directory
- you activate all GPUs within the container with `--gpus all`
- declaring the environment variable `PYOPENCL_CTX='0'` select the first CUDA GPU capable
- `-it` & `bash` returns an interactive bash shell

You may want to name the running container (with `--name <my_name>`) if you "demonize" it (with `-d`).

### Executing a ROMI task

Once you are inside the running docker container, you may call the ROMI tasks.

```shell
romi_run_task AnglesAndInternodes db/<my_scan_000>/ --config plant3dvision/configs/original_pipe_0.toml
```

!!! note
    You may have to source the `.profile` file before calling `romi_run_task`.

You can give a command to execute at container start-up using the `-c, --cmd` option.
For example:

```shell
export ROMI_DB=/data/ROMI/DB
./run.sh -p $ROMI_DB -u scanner -c "source .profile && romi_run_task AnglesAndInternodes db/<my_scan_000>/ --config plant3dvision/configs/original_pipe_0.toml"
```

!!! important
    `source .profile` is important to add `.local/bin/` to the `$PATH` environment variable.
    If you don't do this, you might not be able to access the `romi_run_task` binary from bash in the docker container.
