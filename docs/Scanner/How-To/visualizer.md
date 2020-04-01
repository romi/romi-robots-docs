How to use the ROMI Visualizer?
===

## Getting started

To follows this guide you should have a `conda` or a Python `venv`, see [here](/Scanner/how-to/#how-to-install-romi-packages)

### Install ROMI packages & their dependencies:

Clone the visualizer git repository :
```bash
git clone git@github.com:romi/sony_visualiseur-plantes-3d.git
cd sony_visualiseur-plantes-3d
```

Install node packages and build the pages:
```bash
npm install
```

## Running a development server for the visualizer

Set the DB location using the `DB_LOCATION` environment variable:
```bash
export DB_LOCATION=/path/to/the/db
```

Launch the flask development server:
```bash
scanner-rest-api
```

Finally, start the frontend development server:
```bash
npm start
```

You can now access the visualizer on [http://localhost:3000](http://localhost:3000).

## Running a production server for the visualizer

!!! warning
    This is not tested yet!

## Ready to run docker image

See: [*visualizer*](/Scanner/Developer/docker/#visualizer) docker image.

!!! warning
    This is not ready yet!

## Visualizer API reference
