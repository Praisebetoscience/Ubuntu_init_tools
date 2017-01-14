#!/bin/bash
tempdir=`pwd`
cd ~
git clone https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
cd .vim_runtime
/usr/bin/python3 update_plugins.py
cd $tempdir

