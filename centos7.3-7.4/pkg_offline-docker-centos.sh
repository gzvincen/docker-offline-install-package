#!/bin/bash

mkdir offline-docker-centos
chmod -R 777 offline-docker-centos

curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum makecache
#yum update -y
#yum remove -y fakesystemd
yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum list docker-ce --showduplicates | sort -r

yumdownloader --resolve --destdir=offline-docker-centos docker-ce
yumdownloader -x '*i686' --destdir=offline-docker-centos audit
mv ./install-7.3-above.sh ./install.sh
mv ./readme-centos-7.3-7.4.txt ./readme.txt
tar cvzf offline-docker-centos-7.3-7.4.tar.gz ./offline-docker-centos ./install.sh ./readme.txt

