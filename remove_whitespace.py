import sys
import csv

if __name__ == "__main__":
    csvreader = csv.reader(sys.stdin, delimiter=',', quotechar='"')
    csvwriter = csv.writer(sys.stdout, delimiter=',', quotechar='"', quoting=csv.QUOTE_ALL)
    for row in csvreader:
        if len(row) > 1:
            csvwriter.writerow([x.strip() for x in row])

