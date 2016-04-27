import sys
import csv


def is_not_all_blank(row):
    return len(list(filter(lambda field: field == '',row))) < 70

if __name__ == "__main__":
    csvreader = csv.reader(sys.stdin, delimiter=',', quotechar='"')
    csvwriter = csv.writer(sys.stdout, delimiter=',', quotechar='"', quoting=csv.QUOTE_ALL)
    for row in csvreader:
        cleaned = [x.strip() for x in row]
        if len(cleaned) > 1 and is_not_all_blank(cleaned):
            csvwriter.writerow(cleaned)


