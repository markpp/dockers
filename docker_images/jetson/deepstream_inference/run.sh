#!/bin/bash

docker run -t -it --rm --privileged \
	--net=host \
        --gpus all \
	--runtime nvidia \
        --volume=/dev:/dev \
        --name=inference_docker \
        --workdir=/workspace \
	--device="/dev/video0:/dev/video0" \
        -v "/home/jetson/code:/workspace" \
	deepstream:inference
