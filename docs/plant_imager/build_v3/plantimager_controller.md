# Plant Imager controller

This section use a regular computer with Ubuntu 24.04 as the main controller.

## Getting started

### Enable SSH
Enabling SSH allows to connect to the `plant-imager` device from any machine connected to the `Plant Imager` Access Point.

```bash
sudo apt install openssh-server -y
```

### Set username and password

1. Create the user `romi` with:
    ```shell
    sudo adduser romi
    ```
    This will also create the home directory for this user and ask for a password.
2. Add this user to `dialout`, `video` & `sudo` groups with:
    ```shell
    sudo adduser romi dialout
    sudo adduser romi video
    sudo adduser romi sudo
    ```

## ROMI software

### Install `Oquam`

#### Install the system requirements
To install the system requirements, simply run:
```shell
sudo apt install build-essential cmake git libpng-dev libjpeg-dev
```

#### Clone the sources
To clone the sources from the ROMI GitHub repository, simply run:
```shell
git clone --branch ci_dev --recurse-submodules https://github.com/romi/romi-rover-build-and-test.git
```

!!! note
    The `--recurse-submodules` option will automatically initialize and update each submodule in the repository.

#### Compile the sources
Then move to the cloned directory and compile the `oquam` app with:
```shell
cd romi-rover-build-and-test
mkdir build
cd build
cmake ..
make oquam
```


### Configure the controller to act as a hotspot
To configure the RPi4 to act as a hotspot you may use the `network-hotspot-setup.sh` CLI, as root:
```shell
sudo bash tests-hardware/network-hotspot-setup.sh --wlan wlan0 --ssid "Plant Imager" --pwd "my_secret_password!"
```

This will:

- install the required dependencies
- configure the routing tables
- set the name of the SSID
- set the password to use to connect to the hotspot

!!! important
    Change the password as it is not so secret anymore!


### Configure `rcom`

```shell
cd romi-rover-build-and-test
git submodule init  # if not done yet (empty 'rcom' directory)
git submodule update
cd build
cmake ..
make rcom-registry
```

Start `rcom-registry`:
```shell
./bin/rcom-registry
```

Power the Picamera, you should see a message when it connects to the AP!

### Configure live-preview
You have to install and configure `appache2`.

Let's start by installing the requirements:
```shell
sudo apt install apache2
```

Change `DocumentRoot` in `/etc/apache2/sites-enabled/000-default.conf` to `/home/romi/romi-rover-build-and-test/applications/romi-monitor/`

Also add:
```shell
        <Directory /home/romi/romi-rover-build-and-test/applications/romi-monitor/>
                   Options Indexes
                   AllowOverride None
                   Require all granted
        </Directory>
```
Then restart the `apache2.service` with `systemctl`:
```shell
sudo systemctl restart apache2.service
```

Finally, on the controller, open a web browser (Chromium on the RPi) at `10.10.10.1/camera.html`.
Then scroll down to hit the "connect" icon.
If the PiCamera is ON, you should now see something!

It's now time to adjust the lens! GOOD LUCK!

### Install the `romi` library

```shell
cd ~/romi-rover-build-and-test/python
python -m pip install -e .
```

### Install the `plant-imager` library

#### Install system requirements
You will need `python3` and `pip`, that can be easily installed as follows:
```shell
sudo apt update
sudo apt install python3 python3-pip
```

#### Add the user's private `bin` to the `$PATH`
We have to add a few lines to the `.bashrc` file so the locally installed Python library are available.

To do so, simply copy/paste the following lines in the terminal:
```shell
cat<<EOF >> ~/.bashrc

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
EOF
```

#### Clone the sources
To clone the `plant-imager` sources from the ROMI GitHub repository, simply run:
```shell
cd  # Move back to the user home directory
git clone --branch dev_lyon --recurse-submodules https://github.com/romi/plant-imager.git
```

!!! note
    The `--recurse-submodules` option will automatically initialize and update each submodule in the repository.

#### Install the sources
Then move to the cloned directory and install the `plant-imager` Python library and its submodules (`plantdb` & `romitask`) with:
```shell
# Don't forget to activate the environment!
cd plant-imager
# Install `plantdb` requirements & sources from submodules:
python -m pip install -r ./plantdb/requirements.txt
python -m pip install -e ./plantdb/
# Install `romitask` sources from submodules:
python -m pip install -e ./romitask/
# Install `plant-imager`:
python -m pip install -e .
```

#### Test the installation
To test the installation of the Python libraries you can run:
```shell
python -c "import plantdb"
python -c "import romitask"
python -c "import plantimager"
```

If no error message is returned, you are all set with this part, well done!
