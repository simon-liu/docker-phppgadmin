FROM ubuntu:12.04

MAINTAINER liuzenglu <zenglu.liu@gmail.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

# Install sshd
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# Set password to 'admin'
RUN printf admin\\nadmin\\n | passwd

# Install Apache
RUN apt-get install -y apache2
# Install php
RUN apt-get install -y php5 libapache2-mod-php5 php5-mcrypt

# Install phpMyAdmin
RUN service apache2 start; \
	sleep 5; \
	printf y\\n\\n\\n1\\n | apt-get install -y phppgadmin

EXPOSE 22
EXPOSE 80

CMD service apache2 start; \
	/usr/sbin/sshd -D

# docker run -d -p 49160:22 -p 49161:80 simon-liu/docker-phppgadmin
