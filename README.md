# pluto
Pluto -> Postgres

First, download pluto files from [city planning](http://www1.nyc.gov/site/planning/data-maps/open-data/pluto-mappluto-archive.page)  and put them in a directory with each directory named for the pluto version: "16v1", "15v1", etc.

See [here](https://github.com/aepyornis/nyc-db/blob/master/download_pluto.sh) for an example on how to download and unzip the files from city planning.

Setup a virtual environment with python3, cython, and pyproj: ``` ./setup.sh ```

Modify ``` pg_setup.sh ``` so that it works with your installation of postgres:

Then run it: ``` ./pluto.sh ```

Notes:

- Only pluto versions 15v1,16v1, & 16v2 have Lat & Lng.
- No indexes are created
