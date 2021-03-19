Docker container for ROMI database
==================================

!!!important
    An **existing local database directory is required**, it will be mounted at container startup.
    To see how to create a local database directory, look [here](../install/plantdb_setup.md#initialize-a-romi-database).


## Use pre-built docker image
Assuming you have a valid ROMI database directory under `/data/ROMI/DB`, you can easily download and start the pre-built `romidb` docker image with:
```bash
export ROMI_DB=/data/ROMI/DB
docker run -it -p 5000:5000 \
  -v $ROMI_DB:/home/scanner/db \
  roboticsmicrofarms/romidb:latest
```
And should be able to access it here: http://localhost:5000/

!!! note
    `-v $ROMI_DB:/home/scanner/db` performs a **bind mount** to enable access to the local database by the docker image. See the official [documentation](https://docs.docker.com/storage/bind-mounts/).


## Build docker image
We provides a convenience bash script to ease the build of `romidb` docker image.
You can choose to use this script OR to "manually" call the `docker build` command.

### Provided convenience `build.sh` script
To build the image with the provided build script, from the `romidata/docker` directory:
```bash
./build.sh
```
You can also pass some options, use `./build.sh -h` to get more details about usage, options and default values.


### Manually call the `docker build` command
To build the image, from the `romidata` root directory:
```bash
export VTAG="latest"
docker build -t roboticsmicrofarms/romidb:$VTAG .
```

You can use the following optional arguments:

* `--build-arg USER_NAME=<user>`: change the default user in container;
* `--build-arg ROMIDATA_BRANCH=<git_branch>`: change the cloned git branch from `romidata`.


## Publish docker image
Push it on docker hub:
```bash
docker push roboticsmicrofarms/romidb:$VTAG
```
This require a valid account & token on dockerhub!


## Usage

### Requirements
To run it, you need to have a valid local ROMI database, look [here](../install/romidb_setup/#initialize-a-romi-database) for instructions and [here](https://db.romi-project.eu/models/test_db.tar.gz) for an example database.


### Starting the `romidb` docker image

#### Provided `run.sh` script
To start the container with the provided run script in `romidata/docker`, use:
```bash
./run.sh
```
You can also pass some options, use `./run.sh -h` to get more details about usage and options.


#### Manually
Assuming you extracted it in your home folder (`/home/$USER/integration_tests`), you can start the `romidb` docker image with:
```bash
docker run -it -p 5000:5000 -v /home/$USER/integration_tests:/home/scanner/db romidb:$VTAG
```


In both cases, you should see something like:
```
n scans = 2
 * Serving Flask app "romi_scanner_rest_api" (lazy loading)
 * Environment: production
   WARNING: This is a development server. Do not use it in a production deployment.
   Use a production WSGI server instead.
 * Debug mode: off
 * Running on http://0.0.0.0:5000/ (Press CTRL+C to quit)
```

!!! tip
    `-v /home/$USER/integration_tests:/home/scanner/db` performs a **bind mount** to enable access to the local database by the docker image. See the official Docker [documentation](https://docs.docker.com/storage/bind-mounts/).

### Accessing the REST API
Once it's up, you should be able to access the REST API here: http://localhost:5000/

To access the REST API, open your favorite browser and use URLs to access:

* the list of all scans: http://0.0.0.0:5000/scans
* the '2018-12-17_17-05-35' dataset: http://0.0.0.0:5000/scans/2018-12-17_17-05-35

You should see JSON formatted text.

