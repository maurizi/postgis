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
    build-essential libgdal-dev libproj-dev libjson0-dev libxml2-utils \
    xsltproc docbook-xsl docbook-mathml autoconf

# Download Postgresql (9.3.6 is the version in the Trusty repo)
if [ ! -d postgresql ]; then
    cd ~
    wget -q https://ftp.postgresql.org/pub/source/v9.3.6/postgresql-9.3.6.tar.gz
    tar xzf postgresql-9.3.6.tar.gz
    mv postgresql-9.3.6 postgresql
fi

sh ~/postgis/scripts/build_postgresql.sh
sh ~/postgis/scripts/build_geos.sh
sh ~/postgis/scripts/build_postgis.sh
