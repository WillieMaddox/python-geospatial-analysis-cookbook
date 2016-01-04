#!/usr/bin/env python
# -*- coding: utf-8 -*-

import subprocess

db_host = "localhost"
db_user = "vagrant"
db_passwd = "vagrant0"
db_database = "py_geoan_cb"
db_port = "5432"

# database connection string
db_connection = """PG:host={:s} port={:s} user={:s} dbname={:s} password={:s}""".format(db_host, db_port, db_user, db_database, db_passwd)

# database options
db_schema = "SCHEMA=geodata"
overwrite_option = "OVERWRITE=YES"
geom_type = "MULTILINESTRING"
output_format = "PostgreSQL"

# input shapefile
input_shp = "../geodata/bikeways.shp"

# call ogr2ogr from python
subprocess.call(["ogr2ogr","-lco", db_schema, "-lco", overwrite_option,
	"-nlt", geom_type, "-f", output_format, db_connection,  input_shp])
	
# -lco is the layer creation option
# -f is output format
# -nlt new layer type

