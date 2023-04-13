# Virtual Plant Imager API

Once you start the ``romi_virtualplantimager`` Python script in Blender, you will have a Flask server running and listening to HTTP requests.

Hereafter we list the GET/POST requests that can be made and give some examples.

## Start the Blender server
There are many ways to do this, but the simplest & fastest option is to use the Docker image ``roboticsmicrofarms/virtualplantimager``.

!!! note
    We make use of the `$DB_LOCATION` environment variable.
    If not done yet, you may want to set it with `export DB_LOCATION=/path/to/database`.
    Or replace it with the path to use.

### Start a container
=== "Docker CLI"
    Start a container and open a bash shell:
    ```shell
    docker run -it --gpus all roboticsmicrofarms/virtualplantimager:latest -v $DB_LOCATION:/myapp/db bash
    ```

=== "`run.sh` script"
    Start a container and open a bash shell:
    ```shell
    ./docker/virtualplantimager/run.sh -db $DB_LOCATION
    ```

### Start the Blender Flask server
Then start the Blender server (listening to port 5000) with:
```shell
romi_bpy plant-imager/bin/romi_virtualplantimager -- --port 9001
```
When the server is up and running you should get something like:
```
 * Serving Flask app 'romi_virtualplantimager'
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:9001
 * Running on http://172.17.0.2:9001
```

!!! note
    The first HTTP address is accessible from within the container.
    The second HTTP address is accessible from the host running the container.

### Test the server

=== "From the host"
    You may now use a web browser to submit a `/hello_world` request at `http://172.17.0.2:9001`.
    
    To do so, just copy/paste `http://172.17.0.2:9001/hello_world` to the URL bar.

=== "From the container"
    You may use Python to submit a request at `http://172.0.0.1:9001`.

    For example, you may get info by submitting a `/hello_world` request as follows:

    1. Open a new shell in the running container with (do not forget to replace the `CONTAINER_ID`):
    ```shell
    docker exec -it CONTAINER_ID bash
    ```
    2. Then use Python to send a GET request:
    ```shell
    python -c "import requests
    res = requests.get('http://127.0.0.1:9001/hello_world')
    print(res.content.decode())"
    ```

You should get a JSON response similar to this:
```
"Hello World!"
"I am a Flask server named 'romi_virtualplantimager'."
"I run Blender 2.93.16 built on 2023-03-21."
"I run Python 3.9.16."
```

## Reference

### Objects

* `/objects` (GET): retrieve the list of `obj` files in the data folder that can be loaded.
* `/load_object/<object_id>` (GET) load the given object in the scene. Takes a translation vector as URL parameters (`dx`, `dy`, `dz`)

### Classes

* `/classes` (GET): retrieve the list of classes.

### Backgrounds

* `/backgrounds` (GET): retrieve the list of `hdr` files in the `hdri` folder that can be loaded.
* `/load_background/<background_id>` (GET) load the given background in the scene.

### Camera

* `/camera_intrinsics` (POST): set camera intrinsics. Keys: `width`, `height`, `focal`
* `/camera_pose` (POST): set camera pose. Keys: `tx`, `ty`, `tz`, `rx`, `ry`, `rz`

### Rendering

* `/render` (GET): gets the rendering of the scene
* `/render_class/<class_id>` (GET) renders the scene, with everything transparent except the given class

!!! todo
    Missing endpoints.

## Examples
Using a browser to send HTTP requests is not too convenient.
Instead, you may use [httpie](https://httpie.org/) to send HTTP commands from a terminal.

To easily adapt to other configurations, we define the `$VPI_HOST` & `$VPI_PORT` variables.
For example, matching the example given above, we define:
```shell
export VPI_HOST='172.17.0.2'
export VPI_PORT='9001'
```

### Setup camera
```shell
http -f post "http://$VPI_HOST:$VPI_PORT/camera_intrinsics width=1920 height=1080 focal=35"
```

### Load `arabidopsis_0` OBJ
```shell
http get "http://$VPI_HOST:$VPI_PORT/load_object/arabidopsis_0.obj?dx=10&dy=20&dz=1"
```

### Load "old tree in the park" background
```shell
http get "http://127.0.0.1:$VPI_PORT/load_background/old_tree_in_city_park_8k.hdr"
```

### Move camera
```shell
http -f post "http://$VPI_HOST:$VPI_PORT/camera_pose tx=-60 ty=0 tz=50 rx=60 ry=0 rz=-90"
```

### Render scene and download image
```shell
http --download get "http://$VPI_HOST:$VPI_PORT/render"
```

### Render only leaves
```shell
http --download get "http://$VPI_HOST:$VPI_PORT/render_class/Color_7"
```
