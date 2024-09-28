#!/bin/bash

xhost +local:
docker run -t -it --rm --net=host \
  --privileged \
  --gpus all \
  --volume=/dev:/dev \
  --name=docker_cam \
  --workdir=/home/ \
  -e LOCAL_USER_ID=`id -u $USER` \
  -e DISPLAY=$DISPLAY \
  -e XAUTHORITY \
  -e NVIDIA_DRIVER_CAPABILITIES=all \
  -e CONTAINER_NAME=docker_cam\
  -v "/tmp/.X11-unix:/tmp/.X11-unix" \
  camera_stream:latest
