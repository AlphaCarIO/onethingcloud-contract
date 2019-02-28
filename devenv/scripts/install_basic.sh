#!/bin/bash

#apt-get update

#

sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak

sudo echo -e "deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse \n\
deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse \n\
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse \n\
deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse \n\
##测试版源 \n\
deb http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse \n" \
    > /etc/apt/sources.list

#\
#deb http://extras.ubuntu.com/ubuntu/ xenial main \n

# Update packages

#sudo apt-get update

#sudo apt-get install -y apt-utils vim tzdata 

sudo apt-get update

sudo apt-get install -y python3-pip build-essential libssl-dev

sudo cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
