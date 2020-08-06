Installing the ROMI software
============================

In the following subsections we will details how to install ROMI software for a few usage cases:

1. Plant scans acquisition using the ROMI plant scanner to a database [here](plant_scanner_setup.md).
2. Plant reconstruction pipelines from existing plant scans in a database [here](plant_reconstruction_setup.md).
3. Virtual plant creation (3D modelling of plant architecture with LPY), virtual scan (mimic plant scanner with blender) & reconstruction (same as 2.) [here](virtual_plant_setup.md).
4. Create a web server hosting the plantviewer GUI [here](visualizer_setup.md).
5. Create a database server [here]().

!!!note
    You can find **docker images** for use cases #2, #4 & #5 in the dockerhub repository of the ROMI project [here](https://hub.docker.com/orgs/roboticsmicrofarms/repositories).

## General requirements

### Cloning sources
To clone the git repository, you will need: 

 - `git`
 - `ca-certificates`

Start with these system dependencies:
```bash
sudo apt-get install git ca-certificates
```

### Downloading from URLs
Sometimes the documentation will provides commands with `wget` to download archives or other types of files, here is the command line to install it if you do not have it:

```bash
sudo apt install wget
```


## Creating isolated Python environments

!!!important
    We recommend using `conda` to create isolated environments as some packages, like `openalea.lpy`, are available as `conda` packages but not from `pip` and can be tricky to install from sources!

Follow this [link](create_env.md#isolated-environments-with-miniconda) to learn how to install `miniconda3` & create isolated Python environments with `conda`.

If you have no idea why you should use isolated Python environments, here is a quote from the official Python documentation:

!!!quote
    `venv` (for Python 3) and `virtualenv` (for Python 2) allow you to manage separate package installations for different projects. 
    They essentially allow you to create a "virtual" isolated Python installation and install packages into that virtual installation.
    When you switch projects, you can simply create a new virtual environment and not have to worry about breaking the packages installed in the other environments.
    It is always recommended to use a virtual environment while developing Python applications.

