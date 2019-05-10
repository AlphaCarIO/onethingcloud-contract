#!/bin/bash

VER=`git rev-parse HEAD`
PREFIX=nexus.alphacario.com:8089
FLAG=test
VER=v1
img_name=wallet

modules=("lianxiangcloud" "thunderchain")

echo 'img_name:'$img_name
