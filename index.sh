#!/bin/bash

pg_index () {
    psql -d pluto -c "create index on ${1} ${2}"
} 


for v in 03c 04c 05d 06c 07c 09v2 10v2 11v2 12v2 13v2 14v2 15v1; do
    table=pluto_${v}
    echo "indexing ${table}"

    pg_index ${table} "(bbl)"
    pg_index ${table} "(BldgClass)"
    pg_index ${table} "(ZoneDist1)"
    pg_index ${table} "(UnitsRes)"
    pg_index ${table} "(LandUse)"
    pg_index ${table} "(CD)"
    pg_index ${table} "(AccessTotal DESC)"

done

