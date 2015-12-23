#!/usr/bin/env bash

# Edit the following to change the name of the database user that will be created:
APP_DB_USER=pluto
APP_DB_PASS=stars

# Edit the following to change the name of the database that is created (defaults to the user name)
APP_DB_NAME=py_geoan_cb

cat << EOF | su - postgres -c psql
-- Create the database user:
CREATE USER $APP_DB_USER PASSWORD '$APP_DB_PASS';
-- Create the database:
CREATE DATABASE $APP_DB_NAME WITH OWNER=$APP_DB_USER
                                  LC_COLLATE='en_US.utf8'
                                  LC_CTYPE='en_US.utf8'
                                  ENCODING='UTF8'
                                  TEMPLATE=template0;
EOF

cat << EOF | su - postgres -c "psql -d $APP_DB_NAME"
-- Create the postgis extension:
CREATE EXTENSION postgis;
-- Create the schema;
CREATE SCHEMA geodata AUTHORIZATION $APP_DB_USER;
EOF

cd /vagrant/ch03/code
python ch03-01_shp2pg.py

