#!/bin/bash

MYSQL_DATA_PATH="/home/mysql"
MYSQL_ROOT_PASSWORD=P@ssw0rd

MKDIR="$(which mkdir)"
RM="$(which rm)"
MV="$(which mv)"
SH="$(which sh)"
CP="$(which cp)"

# Check Service to start
function service_start()
{
  for SERVICE in mysql sshd
  do
    if ! (ps ax | grep -v grep | grep $SERVICE > /dev/null)
    then
       service $SERVICE start;
    fi
  done
}


# Check & Copy DB Files
if [ "`ls -A $MYSQL_DATA_PATH`" = "" ]; then
  echo "$DIRECTORY not database files, run copy default database files to here"
  $CP -rp /var/lib/mysql/* $MYSQL_DATA_PATH/
  $(which service) mysql start
  $(which mysqladmin) -uroot password ${MYSQL_ROOT_PASSWORD}
  $(which mysql) -uroot -p${MYSQL_ROOT_PASSWORD} -e"GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;flush privileges;"
fi

service_start
