#!/bin/bash

Current_DIR=$(cd `dirname $0`; pwd)
rpm -Uvh $Current_DIR/offline-docker-centos/*.rpm --force
systemctl start docker
