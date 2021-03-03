#!/bin/bash
if [ ! -d $USER ]
then
  mkdir $USER
fi

docker run --net=host \
  --gpus all \
  --volume=/dev:/dev \
  --name=dockerjupyter \
  --workdir=/home/$USER \
  -e LOCAL_USER_ID=`id -u $USER` \
  -e DISPLAY=$DISPLAY \
  -e XAUTHORITY \
  -e NVIDIA_DRIVER_CAPABILITIES=all \
  -e QT_GRAPHICSSYSTEM=native \
  -e CONTAINER_NAME=dockerjupyter-dev \
  -v "/tmp/.X11-unix:/tmp/.X11-unix" \
  -v "$(pwd)/$USER:/home/$USER" \
  dockerjupyter:latest
