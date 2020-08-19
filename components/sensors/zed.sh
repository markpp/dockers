#!/bin/bash

# ZED #
cd src
git clone https://github.com/stereolabs/zed-ros-wrapper.git
cd .. 
apt-get update -y
. /opt/ros/melodic/setup.sh
rosdep install --from-paths /home/catkin_ws/src --ignore-src -r -y
rm -rf /var/lib/apt/lists/*

catkin_make -DCMAKE_BUILD_TYPE=Release -DCMAKE_LIBRARY_PATH=/usr/local/cuda/lib64/stubs -DCUDA_CUDART_LIBRARY=/usr/local/cuda/lib64/stubs -DCMAKE_CXX_FLAGS="-Wl,--allow-shlib-undefined"

