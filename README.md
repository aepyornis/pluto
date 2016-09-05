# pluto
Pluto -> Postgres

Download pluto files from city planning --  http://www1.nyc.gov/site/planning/data-maps/open-data/pluto-mappluto-archive.page -- and put them in a directory.

Unzip the files: ``` python3 unzip.py /path/to/pluto/zips ```

Setup a virtualenv with python3 and activate it:

```
pyvenv venv
source venv/bin/activate
```

Clone the [pyproj repo](https://github.com/jswhit/pyproj.git) & install pyproj:

```
pip install cython
git clone https://github.com/jswhit/pyproj.git
cd pyproj
python3 setup.py build
python3 setup.py install
```

Change the database and directory path at the top of of pluto.sh:

``` 
pluto_root="/path/to/pluto"
database="plutodb"

```
Run it: ``` ./pluto.sh ```


Notes:

- Only pluto versions 15v1 & 16v1 have Lat & Lng.
- No indexes are created
