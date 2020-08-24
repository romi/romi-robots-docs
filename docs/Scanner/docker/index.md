Docker containers for ROMI
==========================

The official dockerhub repository for the ROMI project is:
https://hub.docker.com/orgs/roboticsmicrofarms/repositories 

## List of docker containers
We hereafter list the docker containers, their availability and provides link to their location & usage instructions:

 - [x] **romidb** is available [here](https://hub.docker.com/repository/docker/roboticsmicrofarms/romidb) and explanations [there](romidb_docker.md)
 - [ ] **plantscanner** is not available yet and explanations [there](plantscanner_docker.md)
 - [ ] **plantinterpreter** is not available yet and explanations [there](plantinterpreter_docker.md)
 - [ ] **virtualplantscanner** is not available yet and explanations [there](virtualplantscanner_docker.md)
 - [x] **plantviewer** is available [here](https://hub.docker.com/repository/docker/roboticsmicrofarms/plantviewer) and explanations [there](plantviewer_docker.md)


## Use cases with docker-compose
In this section we reference the "real-life" use cases of our software. 

### Use the plantviewer on a local database directory
To easiest way to use the plantviewer on a local database directory without installing the ROMI libraries (and their dependencies) is to use the pre-built docker image and add a docker-compose YAML recipe.
See [here](docker_compose.md#database--plantviewer) for more details.


## DockerHub

### roboticsmicrofarms
The Docker hub repository for the ROMI project is here: https://hub.docker.com/orgs/roboticsmicrofarms

### Colmap

Docker images for the COLMAP open source project:

[https://hub.docker.com/r/colmap/colmap](https://hub.docker.com/r/colmap/colmap)

nvidia/cuda with colmap - (compatible with Driver Version: 418.67 CUDA Version: 10.1) 

[https://hub.docker.com/r/geki/colmap](https://hub.docker.com/r/geki/colmap)
