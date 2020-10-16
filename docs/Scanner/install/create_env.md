Creating isolated Python environments
=====================================

You can use `venv` or `conda` to create isolated Python environments.

!!!warning
    Some of the ROMI libraries have dependencies relying on specific Python versions. Make sure that the isolated environment you create match these requirements!


## Isolated environments with `venv`

### Requirements
Python 3 & `pip` are required.
On Debian-like OS, use the following command to install them:
```bash
sudo apt-get install python3 python3-pip
```

For more details & explanations, follow [this](https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/#) official guide to learn how to install packages using pip and virtual environments.


### Environment creation

To create a new environment, named `plant_scanner`, use `python3` and the `venv` module:

```bash
python3 -m venv plant_scanner
```

!!!note
    This will create a `plant_scanner` folder in the current working directory and place the "environment files" there! We thus advise to gather all your environment in a common folder like `~/envs`.

To activate it:

```bash
source plant_scanner/bin/activate
```


### Usage

Now you can easily install Python packages, for example `NumPy`, as follow:
```bash
pip3 install numpy
```

!!!note
    Use `deactivate` or kill terminal to leave it!

You can now use this environment to install the ROMI software & dependencies.


## Isolated environments with `miniconda`

### Requirements
In this case you do not need Python to be installed on your system, all you need it to install `miniconda3`.
You can download the latest `miniconda3` version with:
```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```

On Debian-like OS, use the following command to install it:
```bash
bash Miniconda3-latest-Linux-x86_64.sh
```

For more details & explanations, follow [this](https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/#) official guide to learn how to install `miniconda`.


### Environment creation

To create a new conda environment, named `plant_scanner` with Python 3.7:

```bash
conda create --name plant_scanner python==3.7
```

To activate it:

```bash
conda activate plant_scanner
```


### Usage

Now you can now easily install Python packages, for example `NumPy`, as follow:
```bash
conda install numpy
```

!!!note
    Use `conda deactivate` or kill terminal to leave it!

You can now use this environment to install the ROMI software & dependencies.

