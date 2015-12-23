#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# setup installs
sudo apt-get update
sudo apt-get upgrade -qy

sudo apt-get install -qy build-essential python-dev python-setuptools 
sudo apt-get install -qy freetype* libpng-dev libjpeg8-dev unzip
sudo apt-get install -qy libblas-dev liblapack-dev gfortran
sudo apt-get install -qy libffi-dev libssl-dev

#pip installs
sudo apt-get install -qy python-pip
sudo pip install virtualenv
sudo easy_install virtualenvwrapper

#security installs

#gdal install
sudo apt-get install -qy libxml2-dev libxslt1-dev libpq-dev
sudo apt-get install -qy libgdal-dev  # install is 125MB
sudo apt-get install -qy gdal-bin python-gdal

#install postgresql postgis
sudo apt-get install -qy postgresql-9.3 postgresql-9.3-postgis-2.1 pgadmin3 postgresql-contrib python-psycopg2
sudo apt-get install -qy binutils libproj-dev

# virtualenv install
export WORKON_HOME=~/venvs
mkdir $WORKON_HOME
source /usr/local/bin/virtualenvwrapper.sh
mkvirtualenv pygeoan_cb
echo "export WORKON_HOME=$WORKON_HOME" >> ~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
source ~/.bashrc

workon pygeoan_cb
pip install urllib3[secure]
pip install numpy
pip install pyproj
pip install shapely
pip install matplotlib
pip install descartes
pip install pyshp
pip install geojson
pip install pandas
pip install scipy
pip install networkx
pip install pysal
pip install ipython
pip install django
pip install owslib
pip install folium
pip install jinja2
pip install djangorestframework==3.1.3
toggleglobalsitepackages
enable global site-packages

sudo su - postgres
psql -U postgres -c "CREATE USER pluto WITH ENCRYPTED PASSWORD 'stars';"
psql -U postgres -c "CREATE DATABASE py_geoan_cb WITH OWNER=pluto;"
psql –U postgres -d py_geoan_cb -c "CREATE EXTENSION postgis;"
psql -d py_geoan_cb -c "CREATE SCHEMA geodata AUTHORIZATION pluto;"
#python ch03-01_shp2pg.py
cd /vagrant/ch03
ogr2ogr -f "ESRI Shapefile" geodata/temp PG:"host=localhost user=pluto dbname=py_geoan_cb password=stars" bikeways highest_mountains
cd code
python ch03-01_shp2pg.py
logout
