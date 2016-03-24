import util
import psycopg2
import os
import sys
import csv
import glob
import copy
from reproject import reproject

db_connection_string = os.environ['PLUTO_DB_CONNECTION']
csv_dir = sys.argv[1]

conn = psycopg2.connect(db_connection_string)
cur = conn.cursor()

total = 0
field_errors = 0
errors = []

lookup, headers = util.sql_type_dir('schema.sql')


def csv_file_list(dir):
    return glob.glob(dir + '/*.csv')


def handle_field_error(row, key, e):
    global field_errors
    print(key + " - " + str(row[key]))
    print(e)
    field_errors += 1
    row[key] = None


def insert_row(r):
    row = copy.copy(r)
    global lookup
    for key in row:
        try:
            row[key] = util.type_cast(key, row[key], lookup)
        except (util.TypeCastError, ValueError, AttributeError) as e:
            handle_field_error(row, key, e)

    if row['XCoord'] is None or row['YCoord'] is None:
        row['lng'], row['lat'] = (None, None)
    else:
        row['lng'], row['lat'] = reproject(row['XCoord'], row['YCoord'])

    query, data = util.make_query('pluto', row)

    try:
        cur.execute(query, data)
    except Exception as e:
        print("Inserting Row error with: " + str(row))
        raise


def copy_data(csv_file, headers):
    global errors
    with open(csv_file, 'r') as f:
        next(f)  # skip first row
        csvreader = csv.DictReader(f, fieldnames=headers)
        for row in csvreader:
            try:
                insert_row(row)
                conn.commit()
                global total
                total += 1
            except Exception as e:
                errors.append(row)
                raise


if __name__ == "__main__":
    util.create_table(cur, 'pluto')
    for csv_file in csv_file_list(csv_dir):
        print('processing ' + csv_file)
        copy_data(csv_file, headers)
    print('total inserted: ' + str(total))
    print('lines with errors: ' + str(len(errors)))

    if len(errors) > 0:
        with open('problem_lines.csv', 'w') as f:
            for line in errors:
                f.write(str(line) + "\n")
        print('problem_lines.csv saved!')
