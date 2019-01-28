#!/bin/bash
mkdir -p /tmp/docker_backups
Bkp_Dir=/tmp/docker_backups
now=`date +"%m_%d_%Y"`
for CName in `docker ps| awk '{print $NF}'|grep -v NAMES`
do
docker commit -p `docker ps|grep "$CName"|awk '{ print $1 }'|grep -v CONTAINER` "$CName"_"$now"
docker save -o "$Bkp_Dir/$CName"_"$now".tar `docker images|grep "$CName"_"$now"|awk '{ print $1 }'`
docker rmi `docker images |grep "$CName"_"$now"|awk '{ print $1 }'`
done
