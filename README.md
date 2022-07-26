# romi-robots-docs

The project main documentation available at https://docs.romi-project.eu/

## Usage

### Setup

You need to meet the following requirements:

`python3 -m pip install --upgrade pip`

`python3 -m pip install -r requirements.txt`

### Live edition

Modify the documentation and test them with:
`mkdocs serve`

Note that this should be run from the project's root directory.

!!! important
    As we reference the `plant_3d_explorer`, `plant_3d_vision`, `plant_imager` & `plantdb` modules by reading their README.md it may significantly slow down the process of generating the HTML files and thus alter the livereload experience.

### Deploy

Once you are satisfied with your modifications, push them to the github repository and wait for the automatic build, or use `mkdocs gh-deploy`.
