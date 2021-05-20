Creating isolated Python environments
=====================================

You can use `venv` or `conda` to create isolated Python environments.

!!! warning
    Some ROMI libraries have dependencies relying on specific Python versions. Make sure that the isolated environment you create match these requirements!


## Isolated environments with `venv`

### Requirements

Python 3 & `pip` are required. On Debian-like OS, use the following command to install them:

```shell
sudo apt-get install python3 python3-pip
```

For more details & explanations, follow [this](https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/#) official guide to learn how to install packages using pip and virtual environments.


### Environment creation

To create a new environment, named `plant_imager`, use `python3` and the `venv` module:

```shell
python3 -m venv plant_imager
```

!!! note
    This will create a `plant_imager` folder in the current working directory and place the "environment files" there! We thus advise to gather all your environment in a common folder like `~/envs`.

To activate it:

```shell
source plant_imager/bin/activate
```

### Usage

Now you can easily install Python packages, for example `NumPy`, as follow:

```shell
pip3 install numpy
```

!!! note
    Use `deactivate` or kill terminal to leave it!

You can now use this environment to install the ROMI software & dependencies.

## Isolated environments with `miniconda`

### Requirements

In this case you do not need Python to be installed on your system, all you need it to install `miniconda3`.
You can download the latest `miniconda3` version with:

```shell
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```

On Debian-like OS, use the following command to install it:

```shell
bash Miniconda3-latest-Linux-x86_64.sh
```

For more details & explanations, follow [this](https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/#) official guide to learn how
to install `miniconda`.

### Environment creation

To create a new conda environment, named `plant_imager` with Python 3.7:

```shell
conda create --name plant_imager python==3.7
```

To activate it:

```shell
conda activate plant_imager
```

### Usage

Now you can now easily install Python packages, for example `NumPy`, as follow:

```shell
conda install numpy
```

!!! note
    Use `conda deactivate` or kill terminal to leave it!

You can now use this environment to install the ROMI software & dependencies.

