from pyproj import *

p4j = '+proj=lcc +lat_1=40.66666666666666 +lat_2=41.03333333333333 +lat_0=40.16666666666666 +lon_0=-74 +x_0=300000 +y_0=0 +datum=NAD83 +units=us-ft +no_defs '

ny_state_plane = Proj(p4j)
wgs84 = Proj(init="epsg:4326")


def reproject(xcoord, ycoord):
    return transform(ny_state_plane, wgs84, xcoord, ycoord)
