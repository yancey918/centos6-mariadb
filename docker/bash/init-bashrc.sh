#!/bin/bash

MARIADB_PATH="/home/config/"


# Create base dir
mkdir -p $MARIADB_PATH


# Copy default config files
if [ "`ls -A $CONF_PATH`" = "" ]; then
  \cp -fr /opt/docker/config/* $CONF_PATH
fi


# Check Service to start
for SERVICE in mysql
do
  if ps ax | grep -v grep | grep $SERVICE > /dev/null
  then
     #echo "service $SERVICE runing";
     break;
  else
     service $SERVICE start;
  fi
done
