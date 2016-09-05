"""
Unzips all pluto zips
use: python3 /path/to/folder/with/pluto/zips
"""
import os
import sys
import re
import subprocess

directory = sys.argv[1]

def pluto_version(f):
    return re.compile("pluto_(.+)\.zip").search(f).group(1)

# assumes that only the pluto zip files are the only files in the directory
for f in os.listdir(directory):
    pluto_dir = os.path.join(directory, pluto_version(f))
    os.mkdir(pluto_dir)
    fullpath = os.path.join(directory, f)
    subprocess.call(['unzip', fullpath, '-d', pluto_dir])
