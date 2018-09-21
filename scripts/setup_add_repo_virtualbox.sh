#!/bin/bash

# REFERENCES: https://www.virtualbox.org/wiki/Linux_Downloads

DISTRO="$(lsb_release -c -s)"
DEBUG_PPA=0
ADD_KEYS=1


## ADD ORACLE PACKAGE SIGNING KEYS
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

if [ $DEBUG_PPA == 1 ]; then
  echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $DISTRO contrib"
else
  echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $DISTRO contrib" >> /etc/apt/
fi


# DEBUG PACKAGE LISTS TO CHECK YOU HAVE THE RIGHT ONES
if [ $DEBUG_PKG_VER == 2 ]; then
    ## DUMP PACKAGE LIST TO VERIFY
    apt-cache pkgnames virtualbox | sort
fi


unset DEBUG_PPA
unset ADD_KEYS

