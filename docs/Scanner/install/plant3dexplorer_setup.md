Install the ROMI `Plant 3d explorer`
=====================================================================

To follow this guide you should have a `conda` environment, see [here](create_env.md).
For the sake of clarity it will be called `Plant 3d explorer`.

!!! note
    If you do not want the hassle of having to create environment & install python libraries, there is a pre-built docker image, with usage instructions [here](../docker/plant3dexplorer_docker.md).


## Pre-requisite

The `Plant 3d explorer` relies on:

 - `node`
 - `npm`

Install `node` and `npm`, on ubuntu:
```bash
sudo apt install npm
```
The packaged version ot `npm` is probably out of date (require `npm>=5`), to update it:
```bash
npm install npm@latest -g
```


## Install ROMI packages & their dependencies:

Activate your `plant_scanner` environment!

Clone the visualizer git repository :
```bash
git clone https://github.com/romi/3d-plantviewer.git
cd 3d-plantviewer
```
Install node packages and build the pages:
```bash
npm install
```


## Use the `Plant 3d explorer`

### With the official ROMI database
You can use the ROMI database to test the installation of the `Plant 3d explorer`:
```bash
export REACT_APP_API_URL='https://db.romi-project.eu'
npm start
```

### With a runnning local database
If you have followed the install instructions of the ROMI database ([here](romidb_setup.md)), you can use it with the `Plant 3d explorer`:
 ```bash
export REACT_APP_API_URL='0.0.0.0'
npm start
```

!!!tip
    To permanently set this URL as the location of the DB, add it to your `~/.bashrc` file.
    ```bash
    echo 'export REACT_APP_API_URL=0.0.0.0' >> ~/.bashrc 
    ```