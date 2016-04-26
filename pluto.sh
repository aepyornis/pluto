#!/bin/bash

# createdb pluto

psql -d pluto -f schemas/2003.sql 

for i in /home/michael/data/pluto/*.TXT; do
    cat $i | perl -pe 's/\x00//g' | python remove_whitespace.py > /tmp/pluto.txt
    psql -d pluto -c "COPY pluto_03c FROM '/tmp/pluto.txt' WITH (FORMAT csv, HEADER TRUE, NULL '', FORCE_NULL (LandUse,splitzone,irrlotcode,cornerlot,xcoord,ycoord,schooldist,council))"
    rm /tmp/pluto.txt
done

