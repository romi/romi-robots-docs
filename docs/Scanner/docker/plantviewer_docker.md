Docker container for ROMI plantviewer
=====================================

The plant visualizer is a webapp that dialog with the database to display images & some quantitative traits.

It is based on Ubuntu 18.04.

Note that we tag the different versions, the default is to use the latest, but you can also specify a specific version by changing the value of the environment variable `$VTAG`, *e.g.* `export VTAG="2.1"`.
Look here for a list of available tags: https://hub.docker.com/repository/docker/roboticsmicrofarms/plantviewer


## Use pre-built docker image
You can easily download and start the pre-built `plantviewer` docker image with:
```bash
docker run -p 3000:3000 roboticsmicrofarms/plantviewer:$VTAG
```

By default the docker image will create a container pointing toward the official ROMI database https://db.romi-project.eu.

To change that, _e.g._ to a local running database at '0.0.0.0', do [^1]:
```bash
docker run --env REACT_APP_API_URL='0.0.0.0' -p 3000:3000 roboticsmicrofarms/plantviewer:$VTAG
```

[^1]: https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file

## Build docker image
To build the image, from the `3d-plantviewer` root directory, run:
```bash
export VTAG="latest"
docker build -t roboticsmicrofarms/plantviewer:$VTAG .
```
To start the container using the built image:
```bash
docker run -p 3000:3000 roboticsmicrofarms/plantviewer:$VTAG
```
Once it's up and running, you should be able to access the viewer using a browser here: http://localhost:3000/

!!! note
    If you omit the `-p 3000:3000` you can still access the interface using the docker ip, something like http://172.17.0.2:3000/

!!! important
    Use `chrome` as `firefox` has some issues with the used JavaScript libraries!


## Publish docker image
To push it on the `roboticsmicrofarms` docker hub:
```bash
docker push roboticsmicrofarms/plantviewer:$VTAG
```
This require a valid account and token on dockerhub!
