#!/usr/bin/env bash

# Edit the following to change the name of the database user that will be created:
APP_DB_USER=vagrant
APP_DB_PASS=vagrant0
APP_DB_NAME=py_geoan_cb

cat << EOF | su - postgres -c psql
CREATE USER $APP_DB_USER WITH SUPERUSER PASSWORD '$APP_DB_PASS';
EOF

cat << EOF | su - $APP_DB_USER
createdb -O $APP_DB_USER -E UTF8 $APP_DB_NAME
psql -d $APP_DB_NAME -c 'CREATE EXTENSION postgis;'
psql -d $APP_DB_NAME -c 'CREATE EXTENSION postgis_topology;'
psql -d $APP_DB_NAME -c 'CREATE EXTENSION pgrouting;'
EOF

#cat << EOF | su - postgres -c psql
#CREATE USER $APP_DB_USER PASSWORD '$APP_DB_PASS';
#CREATE DATABASE $APP_DB_NAME WITH OWNER=$APP_DB_USER;
#EOF
#                                  LC_COLLATE='en_US.UTF-8'
#                                  LC_CTYPE='en_US.UTF-8'
#                                  ENCODING='UTF8'
#                                  TEMPLATE=template0;
#EOF

