from pyproj import *
import sys
import csv

x_col = int(sys.argv[1])
y_col = int(sys.argv[2])

p4j = '+proj=lcc +lat_1=40.66666666666666 +lat_2=41.03333333333333 +lat_0=40.16666666666666 +lon_0=-74 +x_0=300000 +y_0=0 +datum=NAD83 +units=us-ft +no_defs '

ny_state_plane = Proj(p4j, preserve_units=True)

wgs84 = Proj(init="epsg:4326")

# (X,Y) -> (Lng, Lat)
def reproject(xcoord, ycoord):
    return transform(ny_state_plane, wgs84, xcoord, ycoord)

if __name__ == "__main__":
    csvreader = csv.reader(sys.stdin, delimiter=',', quotechar='"')
    csvwriter = csv.writer(sys.stdout, delimiter=',', quotechar='"', quoting=csv.QUOTE_ALL)
    for row in csvreader:
        x = row[x_col]
        y = row[y_col]
        if x == 'XCoord' and y == 'YCoord':
            row.append('lng')
            row.append('lat')
        elif x == '' or y == '':
            row.append('')
            row.append('')
        else:
            lng, lat = reproject(float(x),float(y))
            row.append(lng)
            row.append(lat);
                    
        csvwriter.writerow(row)


