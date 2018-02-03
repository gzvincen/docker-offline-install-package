# docker-offline-install-package
Use Docker to make ubuntu docker offline installation package.

if your OS installed Docker, just run this command

```shell
sudo +x build.sh && ./build.sh
```

use ubuntu:trusty docker container to make docker offline installation package for Ubuntu:14.04 OS.

use ubuntu:xenial docker container to make docker offline installation package for Ubuntu:16.04 OS.

use ubuntu:zesty docker container to make docker offline installation package for Ubuntu:17.04 OS.

use ubuntu:artful docker container to make docker offline installation package for Ubuntu:17.10 OS.

use centos:7.3.1611 docker container to make docker offline installation package for Centos7.0~7.4



After running the script will generate seven files:

offline-docker-ubuntu-trusty-14.04.tar.gz

offline-docker-ubuntu-xenial-16.04.tar.gz

offline-docker-ubuntu-zesty-17.04.tar.gz

offline-docker-ubuntu-artful-17.10.tar.gz

offline-docker-centos-7.0.tar.gz

offline-docker-centos-7.1-7.2.tar.gz

offline-docker-centos-7.3-7.4.tar.gz



Where the docker version that will be installed in the w file is docker-ce-17.09.1.ce-1.el7.centos and the other files will install the latest version of docker