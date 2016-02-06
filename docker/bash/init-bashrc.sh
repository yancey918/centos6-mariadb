#!/bin/bash

MARIADB_PATH="/home/mysql"

MKDIR="$(which mkdir)"
RM="$(which rm)"
MV="$(which mv)"


# Check Service to start
function service_start()
{
  for SERVICE in mysql sshd
  do
    if ps ax | grep -v grep | grep $SERVICE > /dev/null
    then
       #echo "service $SERVICE runing";
       break;
    else
       service $SERVICE start;
    fi
  done
}


if [ "`ls -A ${MARIADB_PATH}`" = "" ]; then
  \cp -rp /var/lib/mysql/* ${MARIADB_PATH}/
fi


# Copy default config files
test -d "/opt/config" && \
\cp -frp /opt/config/mysql/my.cnf /etc/my.cnf && \
service_start && \
rm -rf /opt/config
