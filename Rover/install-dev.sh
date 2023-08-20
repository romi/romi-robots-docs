#!/bin/bash

# Install the dependencies
sudo apt install build-essential cmake git libpng-dev libjpeg9-dev

# Download, compile and install the libraries & apps
git clone --branch ci_dev --recurse-submodules https://github.com/romi/romi-rover-build-and-test.git
cd romi-rover-build-and-test
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX=~ .. 
make -j4
