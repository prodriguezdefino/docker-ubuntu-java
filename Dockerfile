## Ubuntu Java8 Base image
#
FROM ubuntu:14.04
MAINTAINER prodriguezdefino prodriguezdefino@gmail.com

# Setup a volume for data
VOLUME ["/data"]

# Set correct source list
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty-updates main universe" >> /etc/apt/sources.list

# add the python properties so we can add repos afterwards and also the utility to auto-accept licenses, some dev tools too
RUN apt-get update && apt-get upgrade -y && apt-get install -y software-properties-common debconf-utils rsync openssh-server net-tools vim-tiny sudo iputils-ping python2.7 less curl

# passwordless ssh
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# auto-acept oracles jdk license
RUN /bin/echo -e oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections

# add JDK8 repository
RUN add-apt-repository ppa:webupd8team/java

# install Oracle JDK 8
RUN apt-get update && apt-get upgrade -y --force-yes && apt-get install -y --force-yes oracle-java8-installer  

# set java environment variables
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV PATH $PATH:$JAVA_HOME/bin

