#!/bin/bash

cd /project/devenv/scripts
./fetch_cert.sh nexus.alphacario.com:8089

cd /project/devenv/scripts
./install_docker-ce_ubuntu.sh

#cd /project/devenv/scripts
#./install_kubectl.sh
