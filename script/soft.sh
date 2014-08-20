#!/bin/bash

apt-get -y install software-properties-common python-software-properties
add-apt-repository ppa:webupd8team/java
apt-get update
apt-get -y upgrade

echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
apt-get -y install oracle-java8-installer
apt-get clean
update-alternatives --display java

apt-get -y install vim mysql-client wget tcpdump sshpass htop python-pip ansible
pip install -U fig

wget -O - http://gaudi.io/apt/gaudi.gpg.key | sudo apt-key add -
echo "deb http://gaudi.io/apt/ precise main" | sudo tee -a /etc/apt/sources.list

apt-get update
apt-get install gaudi -y

# Apache Mesos
apt-get install python-dev python-boto libcurl4-nss-dev libsasl2-dev autoconf libtool
