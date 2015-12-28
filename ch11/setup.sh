#!/usr/bin/env bash

# Edit the following to change the name of the database user that will be created:
APP_DB_USER=saturn
APP_DB_PASS=secret

cat << EOF | su - postgres -c psql
CREATE USER $APP_DB_USER PASSWORD '$APP_DB_PASS';
EOF

cat << EOF | su - postgres -c psql
CREATE SCHEMA django AUTHORIZATION $APP_DB_USER;
ALTER ROLE $APP_DB_USER SET search_path = django, geodata, public, topology;
CREATE ROLE gis_edit VALID UNTIL 'infinity';
GRANT ALL ON SCHEMA geodata TO GROUP gis_edit;
GRANT gis_edit TO $APP_DB_USER;
EOF

cd /vagrant/ch11/code/web_analysis
python manage.py migrate
