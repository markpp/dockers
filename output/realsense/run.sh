#!/bin/bash
xhost +local:
docker run -it --net=host \
  --volume=/dev:/dev \
  --name=dockerrealsense \
  --workdir=/home/$USER \
  -e LOCAL_USER_ID=`id -u $USER` \
  -e DISPLAY=$DISPLAY \
  -e QT_GRAPHICSSYSTEM=native \
  -e CONTAINER_NAME=dockerrealsense-dev \
  -v "/tmp/.X11-unix:/tmp/.X11-unix" \
  -v "$(pwd)/catkin_ws:/home/catkin_ws" \
  -v "$(pwd)/$USER:/home/$USER" \
  dockerrealsense:latest
