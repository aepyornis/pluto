#!/bin/bash

python3 -m venv venv
source venv/bin/activate

pip3 install cython

git clone https://github.com/jswhit/pyproj.git
cd pyproj
python3 setup.py build
python3 setup.py install
