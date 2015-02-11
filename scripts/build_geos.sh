#!/bin/sh

# Download GEOS
if [ ! -d geos-3.4.2 ]; then
    cd ~
    wget -q http://download.osgeo.org/geos/geos-3.4.2.tar.bz2
    tar xfj geos-3.4.2.tar.bz2
fi

# Enable debug builds
export CFLAGS="-g -O0"

# Compile GEOS
cd ~/geos-3.4.2
./configure
make
sudo make install
