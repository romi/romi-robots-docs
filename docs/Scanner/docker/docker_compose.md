Docker compose
===

In the following sections we will propose several use cases combining docker images thanks to `docker-compose`.

!!!note
    You need `docker-compose` installed, see [here](https://docs.docker.com/compose/install/).


## Database & plantviewer

To use your own local database, we provide a docker compose recipe that:

1. start a database container using `roboticsmicrofarms/romidb`
2. start a plantviewer container using `roboticsmicrofarms/plantviewer`


### Use pre-built docker image
You can use the pre-built images `romidb` & `plantviewer`, accessible from the ROMI dockerhub, to easily test & use the `plant 3d explorer` with your own database [^3].

[^3]: https://docs.docker.com/compose/compose-file/#image

The `docker-compose.yml` look like this:
```yaml
version: '3'
services:
  db:
    image: "roboticsmicrofarms/romidb"
    volumes:
      - ${ROMI_DB}:/home/scanner/db
    expose:
      - "5000"
    healthcheck:
      test: "exit 0"
  viewer:
    image: "roboticsmicrofarms/plantviewer"
    depends_on:
      - db
    environment:
        REACT_APP_API_URL: http://172.21.0.2:5000
    ports:
      - "3000:3000"
```

From the root directory of `3d-plantviewer` containing the `docker-compose.yml` in a terminal:
```bash
export ROMI_DB=<path/to/db>
docker-compose up -d 
```

!!! important
    Do not forget to set the path to the database.

!!! warning
    If you have other containers running it might not work since it assumes the romidb container will have the `172.21.0.2` IP address!

To stop the containers: 
```bash
docker-compose stop
```

!!!note
    To use local builds, change the `image` YAML parameter to match your images names & tag.


### Force local builds
To force builds at compose startup, for development or debugging purposes, use the `build` YAML parameter instead of `image` [^1].
It is possible to keep the `image` YAML parameter to tag the built images [^2].

[^1]: https://docs.docker.com/compose/gettingstarted/
[^2]: https://docs.docker.com/compose/compose-file/#build

The `docker-compose.yml` should look like this:
```yaml
version: '3'
services:
  db:
    build: ../romidata/.
    image: db:debug
    volumes:
      - ${ROMI_DB}:/home/scanner/db
    expose:
      - "5000"
    healthcheck:
      test: "exit 0"
  viewer:
    build: ../developer
    image: viewer:debug
    depends_on:
      - db
    environment:
        REACT_APP_API_URL: http://172.21.0.2:5000
    ports:
      - "3000:3000"
```

!!!warning
    This assumes that you have to `romidata` repository cloned next to the one of `3d-plantviewer`.
