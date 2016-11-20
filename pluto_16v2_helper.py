"""
This version of pluto contain some integer fields that have '.00' appended to the end of them.
This script removes the '.00'.
"""
import sys
import csv

csvreader = csv.reader(sys.stdin, delimiter=',', quotechar='"')
csvwriter = csv.writer(sys.stdout, delimiter=',', quotechar='"', quoting=csv.QUOTE_ALL)

# AssessLand, AccessTotal,ExemptLand, ExemptTotal, BBL, appbbl
int_columns = [56, 57, 58, 59, 70, 80]

for row in csvreader:
    new_row = row
    for col in int_columns:
        new_row[col] = row[col].replace(".00", "")
    csvwriter.writerow(new_row)
