#!/bin/sh

set -e

# Get Dependencies
sudo apt-get update -qq

# Common dependencies
sudo apt-get install -y -q bison libxml2-dev

# Postgresql dependencies
sudo apt-get install -y -q libreadline-dev zlib1g-dev flex

# PostGIS dependencies
sudo apt-get install -y -q \
    build-essential libgeos-c1 libgdal-dev libproj-dev libjson0-dev \
    libxml2-utils xsltproc docbook-xsl docbook-mathml autoconf

# Enable debug builds
export CFLAGS="-g -O0"

# Download Postgresql
if [ ! -d postgresql-9.3.6 ]; then
    wget -q https://ftp.postgresql.org/pub/source/v9.3.6/postgresql-9.3.6.tar.gz
    tar xzf postgresql-9.3.6.tar.gz
fi

# Compile Postgresql
cd ~/postgresql-9.3.6
./configure --with-libxml --enable-cassert --prefix=/usr/local/
make
sudo make install

# Setup Postgresql user/db
sudo adduser postgres

sudo mkdir /opt/postgresql/
sudo chown postgres:postgres /opt/postgresql/

sudo -u postgres initdb /opt/postgresql/
sudo -u postgres pg_ctl start -w -D /opt/postgresql/

sudo -u postgres psql -c 'CREATE ROLE vagrant WITH superuser;'
sudo -u postgres psql -c 'ALTER ROLE vagrant LOGIN;'

# Compile PostGIS
cd /vagrant
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
