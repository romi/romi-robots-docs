Create a ROMI database to host, receive & serve plant scans
===========================================================

To follow this guide you should have a `conda` environment, see [here](create_env.md). For the sake of clarity it will be called `plantscans_db`.

!!! note
    Since this is still under development, the packages are installed in "editable mode" with the `-e` option.

!!! note
    If you do not want the hassle of having to create environment & install python libraries, there is a pre-built docker image, with usage instructions [here](../docker/plantdb_docker.md).

## Install `plantdb` sources

Activate your `plantscans_db` environment!

```shell
conda activate plantscans_db
```

To create an active ROMI database, you have to install the `plantdb` package:

```shell
git clone https://github.com/romi/plantdb.git && \
cd plantdb && \
git checkout dev && \
python3.7 -m pip install setuptools setuptools-scm && \
python3.7 -m pip install luigi pillow && \
python3.7 -m pip install flask flask-restful flask-cors && \
python3.7 -m pip install .
```

## Initialize a ROMI database

The `FSDB` class from the `plantdb` module is used to manage a local file system for data storage. A database is any folder which contains a file named `plantdb`.

To create an empty database, just create a new folder, and an empty file named `plantdb` in it.
For example:

```shell
mkdir /data/romi_db
touch /data/romi_db/plantdb
```

Then define its location in an environment variable `ROMI_DB`:

```shell
export ROMI_DB='/data/ROMI/DB'
```

!!! note
    To permanently set this directory as the location of the DB, add it to your `~/.bashrc` file.
    ```shell
    echo 'export ROMI_DB=/data/ROMI/DB' >> ~/.bashrc
    ```

## Set database permissions

!!! warning
    The following lines might be deprecated by the use of the `--user` option for `docker run` in the convenience `run.sh` scripts.

Assuming the path to the database is `/data/ROMI/DB`, you should create a `romi` group with GID `2020` and set the
permissions as follows:

```shell
export ROMI_DB=/data/ROMI/DB
sudo addgroup --gid 2020 romi  # Add a `romi` group with GID `2020`
sudo adduser ${USER} romi  # Add the current user to the `romi` group
sudo chown :2020 -R ${ROMI_DB}  # Set group ownership of the database directory to `romi`
sudo chmod g+s ${ROMI_DB}  # Ensure all future content in the folder will inherit group ownership
```

This was inspired by this Medium [blog post](https://medium.com/@nielssj/docker-volumes-and-file-system-permissions-772c1aee23ca).

## Serve the REST API

Then you can start the REST API with `romi_scanner_rest_api`:

```shell
romi_scanner_rest_api
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

To access the REST API, open your favorite browser and use URLs to access:

* the list of all scans: http://0.0.0.0:5000/scans
* the '2018-12-17_17-05-35' dataset: http://0.0.0.0:5000/scans/2018-12-17_17-05-35

You should see JSON formatted text.

**Troubleshooting**:
When starting the REST API with `romi_scanner_rest_api`, if you get an error message about this executable not being found, it may be missing from the `$PATH` environment variable.
Add it with:

```shell
export PATH=$PATH:"/home/$USER/.local/bin"
```

!!! note
    To permanently set this in your bash terminal, add it to your `~/.bashrc` file.
    ```shell
    echo 'export PATH=$PATH:/home/$USER/.local/bin' >> ~/.bashrc
    ```
