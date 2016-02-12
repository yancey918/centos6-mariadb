#!/bin/bash

MYSQL_DATA_PATH=/home/mysql
MYSQL_ROOT_PASSWORD=P@ssw0rd
MYSQL_PASSWORD_CHECK=0

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
if [ -f "/usr/share/mysql/my-medium.cnf" ]; then
    echo "move my-medium.cnf /etc/my.cnf.bak"
    mv -f /usr/share/mysql/my-medium.cnf /etc/my.cnf.bak
fi


if [ -f "/usr/share/mysql/wsrep.cnf" ]; then
    echo "move wsrep.cnf /etc/my.cnf.d/wsrep.cnf"
    mv -f /usr/share/mysql/wsrep.cnf /etc/my.cnf.d/wsrep.cnf
fi


if [ -f "/opt/config/mysql/my.cnf" ]; then
    echo "move default custom config /etc/my.cnf"
    mv -f /opt/config/mysql/my.cnf /etc/my.cnf

    chown -R mysql.mysql /var/lib/mysql
    chown -R mysql.mysql ${MYSQL_DATA_PATH}
fi


if [ "`ls -A $MYSQL_DATA_PATH`" = "" ]; then
    echo "${MYSQL_DATA_PATH} not database files, run copy default database files to here"
    cp -frp /var/lib/mysql/* $MYSQL_DATA_PATH/

    service_start
    mysqladmin -uroot password ${MYSQL_ROOT_PASSWORD}
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e"GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;flush privileges;"
else
    service_start
fi
