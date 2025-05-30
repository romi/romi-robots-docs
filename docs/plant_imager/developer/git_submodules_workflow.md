# Git submodules in plant-3d-vision

We make use of _git submodules_ in the `plant-3d-vision` repository to tightly control the version of the other ROMI libraries used as dependencies.
Hereafter we detail how to manage those submodules, especially how to update them.

## Getting started

### Clone the sources

If you are joining the project start by cloning the sources:

```shell
git clone https://github.com/romi/plant-3d-vision.git
```

### Initialize the submodules
If you just cloned the repository or if the submodules folders (`romitask`, `romicgal`, `plantdb`...) are empty, you have to **initialize the submodules** in the `plant-3d-vision` folder with:

```shell
cd plant-3d-vision
git submodule init
git submodule update
```

You should now have submodules folders (`romitask`, `romicgal`, `plantdb`...) filled with the contents for the associated "fixed commit".

To know the latest commit associated to a submodule, move to its folder and look-up the `git log`:

```shell
cd plant-3d-vision/<submodule_root_dir>
git log
```

!!! Tips
    Press key `q` to quit the log.

## Integrate the modifications of a submodule
For the sake of clarity, let's assume you have worked on the `dtw` submodule, integrated your changes in the branch 
`<my_branch>` (usually `main`) and you want to integrate these modifications to `plant-3d-vision`.

On way to do it is this:
```shell
cd plant-3d-vision/
git pull

# It would be better to create an integration branch...

cd dtw  # could be another submodule than `dtw`
git checkout <my_branch>  # usually `main` or `dev`/`develop`
git pull
git log  # check this is indeed the last commit that you want to integrate

cd ..
git status  # should see `modifié :         dtw (nouveaux commits)`

git add dtw
git status  # should show added `dtw` in green
git commit -m "update dtw submodule"
git push
```


## Update the plant-3d-vision integration branch

From the `plant-3d-vision` folder, checkout the `dev` branch (integration branch):

```shell
git checkout dev
git fetch
git pull
git submodule update
git status
```

## Update the submodule branch

To check the latest commit of a submodule do:

```shell
git log
```

To get the commit short hash:

```shell
git rev-parse --short=8 HEAD
```

To update a submodule branch:

```shell
cd <submodule_root_dir>
git checkout <submodule_branch>  # or commit short hash
git status
git log
```

## Commit the changes

You may now commit the changes to `plant-3d-vision`:

```shell
git commit -m "Update romicgal submodule"
```
