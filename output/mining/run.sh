#!/bin/bash

docker run --net=host \
  --gpus all \
  --volume=/dev:/dev \
  --name=dockermining \
  -e LOCAL_USER_ID=`id -u $USER` \
  -e CONTAINER_NAME=dockermining-dev \
  dockermining:latest
