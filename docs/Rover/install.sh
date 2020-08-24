#!/bin/bash

# Create user romi
sudo adduser romi
sudo adduser romi dialout
sudo adduser romi video
sudo adduser romi sudo

# Install the dependencies
sudo apt install build-essential cmake git libpng-dev libjpeg9-dev



# Download, compile and install the libraries & apps
git clone https://github.com/romi/romi-rover-build-and-test.git
cd romi-rover-build-and-test
mkdir -p build
cd build
cmake cmake -DCMAKE_INSTALL_PREFIX=~/bin .. 
make
