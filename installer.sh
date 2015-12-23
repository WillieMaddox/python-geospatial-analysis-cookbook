#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# setup installs
apt-get update
apt-get upgrade -qqy

apt-get install -qy build-essential python-dev python-setuptools 
apt-get install -qqy freetype* libpng-dev libjpeg8-dev unzip
apt-get install -qqy libblas-dev liblapack-dev gfortran libffi-dev libssl-dev

#pip installs
apt-get install -qy python-pip
pip install pip --upgrade

#gdal install
apt-get install -qy libxml2-dev libxslt1-dev libpq-dev
apt-get install -qqy libgdal-dev  # install is 125MB
apt-get install -qqy gdal-bin python-gdal

#install postgresql postgis
apt-get install -qqy postgresql-9.3 postgresql-9.3-postgis-2.1 pgadmin3 postgresql-contrib python-psycopg2
apt-get install -qqy binutils libproj-dev

#workon pygeoan_cb
pip install urllib3[secure]
pip install numpy -q --upgrade
pip install pyproj -q
pip install shapely
#pip install matplotlib
#pip install descartes
pip install pyshp
pip install geojson
#pip install pandas
#pip install scipy
pip install networkx
#pip install pysal
pip install ipython
pip install django
pip install owslib
pip install folium
pip install jinja2
pip install djangorestframework==3.1.3


