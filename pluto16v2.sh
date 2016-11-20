#!/bin/bash

source ./pg_setup.sh
source venv/bin/activate

version="16v2"
execute_sql schemas/${version}.sql 

for i in ${pluto_root}${version}/*.csv; do
    cat $i | 
        python3 remove_whitespace.py |
	python3 pluto_16v2_helper.py |
        python3 addLatLng.py 73 74 | 
        execute_sql_cmd "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (cd,appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council,lng,lat,sanitdistrict))"
done

deactivate
