#!/bin/bash

MARIADB_PATH="/home/config/"
MARIADB_DATA="/home/mysql/"

# Create base dir
mkdir -p $MARIADB_PATH


# Copy default config files
if [ "`ls -A $CONF_PATH`" = "" ]; then
  \cp -fr /opt/docker/config/* $CONF_PATH
fi

if [ "`ls -A $MARIADB_DATA`" = "" ]; then
  \cp -r /var/lib/mysql/ ${MARIADB_DATA}
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
