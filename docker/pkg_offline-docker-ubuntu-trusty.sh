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
for i in $(apt-cache depends docker-ce | grep -E 'Depends|Recommends|Suggests' | cut -d ':' -f 2,3 | sed -e s/'<'/''/ -e s/'>'/''/); do apt-get download $i 2>>errors.txt; done
apt-get download docker-ce
rm git*.deb

cd ..
mv ./install-ubuntu-14.04.sh install.sh
mv ./readme-ubuntu-14.04.txt readme.txt
tar cvzf offline-docker-ubuntu.tar.gz ./offline-docker-ubuntu ./install.sh ./readme.txt

