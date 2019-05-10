#!/bin/bash

set -x

source module_def.sh

if [ -n "$1" ]; then
  FLAG=$1
fi

if [ -n "$2" ]; then
  VER=$2
fi

#if [ "prod" != "$FLAG" ]; then
#  img_name=$img_name-test
#fi

for module in ${modules[@]}; do

cd ./server-wallet_$VER/$module

single_img=$module-$img_name

docker rmi $single_img

docker rmi $PREFIX/$single_img:$VER

docker build --no-cache -t $single_img ./

docker tag $single_img:latest $PREFIX/$single_img:$VER

cd ../..

done
