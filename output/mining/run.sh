#!/bin/bash

docker run --net=host \
  --gpus all \
  --volume=/dev:/dev \
  --name=dockermining \
  -e CONTAINER_NAME=dockermining-dev \
  dockermining:latest
