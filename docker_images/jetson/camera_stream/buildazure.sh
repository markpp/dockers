#!/bin/bash
docker build -t 7c2e5b6dcc0c405cbe09919a7b9c8453.azurecr.io/camera_stream:latest -f DockerFile.camera_stream .
docker push 7c2e5b6dcc0c405cbe09919a7b9c8453.azurecr.io/camera_stream:latest
