How to use the ROMI `plant 3d explorer` to see the results generated from your plant phenotyping ?
================================

## Objective
Throughout the whole process of plant phenotyping, viewing data is often needed.
This tutorial explains how to use the romi `plant 3d explorer`, a web-server tool, to explore, display and interact with most of the diverse data generated during a typical plant phenotyping experiment from 2D images (images, 3D objects, quality evaluations, trait measurements).
After this tutorial, you should be able to:
* connect the plant 3d explorer to a database containing the phenotyping data of one to several plants ;
* explore the database content with the `Plant 3d explorer` menu page ;
* For each plant, display, overlay and inspect in 3d every data generated during analysis

## Prerequisite
* install romi `plant 3d explorer` (from [source](https://github.com/romi/3d-plantviewer) or using a [docker image](../docker/plantviewer_docker.md) ) - read [install procedure](../install/plant3dexplorer_setup.md) 
* install romi `plantdb` (from [source](https://github.com/romi/romidata) or using a [docker image](../docker/romidb_docker.md)) -- read [install procedure](../install/romidb_setup.md)
* install romiscan / romirunner (for the Visualisation task -> to be done) 
* Create and activate isolated python environment (see [here](/docs/Scanner/install/create_env.md) )
  
## Linked documentation
* [Manual of the romi Plant 3d explorer](tobedone)

## Step-by-step tutorial
Principle: the `plant 3d explorer` is a web client that will display in your favorite web browser data exposed by a server (here, romi `plantdb`) on a particular url. The process consists in pointing the server to your folder of interest, start the server and start the client pointing on the served url. 

!!! note: the `plant 3d explorer` has only been developed and tested on Chrome.

!!! note: if you prefer using docker only, skip steps 1. and 2. and readthe following procedure
[Use docker compose to run both database and 3d explorer with docker containers](../docker/docker_compose.md)

### 1. Connect your database to a local server

- Open a terminal 
- if romi commands (like `romi_scanner_rest_api`) are not accessible from your terminal, activate the appropriate python environment (e.g. using venv or conda) required for romi commands (or [read this procedure](../install/create_env.md))
- set the DB location using the `DB_LOCATION` environment variable and launch the flask server:
```bash
export DB_LOCATION=/path/to/the/db
romi_scanner_rest_api #command that starts the server
```
### 2. Connect the `plant 3d explorer `to the server
- Open a new terminal 
- go to your local cloned directory of `3d-plantviewer/`
- start the frontend visualization server by entering:
```bash
npm start
```
You should now be able to access the `plant 3d explorer` on [http://localhost:3000](http://localhost:3000). Depending on you system preferences, your default web browser may automatically open a window displaying teh server content. if not, open your web browser and enter [http://localhost:3000](http://localhost:3000) in the url bar.

!!! note
    You need to add a file `.env.local` at project's root to set the API URL:
    ```REACT_APP_API_URL='{`API URL}'```

    Without this, the app will use: http://localhost:5000 which is the default for `romi_scanner_rest_api`.

### 2.  Preparing your database
To access the data from your running DB (`` from ``)
```bash
dataset_list=('2018-12-17_17-05-35' '2018-12-18_13-14-57' '2018-12-20_13-21-24' '2019-01-29_16-56-01' '2019-02-01_10-56-34')

for ds in "${dataset_list[@]}"
do 
    romi_run_task Visualization ~/db_test/"$ds"/ --config ~/config/ml_pipe_real_2.toml --local-scheduler
done
```


## Running a production server for the visualizer

!!! warning
    This is not tested yet!


## Visualizer API reference

!!! warning
    Not too many details here, I like it! 