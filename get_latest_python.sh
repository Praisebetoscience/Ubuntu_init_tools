#!/bin/bash
add-apt-repository ppa:fkrull/deadsnakes
apt-get update
apt-get -y install python3.5
apt-get -y install python3-pip
apt-get -y install python-pip
cp pip.conf /etc/
pip3 install --upgrade pip setuptools
apt-get -y install python3-venv
