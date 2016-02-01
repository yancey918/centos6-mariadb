#!/bin/bash

# Backup Nginx
\cp -fr /etc/php.ini /home/wwwconfig/php.ini 
\cp -fr /etc/nginx/nginx.conf /home/config/nginx/nginx.conf 
\cp -fr /etc/nginx/plugins/* /home/config/nginx/plugins/
\cp -fr /etc/nginx/sites-enabled/* /home/config/virtualhost/


# Backup supervisor
\cp -fr /etc/supervisord.conf /home/config/supervisord.conf 


# Backup SSH
if [ -f "/root/.ssh/id_rsa.pub" ]; then
  \cp -fr /root/.ssh/id_rsa.pub /home/config/ssh-key/
fi

if [ -f "/root/.ssh/id_rsa" ]; then
  \cp -fr /root/.ssh/id_rsa /home/config/ssh-key/
fi


echo "Backup Finish"