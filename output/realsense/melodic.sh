#!/bin/bash

# setup ros environment
source '/opt/ros/$ROS_DISTRO/setup.bash'

if [ ! -d "src/" ]
then
    mkdir src/
fi
cd src/
catkin_init_workspace
cd ../
catkin_make -DPYTHON_EXECUTABLE=/usr/bin/python

echo 'source /home/catkin_ws/devel/setup.bash' >> ~/.bashrc
source '~/.bashrc'