#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
import subprocess
import os
import shutil

db_host = "localhost"
db_user = "vagrant"
db_passwd = "vagrant0"
db_database = "py_geoan_cb"
db_port = "5432"

# database connection parameters
#db_connection = """PG:host=localhost port=5432 user=pluto dbname=py_geoan_cb password=stars active_schema=geodata"""
db_connection = """PG:host={:s} port={:s} user={:s} dbname={:s} password={:s}""".format(db_host, db_port, db_user, db_database, db_passwd)
print db_connection

# folder to hold output Shapefiles
destination_dir = os.path.realpath('../geodata/temp')

# list of postGIS tables
postgis_tables_list = ["bikeways", "highest_mountains"]

output_format = "ESRI Shapefile"

# check if destination directory exists
if os.path.isdir(destination_dir):
    # remove output folder if it exists
    shutil.rmtree(destination_dir)
    print("removing existing directory : " + destination_dir)

os.mkdir(destination_dir)
for table in postgis_tables_list:
    print("running ogr2ogr on table: " + table)
    subprocess.call(["ogr2ogr", "-f", output_format, destination_dir, db_connection, table])


# commandline call without using python will look like this
# ogr2ogr -f "ESRI Shapefile" mydatadump \
# PG:"host=myhost user=myloginname dbname=mydbname password=mypassword" neighborhood parcels
