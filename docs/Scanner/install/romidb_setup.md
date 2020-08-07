Create a ROMI database to host, receive & serve plant scans
===========================================================

 To follows this guide you should have a `conda` or a Python `venv`, see [here](create_conda_env.md).

For the sake of clarity the environment will be called `plantscans_db`.

!!! note
    Since this is still under development, the packages are installed in "editable mode" with the `-e` option.


## Install `romidata` sources

Activate your `plantscans_db` environment!
```bash
conda activate plantscans_db
```

To create an active ROMI database, you have to install the `romidata` package:
```bash
git clone https://github.com/romi/romidata.git && \
cd romidata && \
git checkout dev && \
python3.7 -m pip install setuptools setuptools-scm && \
python3.7 -m pip install luigi pillow && \
python3.7 -m pip install flask flask-restful flask-cors && \
python3.7 -m pip install .
```


## Initialize a ROMI database

The `FSDB` class from the `romidata` module is used to manage a local file system for data storage.
A database is any folder which contains a file named `romidb`.

To create an empty database, just create a new folder and an empty file named `romidb` in it.
For example:
```bash
mkdir /data/romi_db
touch /data/romi_db/romidb
```

Then define its location in an environment variable `DB_LOCATION`:
```bash
export DB_LOCATION=/data/ROMI/DB
```

!!!note
    To permanently set this directory as the location of the DB, add it to your `~/.bashrc` file.
    ```bash
    echo 'export DB_LOCATION='/data/ROMI/DB'' >> ~/.bashrc 
    ```


## Serve the REST API
Then you can start the REST API with `romi_scanner_rest_api`:
```bash
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

Open your favorite browser here:

* scans: http://0.0.0.0:5000/scans
* '2018-12-17_17-05-35' dataset: http://0.0.0.0:5000/scans/2018-12-17_17-05-35

You should see JSON formatted text.

**Troubleshooting**:
When starting the REST API with `romi_scanner_rest_api`, if you get an error message about this executable not being found, it may be missing from the `$PATH` environement variable.
Add it with:
```bash
export PATH=$PATH:"/home/${SETUSER}/.local/bin"
```
!!!note
    To permanently set this in your bash terminal, add it to your `~/.bashrc` file.
    ```bash
    echo 'export PATH=$PATH:"/home/${SETUSER}/.local/bin"' >> ~/.bashrc 
    ```
