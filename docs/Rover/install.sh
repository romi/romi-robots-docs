#!/bin/bash

# Install the dependencies
sudo apt install build-essential cmake git libpng-dev libjpeg9-dev

# Download, compile and install the libraries & apps
for id in libr rcom libromi romi-rover; do
    echo ----------------------------------------------
    echo Compiling $id

    # Download or update the github repository
    if [ -d $id ]; then
        cd $id
        git pull
    else
        git clone https://github.com/romi/$id.git
        cd $id
    fi

    # Standard cmake build sequence
    mkdir -p build
    cd build
    cmake ..
    make
    sudo make install
    sudo ldconfig

    # Get ready for the next component
    cd ../..
done
