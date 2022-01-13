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

```shell
cd plant-3d-vision/
git pull

# It would be better to create an integration branch...

cd dtw
git checkout <branch_to_integrate>
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

To update a submodule branch

```shell
cd <submodule_root_dir>
git checkout <submodule_branch>
git fetch
git pull
git status
git log
```

## Create a branch for local merge

Move to the root folder of the submodule you want to update:

```shell
cd <submodule_root_dir>
git checkout -b update/<submodule_name>
```

For example to update `romicgal`:

```shell
cd romicgal
git checkout -b update/romicgal
```

## Commit the changes

You may now commit the changes to `plant-3d-vision`:

```shell
cd ..
git checkout -b update/romicgal
```
