#!/bin/sh

# Enable debug builds
export CFLAGS="-g -O0"

# Compile PostGIS
cd ~/postgis
./autogen.sh
./configure
make
sudo make install
sudo ldconfig
sudo make comments-install

# Enable various commandline tools
sudo ln -sf /usr/share/postgresql-common/pg_wrapper /usr/local/bin/shp2pgsql
sudo ln -sf /usr/share/postgresql-common/pg_wrapper /usr/local/bin/pgsql2shp
sudo ln -sf /usr/share/postgresql-common/pg_wrapper /usr/local/bin/raster2pgsql
