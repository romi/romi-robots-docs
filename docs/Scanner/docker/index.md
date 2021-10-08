Docker containers for ROMI
==========================

The official dockerhub repository for the ROMI project is [roboticsmicrofarms](https://hub.docker.com/orgs/roboticsmicrofarms/repositories).


## List of docker containers
We hereafter list the docker containers, their availability and provides link to their location & usage instructions:

- [x] **plantdb** is available [here](https://hub.docker.com/repository/docker/roboticsmicrofarms/plantdb) and explanations [there](plantdb_docker.md)
- [ ] **plantimager** is not available yet and explanations [there](plantimager_docker.md)
- [ ] **plant-3d-vision** is not available yet and explanations [there](plantinterpreter_docker.md)
- [x] **plant-3d-explorer** is available [here](https://hub.docker.com/repository/docker/roboticsmicrofarms/plant-3d-explorer) and
  explanations [there](plant3dexplorer_docker.md)


## Use cases with docker-compose
In this section we reference the "real-life" use cases of our software.

### Use the plant 3d explorer on a local database directory
The easiest way to use the plant-3d-explorer on a local database directory without installing the ROMI libraries (and their dependencies) is to use the pre-built
docker image and add a docker-compose YAML recipe.
See [here](docker_compose.md#database--plantviewer) for more details.


## Getting started with docker
In order to be able to use the ROMI docker images you have to install `docker-ce` and `nvidia-docker2`.

### Installing docker
To install `docker-ce`, please refer to the [official documentation](https://docs.docker.com/get-docker/).

### Install nvidia-docker
To install `nvidia-docker2` , please refer to the [official documentation](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker).


## DockerHub

### ROMI repository
The Docker hub repository for the ROMI project is here: https://hub.docker.com/orgs/roboticsmicrofarms.

### Colmap

Docker images for the Colmap open source project:

[https://hub.docker.com/r/colmap/colmap](https://hub.docker.com/r/colmap/colmap)

nvidia/cuda with Colmap - (compatible with Driver Version: 418.67 CUDA Version: 10.1)

[https://hub.docker.com/r/geki/colmap](https://hub.docker.com/r/geki/colmap)
