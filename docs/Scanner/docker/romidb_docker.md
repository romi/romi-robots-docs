Docker container for ROMI database
==================================

!!!important
    An **existing local database is required**, it will be mounted at container startup.
    To see how to create a local database, look [here](../install/romidb_setup.md#initialize-a-romi-database).


## Use pre-built docker image
Assuming you have a valid ROMI database directory under `/data/ROMI/DB`, you can easily download and start the pre-built `romidb` docker image with:
```bash
docker run -it -p 5000:5000 -v /data/ROMI/DB:/home/scanner/db roboticsmicrofarms/romidb:$VTAG
```
And should be able to access it here: http://localhost:5000/

!!! note
    `-v /data/ROMI/DB:/home/scanner/db` performs a **bind mount** to enable access to the local database by the docker image. See the official [documentation](https://docs.docker.com/storage/bind-mounts/).


## Build docker image
To build the image, from the `romidata` root directory, run:
```bash
export VTAG="latest"
docker build -t roboticsmicrofarms/romidb:$VTAG .
```


## Publish docker image
Push it ot docker hub:
```bash
docker push roboticsmicrofarms/romidb:$VTAG
```
This require a valid account & token on dockerhub!


## Usage


### Requirements
To run it, you need to have a valid local ROMI database, look [here](https://docs.romi-project.eu/Scanner/install/romidb_setup/#initialize-a-romi-database) for instructions and [here](https://db.romi-project.eu/models/test_db.tar.gz) for an example database.


### Starting the `romidb` docker image
Assuming you extracted it in your home folder (`/home/$USER/integration_tests`), you can start the `romidb` docker image with:
```bash
docker run -it -p 5000:5000 -v /home/$USER/integration_tests:/home/scanner/db romidb:$VTAG
```

You should see something like:
```
n scans = 2
 * Serving Flask app "romi_scanner_rest_api" (lazy loading)
 * Environment: production
   WARNING: This is a development server. Do not use it in a production deployment.
   Use a production WSGI server instead.
 * Debug mode: off
 * Running on http://0.0.0.0:5000/ (Press CTRL+C to quit)
```

!!tip
    `-v /home/$USER/integration_tests:/home/scanner/db` performs a **bind mount** to enable access to the local database by the docker image. See the official Docker [documentation](https://docs.docker.com/storage/bind-mounts/).

### Accessing the REST API
Once it's up, you should be able to access the REST API here: http://localhost:5000/

To access the REST API, open your favorite browser and use URLs to access:

* the list of all scans: http://0.0.0.0:5000/scans
* the '2018-12-17_17-05-35' dataset: http://0.0.0.0:5000/scans/2018-12-17_17-05-35

You should see JSON formatted text.

