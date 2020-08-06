How to use the ROMI plantviewer?
================================

## Ready to run docker image
To use a ready to run docker image pointing toward the `db.romi-project.eu`, look [here](../Developer/docker.md#3d-plantviewer).

!!! note
    This requires `docker-ce` to be installed on your machine.


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