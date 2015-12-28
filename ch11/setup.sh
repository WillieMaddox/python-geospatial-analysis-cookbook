#!/usr/bin/env bash

# Edit the following to change the name of the database user that will be created:
APP_DB_USER=pluto
APP_DB_PASS=stars
#APP_DB_USER=saturn
#APP_DB_PASS=secret
APP_DB_NAME=py_geoan_cb
#cat << EOF | su - postgres -c psql
#CREATE USER $APP_DB_USER PASSWORD '$APP_DB_PASS';
#EOF

cat << EOF | su - postgres -c "psql -d $APP_DB_NAME"
CREATE SCHEMA django AUTHORIZATION $APP_DB_USER;
ALTER ROLE $APP_DB_USER SET search_path = django, geodata, public, topology;
EOF

cd /vagrant/ch11/code/web_analysis
python manage.py migrate

cat << EOF | su - postgres -c "psql -d $APP_DB_NAME"
CREATE ROLE gis_edit VALID UNTIL 'infinity';
GRANT ALL ON SCHEMA geodata TO GROUP gis_edit;
GRANT gis_edit TO pluto;
GRANT ALL ON TABLE geodata.ch08_e01_networklines TO GROUP gis_edit;
GRANT ALL ON TABLE geodata.ch08_e01_networklines_vertices_pgr TO GROUP gis_edit;
GRANT ALL ON TABLE geodata.ch08_e02_networklines TO GROUP gis_edit;
GRANT ALL ON TABLE geodata.ch08_e02_networklines_vertices_pgr TO GROUP gis_edit;
GRANT ALL ON TABLE geodata.networklines_3857 TO GROUP gis_edit;
GRANT ALL ON TABLE geodata.networklines_3857_vertices_pgr TO GROUP gis_edit;
EOF

ogr2ogr -a_srs EPSG:3857 -lco "SCHEMA=geodata" -lco "COLUMN_TYPES=name=varchar,room_num=integer,floor=integer" -nlt POLYGON -nln ch11_e01_roomdata -f PostgreSQL "PG:host=localhost port=5432 user=$APP_DB_USER dbname=$APP_DB_NAME password=$APP_DB_PASS" e01_room_data.shp

ogr2ogr -a_srs EPSG:3857 -lco "SCHEMA=geodata" -lco "COLUMN_TYPES=name=varchar,room_num=integer,floor=integer" -nlt POLYGON -nln ch11_e02_roomdata -f PostgreSQL "PG:host=localhost port=5432 user=$APP_DB_USER dbname=$APP_DB_NAME password=$APP_DB_PASS" e02_room_data.shp

cat << EOF | su - postgres -c "psql -d $APP_DB_NAME"
CREATE OR REPLACE VIEW  geodata.search_rooms_v AS
SELECT floor, wkb_geometry, room_num FROM geodata.ch11_e01_roomdata 
UNION
SELECT floor, wkb_geometry, room_num FROM geodata.ch11_e02_roomdata ;
ALTER TABLE geodata.search_rooms_v OWNER TO $APP_DB_USER;
EOF


