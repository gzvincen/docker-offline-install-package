#!/bin/bash

mkdir offline-docker-ubuntu
chmod -R 777 offline-docker-ubuntu

apt-get update
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    apt-rdepends \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-cache madison docker-ce

cd offline-docker-ubuntu
apt-get download $(apt-rdepends docker-ce|grep -v "^ ")

cd ..
mv ./install-ubuntu-16.04-newer.sh ./install.sh
mv ./readme-ubuntu-16.04-newer.txt ./readme.txt
tar cvzf offline-docker-ubuntu.tar.gz ./offline-docker-ubuntu ./install.sh ./readme.txt

