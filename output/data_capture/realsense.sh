#!/bin/bash

# Realsense #
source '/opt/ros/melodic/setup.bash'

cd src
git clone https://github.com/IntelRealSense/realsense-ros.git
cd .. 

catkin_make -DCATKIN_ENABLE_TESTING=False -DCMAKE_BUILD_TYPE=Release

