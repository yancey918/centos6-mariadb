FROM centos:centos6
MAINTAINER Imagine Chiu<imagine10255@gmail.com>


ENV SSH_ROOT_PASSWORD=P@ssw0rd

# Install base tool
RUN yum -y install vim tar


# Install SSH Service
RUN yum install -y openssh-server passwd
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config && \
    echo "${SSH_ROOT_PASSWORD}" | passwd "root" --stdin

RUN echo -e "[mariadb]" >> /etc/yum.repos.d/MariaDB.repo && \
    echo -e "name = MariaDB" >> /etc/yum.repos.d/MariaDB.repo && \
    echo -e "baseurl = http://yum.mariadb.org/10.0/centos6-amd64" >> /etc/yum.repos.d/MariaDB.repo && \
    echo -e "gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB" >> /etc/yum.repos.d/MariaDB.repo && \
    echo -e "gpgcheck=1" >> /etc/yum.repos.d/MariaDB.repo

RUN yum -y install MariaDB-Galera-server MariaDB-client galera

# Copy files for setting
ADD ./docker /opt/


RUN $(which cp) /usr/share/mysql/my-medium.cnf /etc/my.cnf.bak && \
    $(which cp) /usr/share/mysql/wsrep.cnf /etc/my.cnf.d/ && \
    $(which cp) -frp /opt/config/mysql/my.cnf /etc/my.cnf && \
    $(which cp) -frp /var/lib/mysql /home/mysql


# Create Base Enter Cont Command
RUN chmod 755 /opt/bash/init-bashrc.sh && echo "/opt/bash/init-bashrc.sh" >> /root/.bashrc && \
    echo 'export PATH="/root/.composer/vendor/bin:$PATH"' >> /root/.bashrc


# Setting DateTime Zone
RUN cp -p /usr/share/zoneinfo/Asia/Taipei /etc/localtime


# Setup default path
WORKDIR /home


# Private expose
EXPOSE 3306 22


# Volume for web server install
VOLUME ["/home/mysql","/home/tmp"]


# Start run shell
CMD ["bash"]

