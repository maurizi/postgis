#!/bin/sh

set -e

# Get Dependencies
sudo apt-get update -qq

# Common dependencies
sudo apt-get install -y -q bison libxml2-dev

# Postgresql dependencies
sudo apt-get install -y -q libreadline-dev zlib1g-dev flex

# GDAL dependencies
sudo apt-get install -y -q python-all-dev

# PostGIS dependencies
sudo apt-get install -y -q \
    build-essential libproj-dev libjson0-dev libxml2-utils \
    xsltproc docbook-xsl docbook-mathml autoconf

# Download Postgresql (9.1.15 is the version in the Precise repo)
if [ ! -d postgresql ]; then
    cd ~
    wget -q https://ftp.postgresql.org/pub/source/v9.1.15/postgresql-9.1.15.tar.gz
    tar xzf postgresql-9.1.15.tar.gz
    mv postgresql-9.1.15 postgresql
fi

sh ~/postgis/scripts/build_postgresql.sh
sh ~/postgis/scripts/build_geos.sh
sh ~/postgis/scripts/build_gdal.sh
sh ~/postgis/scripts/build_postgis.sh
