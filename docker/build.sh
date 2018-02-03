#!/bin/bash

#delete all tar.gz file
if (ls offline-docker-ubuntu*.tar.gz) >/dev/null 2>&1;then
  rm -f ./offline-docker-ubuntu*.tar.gz;
fi

if (ls offline-docker-centos*.tar.gz) >/dev/null 2>&1;then
  rm -f ./offline-docker-centos*.tar.gz;
fi

#delete docker containers
docker container rm -f offline-docker-ubuntu
docker container rm -f offline-docker-centos

#make offline docker ubuntu pkg
names="trusty xenial zesty artful"
i=1  
while((1==1))  
do  
        name=`echo $names|cut -d " " -f$i`
        if [ "$name" != "" ]
        then
                echo $name
                
                docker pull ubuntu:$name
                docker container run --name offline-docker-ubuntu -d ubuntu:$name /bin/bash -c "while true; do sleep 1d; done"
                sleep 3
                
                docker cp ./sources.list offline-docker-ubuntu:/etc/apt/sources.list
                docker exec offline-docker-ubuntu /bin/bash -c "sed -i 's/{osname}/$name/g' /etc/apt/sources.list"
                
                if [ $name = "trusty" ]
                then
                        echo "处理ubuntu-trusty，14.04版本"
                        docker cp ./pkg_offline-docker-ubuntu-trusty.sh offline-docker-ubuntu:/opt/pkg_offline-docker-ubuntu-trusty.sh
                        docker cp ./install-ubuntu-14.04.sh offline-docker-ubuntu:/opt/install-ubuntu-14.04.sh
                        docker cp ./readme-ubuntu-14.04.txt offline-docker-ubuntu:/opt/readme-ubuntu-14.04.txt
                        docker exec offline-docker-ubuntu /bin/bash -c "chmod -R 777 /opt/pkg_offline-docker-ubuntu-trusty.sh"
                        docker exec offline-docker-ubuntu /bin/bash -c "cd /opt && /opt/pkg_offline-docker-ubuntu-trusty.sh"
                        docker cp offline-docker-ubuntu:/opt/offline-docker-ubuntu.tar.gz ./
                        mv offline-docker-ubuntu.tar.gz offline-docker-ubuntu-trusty-14.04.tar.gz
                else
                        echo "处理"$name
                        docker cp ./pkg_offline-docker-ubuntu.sh offline-docker-ubuntu:/opt/pkg_offline-docker-ubuntu.sh
                        docker cp ./install-ubuntu-16.04-newer.sh offline-docker-ubuntu:/opt/install-ubuntu-16.04-newer.sh
                        docker cp ./readme-ubuntu-16.04-newer.txt offline-docker-ubuntu:/opt/readme-ubuntu-16.04-newer.txt
                        docker exec offline-docker-ubuntu /bin/bash -c "chmod -R 777 /opt/pkg_offline-docker-ubuntu.sh"
                        docker exec offline-docker-ubuntu /bin/bash -c "cd /opt && /opt/pkg_offline-docker-ubuntu.sh"
                        docker cp offline-docker-ubuntu:/opt/offline-docker-ubuntu.tar.gz ./
                        if [ $name = "xenial" ]
                        then
                              mv offline-docker-ubuntu.tar.gz offline-docker-ubuntu-xenial-16.04.tar.gz
                        fi
                        if [ $name = "zesty" ]
                        then
                              mv offline-docker-ubuntu.tar.gz offline-docker-ubuntu-zesty-17.04.tar.gz
                        fi
                        if [ $name = "artful" ]
                        then
                              mv offline-docker-ubuntu.tar.gz offline-docker-ubuntu-artful-17.10.tar.gz
                        fi
                fi
                docker container rm -f offline-docker-ubuntu
                ((i++))
                
        else  
                break  
        fi
done


#make offline docker centos pkg
docker pull centos:7.3.1611
docker container run --name offline-docker-centos -d centos:7.3.1611 /bin/bash -c "while true; do sleep 1d; done"
sleep 3
docker cp ./pkg_offline-docker-centos.sh offline-docker-centos:/opt/pkg_offline-docker-centos.sh
docker cp ./install-7.3-above.sh offline-docker-centos:/opt/install-7.3-above.sh
docker cp ./install-7.3-below.sh offline-docker-centos:/opt/install-7.3-below.sh
docker cp ./readme-centos-7.3-7.4.txt offline-docker-centos:/opt/readme-centos-7.3-7.4.txt
docker cp ./readme-centos-7.1-7.2.txt offline-docker-centos:/opt/readme-centos-7.1-7.2.txt
docker cp ./readme-centos-7.0.txt offline-docker-centos:/opt/readme-centos-7.0.txt

docker exec offline-docker-centos /bin/bash -c "chmod -R 777 /opt/pkg_offline-docker-centos.sh"
docker exec offline-docker-centos /bin/bash -c "cd /opt && /opt/pkg_offline-docker-centos.sh"

docker cp offline-docker-centos:/opt/offline-docker-centos-7.3-7.4.tar.gz ./
docker cp offline-docker-centos:/opt/offline-docker-centos-7.1-7.2.tar.gz ./
docker cp offline-docker-centos:/opt/offline-docker-centos-7.0.tar.gz ./

docker container rm -f offline-docker-centos

