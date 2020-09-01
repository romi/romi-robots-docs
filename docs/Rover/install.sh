#!/bin/bash

# Create user romi
sudo adduser romi
sudo adduser romi dialout
sudo adduser romi video
sudo adduser romi sudo

# Install the dependencies
sudo apt install build-essential cmake git libpng-dev libjpeg9-dev

echo "
Readme.romi.txt
To clone the romi rover build and test development project:
git clone --branch ci_dev --recurse-submodules https://github.com/romi/romi-rover-build-and-test.git

See: https://github.com/romi/romi-rover-build-and-test/ReadMe.md
" >> /home/romi/ReadMe.romi.txt

chmod a+r /home/romi/ReadMe.romi.txt

