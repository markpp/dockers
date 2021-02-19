#!/bin/bash

docker run --net=host \
  --gpus all \
  --volume=/dev:/dev \
  --name=dockerdeep_learning \
  -e LOCAL_USER_ID=`id -u $USER` \
  -e CONTAINER_NAME=dockerdeep_learning-dev \
  dockerdeep_learning:latest
