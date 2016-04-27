#!/bin/bash

# createdb pluto

pluto_root="/home/michael/data/pluto/"

# psql -d pluto -f schemas/03c.sql 

# for i in /home/michael/data/pluto/03c/*.TXT; do
#     cat $i | perl -pe 's/\x00//g' | 
#         python remove_whitespace.py |
#         psql -d pluto -c "COPY pluto_03c FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (LandUse,splitzone,irrlotcode,cornerlot,xcoord,ycoord,schooldist,council))"
# done


# psql -d pluto -f schemas/04c.sql 

# for i in /home/michael/data/pluto/04c/*.txt; do
#     cat $i | perl -pe 's/\x00//g' | 
#         python remove_whitespace.py |
#         psql -d pluto -c "COPY pluto_04c FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
# done

# psql -d pluto -f schemas/05d.sql 

# for i in /home/michael/data/pluto/05d/*.txt; do
#     cat $i | perl -pe 's/\x00//g' | 
#         python remove_whitespace.py |
#         psql -d pluto -c "COPY pluto_05d FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
# done


# version="06c"
# psql -d pluto -f schemas/${version}.sql 

# for i in ${pluto_root}${version}/*.TXT; do
#      cat $i | perl -pe 's/\x00//g' | 
#          python remove_whitespace.py |
#          psql -d pluto -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (instregion,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
# done

# version="07c"
# psql -d pluto -f schemas/${version}.sql 

# for i in ${pluto_root}${version}/*.TXT; do
#     cat $i | perl -pe 's/\x00//g' | 
#         python remove_whitespace.py |
#         psql -d pluto -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
# done

# version="09v2"
# psql -d pluto -f schemas/${version}.sql 

# for i in ${pluto_root}${version}/*.txt; do
#     cat $i | perl -pe 's/\x00//g' | 
#         python remove_whitespace.py |
#         psql -d pluto -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
# done

# version="10v2"
# psql -d pluto -f schemas/${version}.sql 

# for i in ${pluto_root}${version}/*.txt; do
#     cat $i | perl -pe 's/\x00//g' | 
#         python remove_whitespace.py |
#         psql -d pluto -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
# done

# version="11v2"
# psql -d pluto -f schemas/${version}.sql 

# for i in ${pluto_root}${version}/*.txt; do
#     cat $i | perl -pe 's/\x00//g' | 
#         python remove_whitespace.py |
#         psql -d pluto -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
# done

# version="12v2"
# psql -d pluto -f schemas/${version}.sql 

# for i in ${pluto_root}${version}/*.txt; do
#     cat $i | perl -pe 's/\x00//g' | 
#         python remove_whitespace.py |
#         psql -d pluto -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
# done

# version="13v2"
# psql -d pluto -f schemas/${version}.sql 

# for i in ${pluto_root}${version}/*.csv; do
#     cat $i | perl -pe 's/\x00//g' | 
#         python remove_whitespace.py |
#         psql -d pluto -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
# done

# version="14v2"
# psql -d pluto -f schemas/${version}.sql 

# for i in ${pluto_root}${version}/*.csv; do
#     cat $i | 
#         python remove_whitespace.py |
#         psql -d pluto -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
# done


version="15v1"
psql -d pluto -f schemas/${version}.sql 

for i in ${pluto_root}${version}/*.csv; do
    cat $i | 
        python remove_whitespace.py |
        psql -d pluto -c "COPY pluto_"${version}" FROM STDIN WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (cd,appdate,LandUse,splitzone,irrlotcode,xcoord,ycoord,schooldist,council))"
done
