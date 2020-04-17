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


## romidb
```docker
FROM ubuntu:18.04
```

!!! warning
    This is not working YET, but almost!

#### Build docker image
To build the image, clone the ROMI `docker` repository:
```bash
git clone https://github.com/romi/docker.git
cd docker
```
Then you can build the image with:
```bash
docker docker build -t romidb romiDB/
```
To run it, you need to have a local database first, look [here](https://db.romi-project.eu/models/test_db.tar.gz) for an example.
Assuming you extracted it in your home folder (`/home/$USER/integration_tests`), you can start the `romidb` docker image with:
```bash
docker run -it -p 5000:5000 -v /home/$USER/integration_tests:/home/romi/integration_tests romidb
```
Once it's up, you should be able to access the REST API here: http://localhost:5000/

For example to get a list of the scans: http://localhost:5000/scans

!!! note
    `-v /home/$USER/integration_tests:/home/romi/integration_tests` performs a **bind mount** to enable access to the local database by the docker image. See the official [documentation](https://docs.docker.com/storage/bind-mounts/).

Push it ot docker hub:
```bash
docker push jlegrand62/romi_database:latest
```
This require a valid account, token and existing repository (`romi_database`) on docker hub!

#### Use pre-built docker image
First you need to pull the docker image:
```bash
docker pull jlegrand62/romi_database
```
Then you can run it with:
```bash
docker run -it -p 3000:3000 jlegrand62/romi_database
```

!!! note
    ROMI does not have a docker repo yet!


### Scanner
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


### SmartInterpreter
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


### VirtualScanner
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

### plantviewer
The plant visualizer is a webapp that dialog with the database to display images & some quantitative traits.

```docker
FROM ubuntu:18.04
```

#### Build docker image
To build the image, clone the ROMI `docker` repository:
```bash
git clone https://github.com/romi/docker.git
cd docker
```
Then you can build the image with:
```bash
docker build -t visualizer Visualizer/
```
To run it:
```bash
docker run -it -p 3000:3000 visualizer
```
Once it's up, you should be able to access the viewer here: http://localhost:3000/

!!! important
    Use `chrome` as `firefox` has some issues with the used JavaScript libraries!

Push it ot docker hub:
```bash
docker push jlegrand62/romi_plantviewer:latest
```
This require a valid account, token and existing repository (`romi_plantviewer`) on docker hub!

#### Use pre-built docker image
First you need to pull the docker image:
```bash
docker pull jlegrand62/romi_plantviewer
```
Then you can run it with:
```bash
docker run -it -p 3000:3000 jlegrand62/romi_plantviewer
```

!!! note
    ROMI does not have a docker repo yet!

## DockerHub

### Colmap

Docker images for the COLMAP open source project:

[https://hub.docker.com/r/colmap/colmap](https://hub.docker.com/r/colmap/colmap)

nvidia/cuda with colmap - (compatible with Driver Version: 418.67 CUDA Version: 10.1) 

[https://hub.docker.com/r/geki/colmap](https://hub.docker.com/r/geki/colmap)
