#!/bin/bash

docker run --net=host \
  --gpus all \
  --volume=/dev:/dev \
  --name=dockerredoco2 \
  -e LOCAL_USER_ID=`id -u $USER` \
  -e CONTAINER_NAME=dockerredoco2-dev \
  dockerredoco2:latest
