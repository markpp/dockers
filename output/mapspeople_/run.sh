#!/bin/bash

mkdir markpp

xhost +local:
docker run -it --gpus all --net=host \
  --volume=/dev:/dev \
  --name=dockermapspeople \
  --workdir=/home/$USER \
  -e LOCAL_USER_ID=`id -u $USER` \
  -e DISPLAY=$DISPLAY \
  -e QT_GRAPHICSSYSTEM=native \
  -e CONTAINER_NAME=dockermapspeople-dev \
  -v "/tmp/.X11-unix:/tmp/.X11-unix" \
  -v "$(pwd)/$USER:/home/$USER" \
  dockermapspeople:latest
