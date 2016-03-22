import re
import decimal
import datetime

class TypeCastError(TypeError):
    pass

# string -> int
def char_num(datatype):
    m = re.match("char\(([0-9]+)\)", datatype)
    if m:
        return int(m.group(1))
    else:
        raise Exception("datatype failed to match char regex: " + datatype)


def line_boolean(line):
    if 'char' in line:
        return True
    elif '(' in line:
        return False
    elif ')' in line:
        return False
    else:
        return True


# string -> (dict, list)
def sql_type_dir(sql_file):
    d = {}
    headers = []
    with open(sql_file, 'r') as f:
        for line in f:
            if line_boolean(line):
                key = line.strip().replace(',', '').split(' ')[0]
                val = ' '.join(line.strip().replace(',', '').split(' ')[1:])
                d[key] = val
                headers.append(key)
    return (d, headers)

def create_table(cur, tablename):
    cur.execute('DROP TABLE IF EXISTS ' + tablename)
    with open('schema.sql', 'r') as f:
        sql = f.read()
        cur.execute(sql)


def char_error(value, datatype):
    error_message = 'Schema Mismatch. ' + value + ' is ' + str(len(value)) + ' chars long. Excepted it to be ' + str(char_num(datatype))
    raise TypeCastError(error_message)

# input format: mm/dd/yyyy
# datetime.date(year, month, day)
def date_format(datestring):
    month, day, year =  [int(x) for x in datestring.split('/')]
    return datetime.date(year, month, day)


def type_cast(key, val, lookup):
    datatype = lookup[key].strip()
    value = val.strip()
    if value == '':
        return None
    elif key == 'APPBBL' and value == '0':
        return None
    elif datatype == 'text':
        return value
    elif 'char' in datatype:
        if len(value) == char_num(datatype):
            return value
        else:
            char_error(value, datatype)
    elif datatype in ['integer', 'bigint', 'smallint']:
        return int(value)
    elif datatype == 'money':
        return value.replace('$', '')
    elif datatype == 'boolean':
        return bool(value)
    elif datatype == 'date':
        return date_format(value)
    elif datatype == 'numeric':
        return decimal.Decimal(value)
    else:
        raise Exception('Type Cast Error - Unknown datatype - ' + datatype)


def skip(lines, f):
    for x in range(lines):
        next(f)


def placeholders(num):
    text = '('
    for x in range(num):
        if x < (num - 1):
            text += '%s, '
        else:
            text += '%s)'

    return text


def make_query(tablename, row):
    fieldnames = []
    values = []
    for key in row:
        fieldnames.append(key)
        values.append(row[key])
    query = "INSERT INTO " + tablename + " " + str(tuple(fieldnames))
    query += " values " + placeholders(len(fieldnames))
    query = query.replace("'", "")
    return (query, tuple(values))
