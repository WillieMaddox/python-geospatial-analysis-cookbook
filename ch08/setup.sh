#!/usr/bin/env bash

# Edit the following to change the name of the database user that will be created:
APP_DB_USER=pluto
APP_DB_PASS=stars
# Edit the following to change the name of the database that is created:
APP_DB_NAME=py_geoan_cb

cat << EOF | su - postgres -c "psql -d $APP_DB_NAME"
CREATE EXTENSION pgrouting;
EOF

cd /vagrant/ch08

ogr2ogr -a_srs EPSG:3857 -lco "SCHEMA=geodata" -lco "COLUMN_TYPES=type=varchar,type_id=integer" -nlt MULTILINESTRING -nln ch08_e01_networklines -f PostgreSQL "PG:host=localhost port=5432 user=$APP_DB_USER dbname=$APP_DB_NAME password=$APP_DB_PASS" geodata/shp/e01_network_lines_3857.shp

ogr2ogr -a_srs EPSG:3857 -lco "SCHEMA=geodata" -lco "COLUMN_TYPES=type=varchar,type_id=integer" -nlt MULTILINESTRING -nln ch08_e02_networklines -f PostgreSQL "PG:host=localhost port=5432 user=$APP_DB_USER dbname=$APP_DB_NAME password=$APP_DB_PASS" geodata/shp/e02_network_lines_3857.shp

cat << EOF | su - postgres -c "psql -d $APP_DB_NAME"
ALTER TABLE geodata.ch08_e01_networklines ADD COLUMN source INTEGER;
ALTER TABLE geodata.ch08_e01_networklines ADD COLUMN target INTEGER;
ALTER TABLE geodata.ch08_e01_networklines ADD COLUMN cost DOUBLE PRECISION;
ALTER TABLE geodata.ch08_e01_networklines ADD COLUMN length DOUBLE PRECISION;
UPDATE geodata.ch08_e01_networklines set length = ST_Length(wkb_geometry);
EOF

#SELECT public.pgr_createTopology('geodata.ch08_e01_networklines', 0.0001, 'wkb_geometry', 'ogc_fid');
#python ch08-01_pgrouting_shortest_path.py

cat << EOF | su - postgres -c "psql -d $APP_DB_NAME"
ALTER TABLE geodata.ch08_e02_networklines ADD COLUMN source INTEGER;
ALTER TABLE geodata.ch08_e02_networklines ADD COLUMN target INTEGER;
ALTER TABLE geodata.ch08_e02_networklines ADD COLUMN cost DOUBLE PRECISION;
ALTER TABLE geodata.ch08_e02_networklines ADD COLUMN length DOUBLE PRECISION;
UPDATE geodata.ch08_e02_networklines set length = ST_Length(wkb_geometry);
EOF

#SELECT public.pgr_createTopology('geodata.ch08_e02_networklines', 0.0001, 'wkb_geometry', 'ogc_fid');

cd code
cat << EOF | su - postgres -c "psql -d $APP_DB_NAME"
\i /vagrant/ch08/code/pgr_pointtoid3d.sql
\i /vagrant/ch08/code/pgr_createTopology3d.sql
\i /vagrant/ch08/code/indrz_create_3d_networklines.sql
GRANT SELECT ON ALL TABLES IN SCHEMA geodata TO $APP_DB_USER;
EOF
echo "EOF"
#psql -U $APP_DB_USER -d $APP_DB_NAME -f pgr_pointtoid3d.sql
#psql -U $APP_DB_USER -d $APP_DB_NAME -f pgr_createTopology3d.sql
#psql -U postgres -d $APP_DB_NAME -f indrz_create_3d_networklines.sql

python ch08-05_indoor_3d_route.py


