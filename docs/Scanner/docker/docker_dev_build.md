# Build romicscan docker for developers

## Aim
To posses a mechanism to quickly creates docker images for testing purpose. 

## Strategy
Creates two `Dockerfiles` and associated build scripts (for convenience):

1. base: with the system dependencies and the two slowest ROMI packages to install: `romicgal` (not under active development) and `romiseg`. 
2. dev: use the base image to install the remaining ROMI libraries **in editable mode** `romidata`, `romiscan` & `romiscanner`.

Then use a convenience bash script to start a container based on the dev image & run ROMI commands. 

!!!note
    We could install the `requirements.txt` of `romiscan` to save more build time!
    
    `python -m pip install https://github.com/romi/romiscan/raw/dev/requirements.txt`


## Build
To see the available options on the build and run scripts, call for help with `-h`, *i.e.* `./build.sh -h` or `./run.sh -h`

### Building base image
To build the `roboticsmicrofarms/romiscan_base` docker image, from `romiscan/docker/base` do:
```bash
./build.sh
```


### Building dev image
Once you have built the base image, build the dev image for the branch you want to test, *e.g.* `my_branch` for the `romiscan` library:
```bash
./build.sh -t my_branch --romiscan my_branch
```

!!!info
    To help keeping tracks of docker images, we use the **branch name as tag** to build the image.
    If more than one person are testing that branch on the sam machine and your username or nickname!


### Test the built image

#### Test GPU accessibility
You can test the accessibility of you GPU to the container with:
```bash
./run.sh -t my_branch --gpu_test
```


#### Test the geometric pipeline
You can test the geometric pipeline with:
```bash
./run.sh -t my_branch --geom_pipeline_test
```


#### Test the ML pipeline
You can test the ML pipeline with:
```bash
./run.sh -t my_branch --ml_pipeline_test
```


#### Test both pipelines
You can test both pipelines with:
```bash
./run.sh -t my_branch --pipeline_test
```


#### Test geometric pipeline
```bash
./run.sh -t my_branch --ml_pipeline_test
```
!!!danger
    This can only be run on systems with more than 6Go of RAM for the GPU.


## Use

### Start container in interactive mode
```bash
./run.sh -t my_branch 
```

### Start the container and execute a ROMI task
To do execute a task on a scan dataset located on the host machine, you have to bind it to the container.
Use the `-p` or `--database_path` option to provide an **absolute** path to a valid ROMI database, *e.g.* `-p /data/ROMI/DB`.
The mounted database should be available in `~/db`.

To bind extra directories of the host to the container, use the `-v` or `--volume` option.
Note that it can be called multiple times. 
For example if you want to provide your own TOML configuration files directory, *e.g.* in `/data/ROMI/configs`, add `-v /data/ROMI/configs:/data/$USER/configs`


!!!danger
    In the volume binding example before `$USER` refers to the one use to build the base image.
    If you have built it, this should work!


If you have made some changes to the branch you are working on, add the `--update` option to update the container before passing your command.


#### Example1: run the `AnglesAndInternode` task with the ML pipeline
In this example we bind a ROMI database to the container an run the test ML pipeline from the `romiscan` sources on the `arabido_test2_ml`: 
```bash
./run.sh -t my_branch \
         -p /home/scanner/database_jcharlaix/scans_reconstructed/ \
         -c 'romi_run_task --config romiscan/config/test_ml_pipe.toml \
                           AnglesAndInternodes db/arabido_test2_ml/'
```

#### Example2: run the `AnglesAndInternode` task with the geometric pipeline & print tasks infos
To invokes mutliples commands, you can either chain the tasks with `&&` in the bash command you provides:
```bash
./run.sh -t my_branch -p /home/scanner/database_jcharlaix/scans_reconstructed/ -c 'romi_run_task --config romiscan/config/test_ml_pipe.toml AnglesAndInternodes db/arabido_test2_ml/ && print_task_info PointCloud db/arabido_test2_ml/ && print_task_info AnglesAndInternodes db/arabido_test2_ml/'
```
This wil run the three commands (there could be more) in the same container.

Or makes multiples calls to the `run.sh` script:
```bash
./run.sh -t my_branch -p /home/scanner/database_jcharlaix/scans_reconstructed/ -c 'romi_run_task --config romiscan/config/test_ml_pipe.toml AnglesAndInternodes db/arabido_test2_ml/'
./run.sh -t my_branch -p /home/scanner/database_jcharlaix/scans_reconstructed/ -c 'print_task_info PointCloud db/arabido_test2_ml/'
./run.sh -t my_branch -p /home/scanner/database_jcharlaix/scans_reconstructed/ -c 'print_task_info AnglesAndInternodes db/arabido_test2_ml/'
```
This will creates multiples containers, one for each call, but they should be automatically removed.

#### Example3: Update the ROMI libraries before testing both pipelines
The TOML configuration files used to performs the tests are:
* `romiscan/config/test_geom_pipe.toml`: geometric oriented configuration
* `romiscan/config/test_ml_pipe.toml`: machine learning oriented configuration

```bash
./run.sh -t my_branch --pipeline_test --update
``` 


## Command line script details

### Build base image
```
USAGE:
  ./build.sh [OPTIONS]
    
DESCRIPTION:
  Build a base docker image named 'roboticsmicrofarms/romiscan_base' using Dockerfile in same location.
    
OPTIONS:
  -t, --tag
    Docker image tag to use, default to 'latest'.
  -u, --user
    User name to create inside docker image, default to '$USER'.
  --uid
    User id to use with 'user' inside docker image, default to '$(id -u)'.
  -g, --group
    Group name to create inside docker image, default to '$(id -g -n)'.
  --gid
    Group id to use with 'user' inside docker image, default to '$(id -g)'.
  --romicgal
    Git branch to use for cloning 'romicgal' inside docker image, default to 'master'.
  --romiseg
    Git branch to use for cloning 'romiseg' inside docker image, default to 'dev'.
  --no-cache
    Do not use cache when building the image, (re)start from scratch.
  --pull
    Always attempt to pull a newer version of the parent image.
  -h, --help
    Output a usage message and exit.
```

### Build dev image
```
USAGE:
  ./build.sh [OPTIONS]
    
DESCRIPTION:
  Build a docker image named 'roboticsmicrofarms/romiscan_dev' using Dockerfile in same location.
    
OPTIONS:
  -t, --tag
    Docker image tag to use, default to 'latest'.
  --romidata
    Git branch to use for cloning 'romiscan' inside docker image, default to 'dev'.
  --romiscan
    Git branch to use for cloning 'romiscan' inside docker image, default to 'dev'.
  --romiscanner
    Git branch to use for cloning 'romiscan' inside docker image, default to 'dev_lyon'.
  -nc, --no-cache
    Do not use cache when building the image, (re)start from scratch.
  --pull
    Always attempt to pull a newer version of the parent image.
  -h, --help
    Output a usage message and exit.
```

### Run dev image
```
USAGE:
  ./run.sh [OPTIONS]
    
DESCRIPTION:
  Run 'roboticsmicrofarms/romiscan_dev:<vtag>' container with a mounted local (host) database.
    
OPTIONS:
  -t, --tag
    Docker image tag to use, default to 'latest'.
  -p, --database_path
    Path to the host database to mount inside docker container, requires '--user' if not default.
  -u, --user
    User used during docker image build, default to 'jonathan'.
  -v, --volume
    Volume mapping for docker, e.g. '/abs/host/dir:/abs/container/dir'. Multiple use is allowed.
  --update
    Update the git branches for ROMI repositories before running the command.
  -c, --cmd
    Defines the command to run at docker startup, by default start an interactive container with a bash shell.
 --unittest_cmd
    Runs unit tests defined in romiscan.
  --pipeline_test
    Test pipelines (geometric & ML based) in docker container with CI test.
  --geom_pipeline_test
    Test geometric pipeline in docker container with CI test & test dataset.
  --ml_pipeline_test
    Test ML pipeline in docker container with CI test & test dataset.
  --gpu_test
    Test correct access to NVIDIA GPU resources from docker container.
  -h, --help
    Output a usage message and exit.
```