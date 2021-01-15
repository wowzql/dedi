#!/bin/bash

IMAGE=ssnw
VERSION=0.1

#清除tag为none的镜像
docker ps -a | grep "Exited" | awk '{print $1}' | xargs docker stop
docker ps -a | grep "Exited" | awk '{print $2}' | xargs docker rm 
docker images | grep none | awk '{print $3}' | xargs docker rmi

#清除已有的
docker stop $IMAGE-$VERSION
docker rm $IMAGE-$VERSION
docker rmi wowzql/$IMAGE-$VERSION

docker rm $(docker ps -a -q)

#重新生成
docker build -t wowzql/$IMAGE-$VERSION ./
