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

docker push $PREFIX/$module-$img_name:$VER

done
