Docker container for ROMI plantinterpreter
==========================================


## romiscan docker

!!! warning
    No `romiscan` docker image is available yet from `roboticsmicrofarms` docker hub repository since it is still under development and super heavy ~9 Go !! So you have to build it locally.

### Local build
To enable read/write access, it is required to modify the Dockerfile to generate an image with the correct user name, uid & gid.

Then we use arguments (`SETUSER`, `USER_ID` & `GROUP_ID`) with docker image `build` command:
```bash
docker build -t romiscan:<tag> --build-arg USER_NAME=$USER --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) .
```

Don't forget to change the `<tag>` to a version (*e.g.* 'v0.6') or explicit name (*e.g.* 'fix_colmap') of your choosing!

!!! warning
    This rely on NVIDIA CUDA technology so you need an NVIDIA GPU that is CUDA capable. Moreover, if you don't have CUDA 10.2 driver installed, ou will have to change the base container (colmap/colmap by default) to match your version (or update your drivers if possible).

To test correct access to NVIDIA GPU resources from built image:
```bash
docker run -it --gpus all romiscan:0.7 nvidia-smi
```

### Run test procedure
To start the `romiscan:0.7` docker container and run the automatic test defined in `romiscan/tests/check_pipe.sh`:
```bash
docker run --runtime=nvidia --gpus all \
    -it romiscan_dev:0.7 \
    --env PYOPENCL_CTX='0' \
    bash -c 'cd romiscan/tests/ && ./check_pipe.sh'
``` 

### Start container in interactive mode
It is also possible to use this container to performs "reconstruction tasks" as you would with a local install on your machine.
To start the `romiscan:0.7` docker container and access a `bash` terminal as `romi` user:
## Starting the container

To start the docker container in interactive mode:
```bash
docker run -it \
    -v /host/database:/home/$USER/db \
    -v /host/configs/:/home/$USER/config/ \
    --env PYOPENCL_CTX='0' \
    --gpus all romiscan:0.7 bash
```

Note that:

- you are using the docker image `romiscan:0.7`
- you mount the host directory `/host/database` "inside" the running container in the `~/db` directory
- you mount the host directory `/host/configs` "inside" the running container in the `~/config` directory
- you activate all GPUs within the container with `--gpus all`
- declaring the environment variable `PYOPENCL_CTX='0'` select the first CUDA GPU capable
- `-it` & `bash` returns an interactive bash shell

You may want to name the running container (with `--name <my_name>`) if you "deamonize" it (with `-d`).

### Run ROMI reconstruction tasks
You can now call "romi reconstruction tasks" within the running docker container.
For example, to run the full *geometric pipeline* on the "real dataset example" named `2019-02-01_10-56-33`:
```bash
romi_run_task AnglesAndInternodes ~/db/2019-02-01_10-56-33 \
    --config ~/config/original_pipe_0.toml
```

You may want to "clean" the dataset first:
```bash
romi_run_task Clean ~/db/2019-02-01_10-56-33 \
    --config ~/config/original_pipe_0.toml
```

## CI docker images
To speed-up the continuous integration tests (very long docker build) we offers two solutions:

1. Use a base image with all the system requirement installed, then build the `romiscan` module & its (git) submodules (`romidata`, `romiseg`, `romiscanner` & `romicgal`)
2. Use a base image with all the system requirement installed AND `romiseg` (longest package to install & currently not under development) & `romicgal` (currently not under development), then build the `romiscan` module & its ROMI dependencies (`romidata`, `romiscanner` )


### Solution #1 - `romiscan_base` + `romiscan_ci`

#### Build `romiscan_base`
Assuming your `romiscan_base` image tag is `0.7`, in a terminal, from the `romiscan/docker/` directory, it should look like this:
```bash
docker build -t roboticsmicrofarms/romiscan_base:0.7 --build-arg USER_NAME=$USER --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) base/.
```

#### Upload `romiscan_base` to roboticsmicrofarms
To push the built image on the roboticsmicrofarms docker hub:
```bash
docker push roboticsmicrofarms/romiscan_base:0.7
```

#### CI tests with `romiscan_ci` Dockerfile
Use the previously built & uploaded image in your `Dockerfile` recipe for `romiscan_ci` image:
```dockerfile
FROM roboticsmicrofarms/romiscan_base:0.7

...
```
Use this `Dockerfile` in github CI actions.


### Solution #2 - `romiscan_base-dev` + `romiscan_ci-dev`

#### Build `romiscan_base-dev`
Assuming your `romiscan_base-dev` image tag is `0.7`, it should look like this:
```bash
docker build -t roboticsmicrofarms/romiscan_base-dev:0.7 --build-arg USER_NAME=$USER --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) base-dev/.
```

#### Upload `romiscan_base-dev` to roboticsmicrofarms
To push the built image on the roboticsmicrofarms docker hub:
```bash
docker push roboticsmicrofarms/romiscan_base-dev:0.7
```

#### CI tests with `romiscan_ci-dev` Dockerfile
Use the previously built & uploaded image in your `Dockerfile` recipe for `romiscan_ci-dev` image in github CI actions:
```dockerfile
FROM roboticsmicrofarms/romiscan_base-dev:0.7
```

Example `build` command from `romiscan/docker` directory:

* specify a branch for `romiscan` git repository with the `ROMISCAN_BRANCH` build argument:
    ```bash
    docker build -t romiscan_ci-dev:debug --build-arg ROMISCAN_BRANCH=feature/faster_docker ci-dev/.
    ```

* specify a branch for `romidata` git repository with the `ROMIDATA_BRANCH` build argument:
    ```bash
    docker build -t romiscan_ci-dev:test --build-arg ROMIDATA_BRANCH=dev ci-dev/.
    ```

* specify a branch for `romiscanner` git repository with the `ROMISCANNER_BRANCH` build argument:
    ```bash
    docker build -t romiscan_ci-dev:fix --build-arg ROMISCANNER_BRANCH=fix/urlcam ci-dev/.
    ```

Note that you can use all three `--build-arg` definitions in the same `build` call!

## Example use of 'ci*' docker images:

### Test the installed packages with `check_pipe.sh`
```bash
docker run --runtime=nvidia --gpus all \
    --env PYOPENCL_CTX='0' \
    -it roboticsmicrofarms/romiscan_ci-dev:fix \
    bash -c 'source .profile && cd romiscan/tests/ && ./check_pipe.sh'
```

!!!important
    `source .profile` is important to add `.local/bin/` to the `$PATH` environment variable.
    If you don't do this, you might not be able to access the `romi_run_task` binary from bash in the docker container.

### Use it with a local database
```bash
docker run --runtime=nvidia --gpus all \
    -v </host/database>:/home/<docker_user>/db \
    --env PYOPENCL_CTX='0' \
    -it roboticsmicrofarms/romiscan_ci-dev:fix \
    bash -c 'source .profile && romi_run_task AnglesAndInternodes $DB_LOCATION/<my_scan>  '
```

!!!warning
    Do not forget to change:
    
    * `</host/database>` to the root directory of your ROMI database (the one with the `romidb` file)
    * `<docker_user>` to the user defined during docker image creation (using `--build-arg USER_NAME=$USER`), set to "romi" by default
    * `<my_scan>` the dataset to reconstruct


## Colmap docker

Assuming you are in the test database folder, you can test a colmap docker image as follows:
```bash
docker run --gpus all -it \
    -w /db_test -v `pwd`:/db_test \
    colmap/colmap bash
``` 

If you want to provide the path to the images directory, replace `pwd` by the path.

Then inside the running container you can test a colmap command such as:
```bash
colmap feature_extractor \
    --image_path 2019-02-01_10-56-33/images/ \
    --database_path colmap_test.db \
    --SiftExtraction.use_gpu 1
```
