#!/bin/bash

# system has come up but its likely nginx and apache are not running
# because of non-existent directories specified in the config files
# create the directories below

EBSHOME=/opt/ebs1/home
if [ -d $EBSHOME/ssl ]; then
  sudo ln -s $EBSHOME/ssl /home/ssl
else
  echo "$EBSHOME/ssl is missing, is the volume mounted?"
  exit 0
fi

if [ -d $EBSHOME/apps ]; then
  sudo ln -s $EBSHOME/apps /home/apps
else
  echo "$EBSHOME/apps is missing, is the volume mounted?"
  exit 0
fi

if [ -d $EBSHOME/rails ]; then
  sudo ln -s $EBSHOME/rails /home/rails
else
  echo "$EBSHOME/rails is missing.. aborting"
  exit 0
fi


# restart the servers
sudo /etc/init.d/apache2 start
sudo /etc/init.d/nginx start
