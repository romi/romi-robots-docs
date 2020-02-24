Docker containers for ROMI
==========================

## List of docker containers

We hereafter list the docker containers, their use and list the installed libraries:

 - [ ] romiDB: the database container, gather the acquired images, reconstructed plants architectures & quantitative data - libraries: [`romidata`, ...? ];
 - [ ] romiScanner: the scanner container, pilot the hardware components - libraries: [`lettucethink-python`, ...? ];
 - [ ] romiSmartInterpreter: the reconstruction and quantification container, gather the algorithms and processing pipelines to extract quantitative biological information on plants architecure from a set of photo acquisition - libraries: [`romiscan`, ...? ];
 - [ ] romiVirtualScanner: the virtual scanner container, gather the tools to create virtual plants and render realistic snapshots - libraries: [`?`, ...? ];
 - [ ] visualizer: the plant visualizer, webapp that dialog with the database to display images & some quantitative traits - libraries: [`sony_visualiseur-plantes-3d`, `romidata`, ...? ];


## romiDB
```docker
continuumio/miniconda3
```

## romiScanner
```docker
continuumio/miniconda3
```

## romiSmartInterpreter
```docker
FROM colmap/colmap
```

## romiVirtualScanner
```docker
FROM 
```

## visualizer
```docker
FROM alpine:3.10
```

`scanner-rest-api` & `npm start` are two distinct process to start !


### DockerHub: colmap

Docker images for the COLMAP open source project:

[https://hub.docker.com/r/colmap/colmap](https://hub.docker.com/r/colmap/colmap)

nvidia/cuda with colmap - (compatible with Driver Version: 418.67 CUDA Version: 10.1) 

[https://hub.docker.com/r/geki/colmap](https://hub.docker.com/r/geki/colmap)
