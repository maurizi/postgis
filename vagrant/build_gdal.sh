#!/bin/sh

# Download GDAL
if [ ! -d gdal-1.10.1 ]; then
    cd ~
    wget -q http://download.osgeo.org/gdal/1.10.1/gdal-1.10.1.tar.gz
    tar xfz gdal-1.10.1.tar.gz
fi

# Enable debug builds
export CFLAGS="-g -O0"

# Compile GDAL
cd ~/gdal-1.10.1
./configure --with-python
make
sudo make install
