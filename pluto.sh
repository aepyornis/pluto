#!/bin/bash

print_pluto_version () {
    local blue=$(tput setaf 4)
    local normal=$(tput sgr0)
    printf "${blue}PLUTO ${version} ${normal}\n"
}

source ./pg_setup.sh
source venv/bin/activate

version="03c"
print_pluto_version
execute_sql schemas/${version}.sql 

for i in ${pluto_root}${version}/*.TXT; do
    cat $i | perl -pe 's/\x00//g' | 
        python3 remove_whitespace.py |
        execute_sql_cmd "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (LandUse,splitzone,irrlotcode,cornerlot,xcoord,ycoord,schooldist,council))"
done


version="04c"
print_pluto_version
execute_sql schemas/${version}.sql 

for i in ${pluto_root}${version}/*.txt; do
    cat $i | perl -pe 's/\x00//g' | 
        python3 remove_whitespace.py |
        execute_sql_cmd "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
done


# Add BBL to 03c & 04c
for table in  pluto_03c pluto_04c; do
    execute_sql_cmd "alter table "${table}" add column bbl char(10)"
    execute_sql_cmd "UPDATE "${table}" SET bbl = BoroCode || lpad(cast(block as text), 5, '0') || lpad(cast(lot as text), 4, '0')"
done

version="05d"
print_pluto_version
execute_sql schemas/${version}.sql 

for i in ${pluto_root}${version}/*.txt; do
    cat $i | perl -pe 's/\x00//g' | 
        python3 remove_whitespace.py |
        execute_sql_cmd "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
done


version="06c"
print_pluto_version
execute_sql schemas/${version}.sql 

for i in ${pluto_root}${version}/*.TXT; do
     cat $i | perl -pe 's/\x00//g' | 
         python3 remove_whitespace.py |
         execute_sql_cmd "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (instregion,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
done


version="07c"
print_pluto_version
execute_sql schemas/${version}.sql 

for i in ${pluto_root}${version}/*.TXT; do
    cat $i | perl -pe 's/\x00//g' | 
        python3 remove_whitespace.py |
        execute_sql_cmd "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
done


version="09v2"
print_pluto_version
execute_sql schemas/${version}.sql 

for i in ${pluto_root}${version}/*.txt; do
    cat $i | perl -pe 's/\x00//g' | 
        python3 remove_whitespace.py |
        execute_sql_cmd "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
done


version="10v2"
print_pluto_version
execute_sql schemas/${version}.sql 

for i in ${pluto_root}${version}/*.txt; do
    cat $i | perl -pe 's/\x00//g' | 
        python3 remove_whitespace.py |
        execute_sql_cmd "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
done


version="11v2"
print_pluto_version
execute_sql schemas/${version}.sql 

for i in ${pluto_root}${version}/*.txt; do
    cat $i | 
        python3 remove_whitespace.py |
        execute_sql_cmd "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
done


version="12v2"
print_pluto_version
execute_sql schemas/${version}.sql 

for i in ${pluto_root}${version}/*.txt; do
    cat $i | 
        python3 remove_whitespace.py |
        execute_sql_cmd "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
done


version="13v2"
print_pluto_version
execute_sql schemas/${version}.sql 

for i in ${pluto_root}${version}/*.csv; do
    cat $i | 
        python3 remove_whitespace.py |
        execute_sql_cmd "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
done


version="14v2"
print_pluto_version
execute_sql schemas/${version}.sql 

for i in ${pluto_root}${version}/*.csv; do
    cat $i | 
        python3 remove_whitespace.py |
        execute_sql_cmd "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
done


version="15v1"
print_pluto_version
execute_sql schemas/${version}.sql 

for i in ${pluto_root}${version}/*.csv; do
    cat $i | 
        python3 remove_whitespace.py |
        python3 addLatLng.py 72 73 | 
        execute_sql_cmd "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (cd,appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council, lng, lat))"
done

version="16v1"
print_pluto_version
execute_sql schemas/${version}.sql 

for i in ${pluto_root}${version}/*.csv; do
    cat $i | 
        python3 remove_whitespace.py |
        python3 addLatLng.py 75 76 | 
        execute_sql_cmd "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (cd,appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council,lng,lat,sanitdistrict))"
done

version="16v2"
print_pluto_version
execute_sql schemas/${version}.sql 

for i in ${pluto_root}${version}/*.csv; do
    cat $i | 
        python3 remove_whitespace.py |
	python3 pluto_16v2_helper.py |
        python3 addLatLng.py 73 74 | 
        execute_sql_cmd "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (cd,appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council,lng,lat,sanitdistrict))"
done


deactivate
