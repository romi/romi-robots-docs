# Docker for plant-3d-vision

## Prerequisites

Follow the [getting started with docker](index.md#getting-started-with-docker) instructions to install the required software.

!!! important
    We advise to assign an **existing local database directory** to `$ROMI_DB`, it will be mounted at container startup.
    To see how to create a local database directory, look [here](/plant_imager/install/plantdb_setup/#initialize-a-romi-database).

## Start a container

Assuming you have a valid ROMI database directory under `/data/ROMI/DB`, you can easily download and start the
pre-built `roboticsmicrofarms/plant-3d-vision` docker image with one of the following command:

=== "run.sh & `ROMI_DB`"
    From the root directory of the repository, use the convenience `run.sh` script:
    ```shell
    export ROMI_DB=/data/ROMI/DB
    ./docker/run.sh
    ```
=== "run.sh & `-db`"
    From the root directory of the repository, use the convenience `run.sh` script:
    ```shell
    ./docker/run.sh -db /data/ROMI/DB
    ```
=== "docker run"
    From any directory, use the `docker run` command as follows:
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
    - `-v $ROMI_DB:/myapp/db` performs a **bind mount** to enable access to the local database by the docker image.
    See the official [documentation](https://docs.docker.com/storage/bind-mounts/).
    - Use `./docker/run.sh -h` to get all details about how to use it.

## Build a docker image

If you do not wish to use one of the `roboticsmicrofarms/plant-3d-vision` pre-built image, you may build an image using
the `docker/Dockerfile` recipe accessible in the repository of `plant-3d-vision`.

We provide a convenience bash script to ease the build of `roboticsmicrofarms/plant-3d-vision` docker image.
You can choose to use this script OR to "manually" call the `docker build` command.

=== "build.sh"
    From the root directory of the repository, use the convenience `build.sh` script:
    ```shell
    ./docker/build.sh
    ```

=== "docker build"
    From the root directory of the repository, use the `docker build` command as follows:
    ```shell
    export VTAG="latest"
    docker build -t roboticsmicrofarms/plant-3d-vision:$VTAG .
    ```

!!! tips
    - By default, the image tag is 'latest', you can change it, _e.g._ to 'dev' with `-t dev`.
    - Use `./docker/build.sh -h` to get all details about how to use it.

You may want to **clean the build cache**, at least from time to time, with:
```shell
docker builder prune -a
```


## Publish docker image

To push a newly built image on docker hub:

```shell
export VTAG="latest"
docker push roboticsmicrofarms/plantdb:$VTAG
```

This requires a valid account & token on dockerhub!

## Example usage

### NVIDIA GPU test

To make sure the host GPU will be accessible from the container, use:

```shell
./docker/run.sh  --gpu_test
```

### Pipelines tests

To performs test reconstructions, you have several possibilities:

- test the **geometric pipeline**, with:
  ```shell
  ./docker/run.sh  --geom_pipeline_test
  ```
- test the **machine learning pipeline**, with:
  ```shell
  ./docker/run.sh  --ml_pipeline_test
  ```
- test **both pipelines**, with:
  ```shell
  ./docker/run.sh  --pipeline_test
  ```

!!! note
    This use test data & test models (for ML) provided with `plant3dvision` in `plant3dvision/tests/testdata`.

### Executing a ROMI task

To call a ROMI task, as defined in the `romitask` library, you should use the `romi_run_task` CLI.

For example to reconstruct a plant, named `<my_scan>`, using the **geometric pipeline** and to estimate the angles and internodes, you may use the following command:
```shell
romi_run_task AnglesAndInternodes \
  /myapp/db/<my_scan>/ \
  --config plant-3d-vision/configs/geom_pipe_real.toml
```

You can use it two ways:
1. start a container using the `roboticsmicrofarms/plant-3d-vision` image, then call the ROMI tasks.
2. use it with the `-c` option of the `run.sh` script or with `docker run`.

!!! note
    You may have to source the `.profile` file before calling `romi_run_task`.

!!! important
    `source .profile` is important to add `.local/bin/` to the `$PATH` environment variable.
    If you don't do this, you might not be able to access the `romi_run_task` binary from bash in the docker container.
