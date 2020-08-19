#!/bin/bash
xhost +local:
docker run -it --net=host \
  -e DISPLAY=$DISPLAY \
  -e QT_GRAPHICSSYSTEM=native \
  -e CONTAINER_NAME=cam_docker-dev \
  --workdir=/home/catkin_ws \
  -v "/tmp/.X11-unix:/tmp/.X11-unix" \
  -v "$(pwd)/catkin_ws:/home/catkin_ws" \
  -v "$(pwd)/data:/home/data" \
  --device=/dev/dri:/dev/dri \
  --name=dockerdata_capture \
  dockerdata_capture:latest
