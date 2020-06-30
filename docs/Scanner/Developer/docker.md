Docker containers for ROMI
==========================

## List of docker containers

We hereafter list the docker containers, their use and list the installed libraries:

Progress:
 - [ ] DB
 - [ ] Scanner
 - [ ] SmartInterpreter
 - [ ] VirtualScanner
 - [x] Visualizer


## Database
!!! warning
    This is not working YET, but almost!

### Aim & design
This container does not contain any data or database, only the installed libraries required to run it.

An **existing local database** is required, it will be mounted at container startup.


### Build docker image
To build the image, from the `romidata` root directory, run:
```bash
export VTAG="latest"
docker build -t roboticsmicrofarms/romidb:$VTAG .
```

To run it, you need to have a local database first, look [here](https://db.romi-project.eu/models/test_db.tar.gz) for an example.

Assuming you extracted it in your home folder (`/home/$USER/integration_tests`), you can start the `romidb` docker image with:
```bash
docker run -it -p 5000:5000 -v /home/$USER/integration_tests:/home/romi/integration_tests romidb:$VTAG
```
Once it's up, you should be able to access the REST API here: http://localhost:5000/

For example to get a list of the scans: http://localhost:5000/scans

!!! note
    `-v /home/$USER/integration_tests:/home/romi/integration_tests` performs a **bind mount** to enable access to the local database by the docker image. See the official [documentation](https://docs.docker.com/storage/bind-mounts/).

Push it ot docker hub:
```bash
docker push roboticsmicrofarms/romidb:$VTAG
```
This require a valid account & token on docker hub!

### Use pre-built docker image
First you need to pull the docker image:
```bash
docker pull roboticsmicrofarms/romidb:$VTAG
```
Then you can run it with:
```bash
docker run -it -p 3000:3000 roboticsmicrofarms/romidb:$VTAG
```

!!! note
    ROMI does not have a docker repo yet!


## Scanner
The database container. 

#### Aim
Gather the acquired images, reconstructed plants architectures & quantitative data

```docker
FROM continuumio/miniconda3
```

#### Dependencies:

Internal dependencies:
 - `data-storage`, the database API, as well as classes for data processing using luigi.

External dependencies:
 - `lettucethink-python`, python tools and controllers for the `lettucethink` robot.


## SmartInterpreter
The reconstruction and quantification container.

#### Aim
Gather the algorithms and processing pipelines to extract quantitative biological information on plants architecture from a set of photo acquisition.

```docker
FROM colmap/colmap
```

#### Dependencies:

Internal dependencies:
 - `data-storage`, the database API, as well as classes for data processing using luigi.
 - `Segmentation`, virtual plant segmentation methods using 2D images generated from the virtual scanner and neural networks.
 - `cgal_bindings_skeletonization`, Python CGAL bindings for skeletonization.
 - `Scan3D`, the elements used to run 3D scan of individual plants.

External dependencies:
 - `Open3D` is mostly used for IO and data structures.
 - `Colmap` is used for _Structure From Motion_ reconstruction.
 - `cgal` is used for skeletonization. TO REMOVE ?!


## VirtualScanner
The virtual scanner container.

#### Aim
Gather the tools to create virtual plants and render realistic snapshots.

```docker
FROM alpine:3.10
```

#### Dependencies:

Internal dependencies:
 - `data-storage`, the database API, as well as classes for data processing using luigi.

External dependencies:
 - `blender`
 - `lpy`

## 3D Plantviewer
The plant visualizer is a webapp that dialog with the database to display images & some quantitative traits.

It is based on Ubuntu 18.04.

Note that we tag the different versions, the default is to use the latest, but you can also specify a specific version by changing the value of the environment variable `$VTAG`, *e.g.* `export VTAG="2.1"`.
Look here for a list of available tags: https://hub.docker.com/repository/docker/roboticsmicrofarms/plantviewer

#### Build docker image
To build the image, from the `3d-plantviewer` root directory, run:
```bash
export VTAG="latest"
docker build -t roboticsmicrofarms/plantviewer:$VTAG .
```
To start the container using the built image:
```bash
docker run -p 3000:3000 roboticsmicrofarms/plantviewer:$VTAG
```
Once it's up and running, you should be able to access the viewer using a browser here: http://localhost:3000/

!!! note
    If you omit the `-p 3000:3000` you can still access the interface using the docker ip, something like http://172.17.0.2:3000/

!!! important
    Use `chrome` as `firefox` has some issues with the used JavaScript libraries!

To push it on the `roboticsmicrofarms` docker hub:
```bash
docker push roboticsmicrofarms/plantviewer:$VTAG
```
This require a valid account and token on docker hub!

#### Use pre-built docker image
First you need to pull the docker image:
```bash
docker pull roboticsmicrofarms/plantviewer:$VTAG
```
Then you can run it with:
```bash
docker run -p 3000:3000 roboticsmicrofarms/plantviewer:$VTAG
```

!!! note
    You can execute the "run command" without pulling the image first, it will do it before running the container!

### Docker compose
To use a local database, for testing or development, we provide a docker compose recipe that:

1. start a database container using `roboticsmicrofarms/romidb`
2. start a plantviewer container using `roboticsmicrofarms/plantviewer`

!!!note
    You need `docker-compose` installed, see [here](https://docs.docker.com/compose/install/).

#### Use pre-built docker image
From the directory containing the `docker-compose.yml` in a terminal:
```bash
export ROMI_DB=<path/to/db>
docker-compose up -d 
```
!!! important
    Do not forget to set the path to the database.
!!! warning
    If you have other containers running it might not work since it assumes the romidb container will have the `172.21.0.2` IP address!

To stop the containers: 
```bash
docker-compose stop
```

#### Use local builds
To use local builds for development or debugging purposes:

1. build your image following the instructions above and use a specific tag like `debug`
2. edit the `docker-compose.yml` file to add the previously defined tag to the name of the image to start



## DockerHub

### roboticsmicrofarms
The Docker hub repository for the ROMI project is here: https://hub.docker.com/orgs/roboticsmicrofarms

### Colmap

Docker images for the COLMAP open source project:

[https://hub.docker.com/r/colmap/colmap](https://hub.docker.com/r/colmap/colmap)

nvidia/cuda with colmap - (compatible with Driver Version: 418.67 CUDA Version: 10.1) 

[https://hub.docker.com/r/geki/colmap](https://hub.docker.com/r/geki/colmap)
