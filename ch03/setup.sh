#!/usr/bin/env bash

APP_DB_USER=vagrant
APP_DB_PASS=vagrant0
APP_DB_NAME=py_geoan_cb

#PG:"host=localhost user=vagrant dbname=py_geoan_cb password=vagrant0"
#cat << EOF | su - postgres -c "psql -d $APP_DB_NAME"
#CREATE EXTENSION postgis;
#CREATE SCHEMA geodata AUTHORIZATION $APP_DB_USER;
#GRANT SELECT ON ALL TABLES IN SCHEMA geodata TO $APP_DB_USER;
#EOF

cat << EOF | su - $APP_DB_USER -c "psql -d $APP_DB_NAME"
DROP SCHEMA IF EXISTS geodata CASCADE;
CREATE SCHEMA geodata;
EOF

cd /vagrant/ch03/code
echo "---- ch03-01_shp2pg.py"
python ch03-01_shp2pg.py
echo "---- ch03-02_batch_shp2pg.py"
python ch03-02_batch_shp2pg.py

#echo "---- ch03-03_batch_postgis2shp.py"
#python ch03-03_batch_postgis2shp.py
#ogr2ogr -f "ESRI Shapefile" mydatadump PG:"host=myhost user=myloginname dbname=mydbname password=mypassword" neighborhood parcels
#ogr2ogr -f "ESRI Shapefile" ../geodata/temp PG:"host=localhost user=$APP_DB_USER dbname=$APP_DB_NAME password=$APP_DB_PASS" geodata.bikeways geodata.highest-mountains
#ogr2ogr -f "ESRI Shapefile" ../geodata/temp PG:"host=localhost user=$APP_DB_USER dbname=$APP_DB_NAME password=$APP_DB_PASS" bikeways highest-mountains
#echo "---- ch03-04_osm2shp.py"
#python ch03-04_osm2shp.py
#echo "---- ch03-05_shp2raster.py"
#if [[ ! -d ../geodata/golfcourse-3857 ]]; then
#  mkdir ../geodata/golfcourse-3857
#  unzip ../geodata/golfcourse-3857 -d ../geodata/golfcourse-3857
#fi
#python ch03-05_shp2raster.py
#echo "---- ch03-06_raster2shp.py"
#python ch03-06_raster2shp.py
#echo "---- ch03-07_excel2shp"
#./ch03-07_excel2shp
#echo "---- ch03-08_dem2heightmap.py"
#python ch03-08_dem2heightmap.py

