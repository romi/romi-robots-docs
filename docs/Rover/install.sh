#!/bin/bash

# Create user romi
sudo adduser romi
sudo adduser romi dialout
sudo adduser romi video
sudo adduser romi sudo

# Install the dependencies
sudo apt install build-essential cmake git libpng-dev libjpeg9-dev
sudo mv /etc/ld.so.preload /etc/ld.so.preload.bak

echo "



██████╗  ██████╗ ███╗   ███╗██╗    ██████╗  ██████╗ ██╗   ██╗███████╗██████╗ 
██╔══██╗██╔═══██╗████╗ ████║██║    ██╔══██╗██╔═══██╗██║   ██║██╔════╝██╔══██╗
██████╔╝██║   ██║██╔████╔██║██║    ██████╔╝██║   ██║██║   ██║█████╗  ██████╔╝
██╔══██╗██║   ██║██║╚██╔╝██║██║    ██╔══██╗██║   ██║╚██╗ ██╔╝██╔══╝  ██╔══██╗
██║  ██║╚██████╔╝██║ ╚═╝ ██║██║    ██║  ██║╚██████╔╝ ╚████╔╝ ███████╗██║  ██║
╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝    ╚═╝  ╚═╝ ╚═════╝   ╚═══╝  ╚══════╝╚═╝  ╚═╝
                                                                             
                                                                             
                                                                             

README
------

To clone the romi rover build and test development project:

- Log in as user romi 
- git clone --branch ci_dev --recurse-submodules https://github.com/romi/romi-rover-build-and-test.git

See: https://github.com/romi/romi-rover-build-and-test/ReadMe.md for instructions




Enjoy!
"

