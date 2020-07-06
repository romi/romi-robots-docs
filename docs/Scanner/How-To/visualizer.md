How to use the ROMI plantviewer?
===

## Ready to run docker image
To use a ready to run docker image pointing toward the `db.romi-project.eu`, look [here](/Scanner/Developer/docker/#visualizer).

!!! note
    This requires `docker-ce` to be installed on your machine.

## Source install
To follows this guide you should have a `conda` or a Python `venv`, see [here](/Scanner/how-to/#how-to-install-romi-packages)

### Pre-requisite

The plantviewer relies on:

 - `node`
 - `npm`

To clone the git repository, you will need: 

 - `git`
 - `ca-certificates`

Start with these system dependencies:
```bash
sudo apt git ca-certificates
```

Install `node` and `npm`, on ubuntu:
```bash
sudo apt install npm
```
The packaged version ot `npm` is probably out of date (require `npm>=5`), to update it:
```bash
npm install npm@latest -g
```

### Install ROMI packages & their dependencies:

Clone the visualizer git repository :
```bash
git clone https://github.com/romi/3d-plantviewer.git
cd 3d-plantviewer
```
Install node packages and build the pages:
```bash
npm install
```

## Running a development server for the visualizer

Set the DB location using the `DB_LOCATION` environment variable and launch the flask server:
```bash
export DB_LOCATION=/path/to/the/db
romi_scanner_rest_api
```
Finally, start the frontend visualization server (from `3d-plantviewer/` folder):
```bash
npm start
```
You should now be able to access the visualizer on [http://localhost:3000](http://localhost:3000).

!!! note
    You need to add a file `.env.local` at project's root to set the API URL:
    ```REACT_APP_API_URL='{`API URL}'```

    Without this, the app will use: http://localhost:5000 which is the default for `romi_scanner_rest_api`.

## Preparing your database
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