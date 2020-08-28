#!/bin/bash

# Create user romi
# sudo adduser romi
# sudo adduser romi dialout
# sudo adduser romi video
# sudo adduser romi sudo

# Install the dependencies
# sudo apt install build-essential cmake git libpng-dev libjpeg9-dev

# Download, compile and install the libraries & apps
# git clone https://github.com/romi/romi-rover-build-and-test.git
# cd romi-rover-build-and-test
# mkdir -p build
# cd build
# cmake cmake -DCMAKE_INSTALL_PREFIX=~/bin .. 
# make

sudo useradd -m -s /bin/bash -G sudo romi
sudo echo "p2pfoodlab\np2pfoodlab" | passwd romi
sudo adduser romi dialout
sudo adduser romi video
sudo adduser romi sudo
sudo echo p2pfoodlab | su - romi
git clone --branch ci_dev --recurse-submodules https://github.com/romi/romi-rover-build-and-test.git
cd romi-rover-build-and-test
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX=~/romi-rover .. 
make
