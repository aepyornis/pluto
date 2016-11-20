#!/bin/bash

# The path to the pluto directory
# tailing slash is required here!
pluto_root="/path/to/pluto/directory/"  

export PGPASSWORD=YOURPGPASSWORD

# The two functions are used to execute a sql file and sql command in pluto.sh
# Customize them according to how postgres is setup on your computer.
# If running postgres locally this might be as simple as:
# execute_sql () {
#     psql -d dbname -f $1
# }

# execute_sq_cmd () {
#     psql -d dbname --command $1
# }

# example:
execute_sql () {
 psql -h 127.0.0.1 -d pluto -U postgres  -f $1
}

execute_sql_cmd () {
 psql -h 127.0.0.1 -d pluto -U postgres --command "$1"
}

