#!/bin/bash

# createdb pluto
pluto_root="/home/michael/data/pluto/zips/"
database="pluto_2"

version="03c"
psql -d ${database} -f schemas/03c.sql 

for i in ${pluto_root}${version}/*.TXT; do
    cat $i | perl -pe 's/\x00//g' | 
        python3 remove_whitespace.py |
        psql -d ${database} -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (LandUse,splitzone,irrlotcode,cornerlot,xcoord,ycoord,schooldist,council))"
done


version="04c"
psql -d ${database} -f schemas/${version}.sql 

for i in ${pluto_root}${version}/*.txt; do
    cat $i | perl -pe 's/\x00//g' | 
        python3 remove_whitespace.py |
        psql -d ${database} -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
done


# Add BBL to 03c & 04c
for table in  pluto_03c pluto_04c; do
    psql -d ${database} -c "alter table "${table}" add column bbl char(10)"
    psql -d ${database} -c "UPDATE "${table}" SET bbl = BoroCode || lpad(cast(block as text), 5, '0') || lpad(cast(lot as text), 4, '0')"
done

version="05d"
psql -d ${database} -f schemas/${version}.sql 

for i in ${pluto_root}${version}/*.txt; do
    cat $i | perl -pe 's/\x00//g' | 
        python3 remove_whitespace.py |
        psql -d ${database} -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
done


version="06c"
psql -d ${database} -f schemas/${version}.sql 

for i in ${pluto_root}${version}/*.TXT; do
     cat $i | perl -pe 's/\x00//g' | 
         python3 remove_whitespace.py |
         psql -d ${database} -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (instregion,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
done


version="07c"
psql -d ${database} -f schemas/${version}.sql 

for i in ${pluto_root}${version}/*.TXT; do
    cat $i | perl -pe 's/\x00//g' | 
        python3 remove_whitespace.py |
        psql -d ${database} -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
done


version="09v2"
psql -d ${database} -f schemas/${version}.sql 

for i in ${pluto_root}${version}/*.txt; do
    cat $i | perl -pe 's/\x00//g' | 
        python3 remove_whitespace.py |
        psql -d ${database} -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
done


version="10v2"
psql -d ${database} -f schemas/${version}.sql 

for i in ${pluto_root}${version}/*.txt; do
    cat $i | perl -pe 's/\x00//g' | 
        python3 remove_whitespace.py |
        psql -d ${database} -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
done


version="11v2"
psql -d ${database} -f schemas/${version}.sql 

for i in ${pluto_root}${version}/*.txt; do
    cat $i | 
        python3 remove_whitespace.py |
        psql -d ${database} -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
done


version="12v2"
psql -d ${database} -f schemas/${version}.sql 

for i in ${pluto_root}${version}/*.txt; do
    cat $i | 
        python3 remove_whitespace.py |
        psql -d ${database} -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
done


version="13v2"
psql -d ${database} -f schemas/${version}.sql 

for i in ${pluto_root}${version}/*.csv; do
    cat $i | 
        python3 remove_whitespace.py |
        psql -d ${database} -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
done


version="14v2"
psql -d ${database} -f schemas/${version}.sql 

for i in ${pluto_root}${version}/*.csv; do
    cat $i | 
        python3 remove_whitespace.py |
        psql -d ${database} -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
done


version="15v1"
psql -d ${database} -f schemas/${version}.sql 

for i in ${pluto_root}${version}/*.csv; do
    cat $i | 
        python3 remove_whitespace.py |
        python3 addLatLng.py 72 73 | 
        psql -d ${database} -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (cd,appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council, lng, lat))"
done

version="16v1"
psql -d ${database} -f schemas/${version}.sql 

for i in ${pluto_root}${version}/*.csv; do
    cat $i | 
        python3 remove_whitespace.py |
        python3 addLatLng.py 75 76 | 
        psql -d ${database} -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (cd,appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council,lng,lat,sanitdistrict))"
done
