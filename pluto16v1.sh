#!/bin/bash

pluto_root="/home/michael/data/pluto/"
database="samp2"

version="16v1"
psql -d ${database} -f schemas/${version}.sql 

for i in ${pluto_root}${version}/*.csv; do
    cat $i | 
        python3 remove_whitespace.py |
        python3 addLatLng.py | 
        psql -d ${database} -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (cd,appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council,lng,lat,sanitdistrict))"
done

