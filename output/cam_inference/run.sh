#!/bin/bash

docker run --net=host \
  --gpus all \
  --volume=/dev:/dev \
  --name=dockercam_inference \
  -e LOCAL_USER_ID=`id -u $USER` \
  -e CONTAINER_NAME=dockercam_inference-dev \
  dockercam_inference:latest
