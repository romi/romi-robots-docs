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

```shell
sudo apt install npm
```

The packaged version ot `npm` is probably out of date (require `npm>=5`), to update it:

```shell
npm install npm@latest -g
```

## Install ROMI packages & their dependencies:

Activate your `plant_imager` environment!

Clone the visualizer git repository :

```shell
git clone https://github.com/romi/plant-3d-explorer.git
cd plant-3d-explorer
```

Install node packages and build the pages:

```shell
npm install
```

## Use the `Plant 3d explorer`

### With the official ROMI database

You can use the ROMI database to test the installation of the `Plant 3d explorer`:

```shell
export REACT_APP_API_URL='https://db.romi-project.eu'
npm start
```

### With a running local database

If you have followed the installation instructions of the ROMI database ([here](plantdb_setup.md)), you can use it with the `Plant 3d explorer`:

```shell
export REACT_APP_API_URL='0.0.0.0'
npm start
```

!!! tip
    To permanently set this URL as the location of the DB, add it to your `~/.bashrc` file.
    ```shell
    echo 'export REACT_APP_API_URL=0.0.0.0' >> ~/.bashrc
    ```
