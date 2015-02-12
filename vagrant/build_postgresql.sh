#!/bin/sh

# Enable debug builds
export CFLAGS="-g -O0"

# Compile Postgresql
cd ~/postgresql
./configure --with-libxml --enable-cassert --prefix=/usr/local/
make
sudo make install

# Setup Postgresql user/db
sudo adduser postgres

sudo mkdir /opt/postgresql/
sudo chown postgres:postgres /opt/postgresql/

sudo -u postgres /usr/local/bin/initdb /opt/postgresql/
sudo -u postgres /usr/local/bin/pg_ctl start -w -D /opt/postgresql/

sudo -u postgres /usr/local/bin/psql -c 'CREATE ROLE vagrant WITH superuser;'
sudo -u postgres /usr/local/bin/psql -c 'ALTER ROLE vagrant LOGIN;'
