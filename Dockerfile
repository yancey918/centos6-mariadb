FROM centos:centos6
MAINTAINER Imagine Chiu<imagine10255@gmail.com>


ENV SSH_PASSWORD=P@ssw0rd


# Install base tool
RUN yum -y install vim wget tar


# Install develop tool
RUN yum -y groupinstall development


# Install SSH Service
RUN yum install -y openssh-server passwd
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config && \
    echo "${SSH_PASSWORD}" | passwd "root" --stdin


# Copy files for setting
ADD . /opt/


# Create Base Enter Cont Command
RUN chmod 755 /opt/docker/bash/init-bashrc.sh && echo "/opt/docker/bash/init-bashrc.sh" >> /root/.bashrc && \
    echo 'export PATH="/root/.composer/vendor/bin:$PATH"' >> /root/.bashrc


# Install Mariadb and Start(http://blog.xuite.net/hankohya34/blog/212032955-MariaDB+Cluster+%E8%A8%AD%E5%AE%9A)
# /usr/bin/mysql_secure_installation
RUN cp -p /opt/docker/bash/MariaDB.repo /etc/yum.repos.d/MariaDB.repo
RUN yum -y install MariaDB-Galera-server MariaDB-client galera
RUN mv /etc/my.cnf /etc/my.bak && \
    cp /usr/share/mysql/my-medium.cnf /etc/my.cnf && \
    cp /usr/share/mysql/wsrep.cnf /etc/my.cnf.d/
RUN cp -p /var/lib/mysql /home/mysql


# Setting DateTime Zone
RUN cp -p /usr/share/zoneinfo/Asia/Taipei /etc/localtime


# Setup default path
WORKDIR /home


# Private expose
EXPOSE 3306


# Volume for web server install
VOLUME ["/home"]


# Start run shell
CMD ["bash"]

