# romi-robots-docs

This repository contains the sources to build the technical documentation for the ROMI project.
It is published here: https://docs.romi-project.eu/.

## Usage

If it is your first time around, have a look at the official `mkdocs` documentation [here](https://www.mkdocs.org/).

### Setup

We strongly recommand to create a [virtualenv](https://virtualenv.pypa.io/en/latest/)
or [conda](https://conda.io/projects/conda/en/latest/user-guide/getting-started.html) environment first!

With conda, something like this should be enough to get you started:

```shell
conda create -n romi_robots_docs python=3.10
conda activate romi_robots_docs
```

To install all the requirements at once, defined in the `requirements.txt` file, simply do:

```shell
python3 -m pip install -r requirements.txt
```

You may have to update `pip` first:

```shell
python3 -m pip install --upgrade pip
```

### Live edition

Modify the documentation and test them with:

```shell
mkdocs serve
```

Note that this should be run from the project's root directory.

!!! important
As we reference the `plant_3d_explorer`, `plant_3d_vision`, `plant_imager` & `plantdb` modules by reading their
README.md it may significantly slow down the process of generating the HTML files and thus alter the livereload
experience.

### Deploy

Once you are satisfied with your modifications, you can either:

- push them to the GitHub repository and wait for the automatic build (thanks to the `build` job defined
  in `.github/workflows/main.yml`)
- use `mkdocs gh-deploy`.

### Check for broken links

Install the `linkchecker` library:

```shell
pip3 install linkchecker
```

Check links (after upload to website):

```shell
linkchecker https://docs.romi-project.eu
```

