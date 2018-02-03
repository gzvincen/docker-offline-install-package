#!/bin/bash

Current_DIR=$(cd `dirname $0`; pwd)
dpkg -i $Current_DIR/offline-docker-ubuntu/*.deb
service docker restart
