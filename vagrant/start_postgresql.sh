#!/bin/sh

if [ -e /usr/local/bin/pg_ctl ]; then
    sudo -u postgres /usr/local/bin/pg_ctl start -w -D /opt/postgresql/
fi
