#!/bin/bash

VER=`git rev-parse HEAD`
PREFIX=repo.alphacario.com:8090
FLAG=test
VER=v2
img_name=wallet

modules=("lianxiangcloud" "thunderchain")

echo 'img_name:'$img_name
