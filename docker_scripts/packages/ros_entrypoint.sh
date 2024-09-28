#!/bin/bash
set -e

# setup ros2 environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
#colcon build
#source "/workspace/ros2_ws/install/setup.bash"
exec "$@"


