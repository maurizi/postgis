#!/bin/sh

set -e

# Get Dependencies
sudo yum update -y

# Use Postgresql Yum repository
sudo rpm -U http://yum.postgresql.org/9.3/redhat/rhel-7-x86_64/pgdg-centos93-9.3-1.noarch.rpm

# Common dependencies
sudo yum install -y bison libxml2-devel pkgconfig cmake perl gcc-c++ gcc

# GDAL dependencies
sudo yum install -y python-devel

# Postgresql dependencies
sudo yum install -y readline-devel zlib-devel flex

# PostGIS dependencies
sudo yum install -y \
    autoconf proj-devel json-c-devel CUnit-devel libxslt-devel \
    docbook-style-xsl libtool

# Download Postgresql.  9.2.7 is the version in the Centos-7 repo,
# but you can't install PostGIS easily without the Postgresql yum repository,
# so we try and match the version there
if [ ! -d postgresql ]; then
    cd ~
    wget -q https://ftp.postgresql.org/pub/source/v9.3.6/postgresql-9.3.6.tar.gz
    tar xzf postgresql-9.3.6.tar.gz
    mv postgresql-9.3.6 postgresql
fi

sh ~/postgis/vagrant/build_postgresql.sh
sh ~/postgis/vagrant/build_geos.sh
sh ~/postgis/vagrant/build_gdal.sh
sh ~/postgis/vagrant/build_postgis.sh
