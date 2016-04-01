#!/bin/bash
add-apt-repository ppa:fkrull/deadsnakes
apt-get update
apt-get -y install python3.5
apt-get -y install python3-pip
apt-get -y install python-pip
apt-get -y install python-virutalenv
pip install --upgrade pip
pip install --upgrade setuptools
pip install --upgrade wheel
pip install --upgrade virtualenv
