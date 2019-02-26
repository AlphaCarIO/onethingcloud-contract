#!/bin/bash

set -x

source module_def.sh

if [ -n "$1" ]; then
  FLAG=$1
fi

if [ "prod" != "$FLAG" ]; then
  img_name=$img_name-test
fi

docker rmi $img_name

docker rmi $PREFIX/$img_name:v1

docker build --no-cache -t $img_name ./server-wallet

docker tag $img_name:latest $PREFIX/$img_name:v1
