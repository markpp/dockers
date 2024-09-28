#!/bin/bash

xhost +local:
docker run -t -it \
  --restart=always \
  --net=host \
  --gpus all \
  --runtime nvidia \
  --volume=/dev:/dev \
  --name=gui_docker \
  --workdir=/workspace \
  -e DISPLAY=$DISPLAY \
  -e XAUTHORITY \
  -e NVIDIA_DRIVER_CAPABILITIES=all \
  -e QT_GRAPHICSSYSTEM=native \
  -e CONTAINER_NAME=gui_docker \
  -v "/tmp/.X11-unix:/tmp/.X11-unix" \
  -v "/home/jetson/code:/workspace" \
  deepstream.gui:latest
