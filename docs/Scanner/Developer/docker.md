Docker containers for ROMI
==========================

## List of docker containers

We hereafter list the docker containers, their use and list the installed libraries:

Progress:
 - [X] DB
 - [ ] Scanner
 - [ ] SmartInterpreter
 - [ ] VirtualScanner
 - [ ] Visualizer


## romiDB
```docker
FROM continuumio/miniconda3
```

#### Dependencies:

Internal dependencies:
 - `data-storage`

External dependencies:
 - `opencv` ??


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

### Visualizer
The plant visualizer.

Webapp that dialog with the database to display images & some quantitative traits.

```docker
FROM alpine:3.10
```

#### Dependencies:

Internal dependencies:
 - `data-storage`, the database API, as well as classes for data processing using luigi.

External dependencies:
 - `sony_visualiseur-plantes-3d`

Notes:
`scanner-rest-api` & `npm start` are two distinct process to start !


## DockerHub

### Colmap

Docker images for the COLMAP open source project:

[https://hub.docker.com/r/colmap/colmap](https://hub.docker.com/r/colmap/colmap)

nvidia/cuda with colmap - (compatible with Driver Version: 418.67 CUDA Version: 10.1) 

[https://hub.docker.com/r/geki/colmap](https://hub.docker.com/r/geki/colmap)
