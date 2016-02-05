#!/bin/bash

MARIADB_PATH="/home/mysql"

# Copy default config files
if [ "`ls -A /opt/config`" != "" ]; then
  \cp -frp /opt/config/mysql/my.cnf /etc/my.cnf
  rm -rf /opt/config
fi

if [ "`ls -A ${MARIADB_PATH}`" = "" ]; then
  \cp -rp /var/lib/mysql/* ${MARIADB_PATH}/
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

