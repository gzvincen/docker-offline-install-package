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

yumdownloader -x '*i686' --destdir=offline-docker-centos audit device-mapper device-mapper-event device-mapper-event-libs device-mapper-libs device-mapper-persistent-data dracut dracut-network dracut-config-rescue glib2 initscripts kmod libaio libgudev1 libsepol lvm2 lvm2-libs systemd systemd-libs systemd-sysv
\rm ./install.sh ./readme.txt
mv ./install-7.3-below.sh ./install.sh
mv ./readme-centos-7.1-7.2.txt ./readme.txt
tar cvzf offline-docker-centos-7.1-7.2.tar.gz ./offline-docker-centos ./install.sh ./readme.txt

\rm ./offline-docker-centos/*
yumdownloader --resolve --destdir=offline-docker-centos docker-ce-17.09.1.ce-1.el7.centos
yumdownloader -x '*i686' --destdir=offline-docker-centos audit device-mapper device-mapper-event device-mapper-event-libs device-mapper-libs device-mapper-persistent-data dracut dracut-network dracut-config-rescue glib2 initscripts kmod libaio libgudev1 libsepol lvm2 lvm2-libs systemd systemd-libs systemd-sysv
\rm ./readme.txt
mv ./readme-centos-7.0.txt ./readme.txt
tar cvzf offline-docker-centos-7.0.tar.gz ./offline-docker-centos ./install.sh ./readme.txt

