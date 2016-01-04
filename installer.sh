#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# setup installs
apt-get update
apt-get upgrade -qqy

apt-get install -qy build-essential python-dev python-setuptools unzip git cmake
#apt-get install -qqy freetype* libpng-dev libjpeg8-dev unzip git cmake
apt-get install -qqy libfreetype6-dev libxml2-dev libxslt1-dev libtiff5-dev libpng12-dev libpng-dev libjpeg8-dev
apt-get install -qqy libblas-dev liblapack-dev gfortran libffi-dev libssl-dev

#pip installs
apt-get install -qy python-pip
pip install pip --upgrade

pip install urllib3[secure]
pip install numpy -q --upgrade

#gdal install
apt-get install -qy libxml2-dev libxslt1-dev libtiff-dev
apt-get install -qqy libgdal-dev gdal-bin python-gdal

#install postgresql postgis
apt-get install -qqy postgresql-9.4 pgadmin3 postgresql-contrib python-psycopg2
apt-get install -qqy postgresql-9.4-postgis-2.1 postgresql-9.4-pgrouting postgis
apt-get install -qqy binutils libproj-dev libpq-dev

service postgresql restart

#workon pygeoan_cb
pip install pyproj -q
pip install shapely
#pip install matplotlib
#pip install descartes
pip install pyshp
pip install geojson
#pip install pandas
pip install scipy
pip install networkx
#pip install pysal
pip install ipython
pip install django==1.8
pip install owslib
pip install folium
pip install jinja2
pip install djangorestframework==3.1.3

PG_VERSION=9.4
PG_CONF="/etc/postgresql/$PG_VERSION/main/postgresql.conf"
PG_HBA="/etc/postgresql/$PG_VERSION/main/pg_hba.conf"
PG_DIR="/var/lib/postgresql/$PG_VERSION/main"

# Edit postgresql.conf to change listen address to '*':
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" "$PG_CONF"

sed -i  's/md5/trust/' "$PG_HBA"
sed -i  's/peer/trust/' "$PG_HBA"

# Append to pg_hba.conf to add password auth:
#echo "local   all             all             all                     md5" >> "$PG_HBA"
#echo "host    all             all             all                     md5" >> "$PG_HBA"

service postgresql restart

