Install ROMI software for virtual plants acquisition & reconstruction
=====================================================================

To follows this guide you should have a `conda` or a Python `venv`, see [here](create_conda_env.md).

For the sake of clarity the environment will be called `plant_visualizer`.

## Pre-requisite

The plantviewer relies on:

 - `node`
 - `npm`

Install `node` and `npm`, on ubuntu:
```bash
sudo apt install npm
```
The packaged version ot `npm` is probably out of date (require `npm>=5`), to update it:
```bash
npm install npm@latest -g
```


## Install ROMI packages & their dependencies:

Activate your `plant_scanner` environment!

Clone the visualizer git repository :
```bash
git clone https://github.com/romi/3d-plantviewer.git
cd 3d-plantviewer
```
Install node packages and build the pages:
```bash
npm install
```
