#!/usr/bin/env bash

# Edit the following to change the name of the database user that will be created:
APP_DB_USER=saturn
APP_DB_PASS=secret

# Edit the following to change the name of the database that is created (defaults to the user name)
#APP_DB_NAME=$APP_DB_USER


cat << EOF | su - postgres -c psql
-- Create the database user:
CREATE USER $APP_DB_USER CREATEDB PASSWORD '$APP_DB_PASS';
EOF


#cat << EOF | su - postgres -c psql
#-- Create the database:
#CREATE DATABASE $APP_DB_NAME WITH OWNER=$APP_DB_USER
#                                  LC_COLLATE='en_US.utf8'
#                                  LC_CTYPE='en_US.utf8'
#                                  ENCODING='UTF8'
#                                  TEMPLATE=template0;
#EOF

cat << EOF | su - postgres -c psql
-- Create the schema:
CREATE SCHEMA django AUTHORIZATION $APP_DB_USER;
ALTER ROLE $APP_DB_USER SET search_path = django, geodata, public, topology;
EOF

cd /vagrant/ch11/code/web_analysis
python manage.py migrate
