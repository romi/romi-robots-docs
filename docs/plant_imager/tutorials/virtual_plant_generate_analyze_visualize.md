# Evaluate a 3D reconstruction and automated measures with a virtual plant as ground truth


Generate, analyze and visualize virtual plant images using public docker containers.

## Objective
Instead of installing `virtual-plant-imager`, `plant-3d-vision` and `plant-3d-explorer` on your computer you can pull their corresponding docker images and use directly the pre-installed software.
After reading this tutorial, you should be able to generate, analyze and visualize virtual plant images using only public docker images.

## Prerequisite

You must have `docker` and `docker-compose` installed on your system and ideally your user account has sudo privileges.

### 1. Prepare the database

First, you have to give the right access to your database path

```shell
sudo chmod -R 777 /path/of/your/db
```

!!! todo
    Fix these instructions as they are WRONG!
    We now use Unix group rights to access the database path!


### 2. Generate virtual dataset with plant-imager

Pull the public docker image of `virtual-plant-imager`

```shell
docker pull roboticsmicrofarms/virtual-plant-imager:latest
```

Run the docker image with the database mounted volume

```shell
docker run --rm -it --gpus all -v /path/to/your_db:/myapp/db roboticsmicrofarms/virtual-plant-imager:latest /bin/bash
```

Inside docker container, run `VirtualScan` task to generate a dataset named `virtual_ds_example`

```shell
romi_run_task --config plant-imager/config/vscan_lpy_blender.toml VirtualScan /myapp/db/virtual_ds_example
```

Wait for the generation time, after complete, make sure that `virtual_ds_example` has been generated correctly.

Exit docker container

```shell
exit
```

### 3. Angles and Internodes analysis and visualization generation of the dataset

Pull the public docker image of `plant-3d-vision`

```shell
docker pull roboticsmicrofarms/plant-3d-vision:latest
```

Run the docker image with the database mounted volume

```shell
docker run --rm -it --gpus all -v /path/to/your_db:/myapp/db roboticsmicrofarms/plant-3d-vision:latest /bin/bash
```

If not already activated, activate the right virtual environment

```shell
source /venv/bin/activate
```

Inside docker container, run `AnglesAndInternodes` task

```shell
romi_run_task --config config/geom_pipe_virtual.toml AnglesAndInternodes /myapp/db/virtual_ds_example/
```

Make sure that the folder `AnglesAndInternodes` has been generated

Run the `Visualization` task

```shell
romi_run_task --config config/geom_pipe_virtual.toml Visualization /myapp/db/virtual_ds_example/
```

Make sure the `Visualization` folder has been generated

Exit the docker container

```shell
exit
```

### 4. Visualize the virtual dataset on plant-3d-explorer

Pull the public docker image of `plantdb`

```shell
docker pull roboticsmicrofarms/plantdb
```

Pull the public docker image of `plant-3d-explorer`

```shell
docker pull roboticsmicrofarms/plant-3d-explorer
```

Set `ROMI_DB` environment variable to point to your database

```shell
export ROMI_DB=/path/to/your/db
```

Create a file named `docker-compose.yml` so that it will contain the following:

```toml
version: '3'
services:
 plantdb:
   image: "roboticsmicrofarms/plantdb"
   volumes:
     - ${ROMI_DB}:/myapp/db
   ports:
     - "5000:5000"
   healthcheck:
     test: "exit 0"
 plant-3d-explorer:
   image: "roboticsmicrofarms/plant-3d-explorer"
   depends_on:
     - plantdb
   environment:
       REACT_APP_API_URL: http://localhost:5000
   ports:
     - "3000:3000"
```

Run the docker compose in the directory that contains `docker-compose.yml`

```shell
docker-compose up -d
```

After a while, if everything is okay, you can visualize the database (containing `virtual_ds_example`) in your internet browser

at the addres http://localhost:3000/

Make sure that `virtual_ds_example` can be visualized correctly.

Stop docker compose

```shell
docker-compose stop
```
