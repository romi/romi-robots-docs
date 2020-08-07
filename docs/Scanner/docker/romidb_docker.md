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

To run it, you need to have a local database first, look [here](https://db.romi-project.eu/models/test_db.tar.gz) for an example.

Assuming you extracted it in your home folder (`/home/$USER/integration_tests`), you can start the `romidb` docker image with:
```bash
docker run -it -p 5000:5000 -v /home/$USER/integration_tests:/home/scanner/db romidb:$VTAG
```
Once it's up, you should be able to access the REST API here: http://localhost:5000/

For example to get a list of the scans: http://localhost:5000/scans

!!! note
    `-v /home/$USER/integration_tests:/home/scanner/db` performs a **bind mount** to enable access to the local database by the docker image. See the official [documentation](https://docs.docker.com/storage/bind-mounts/).


## Publish docker image
Push it ot docker hub:
```bash
docker push roboticsmicrofarms/romidb:$VTAG
```
This require a valid account & token on dockerhub!

