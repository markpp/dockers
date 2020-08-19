FROM osrf/ros:kinetic-desktop-xenial
LABEL maintainer "Mark"

ENV ROS_DISTRO kinetic


RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

# install basic packages
RUN apt-get update && apt-get install -y \
    apt-utils build-essential cmake nano net-tools iputils-ping python-pip python3-pip

# install ros packages
RUN apt-get update && apt-get install -y \
    ros-kinetic-desktop-full ros-kinetic-rosbridge-server ros-kinetic-moveit

# Install packages
RUN apt-get update && apt-get install -y \
    # ROS MoveIt
    ros-${ROS_DISTRO}-moveit \
    --no-install-recommends \
    # Clear apt-cache to reduce image size
    && rm -rf /var/lib/apt/lists/*

# Create local catkin workspace
ENV CATKIN_WS=/home/catkin_ws
RUN mkdir -p $CATKIN_WS/src
WORKDIR $CATKIN_WS/src

# Add robot packages to local catkin workspace
RUN echo "Building UR Planner for ROS" \
    source /opt/ros/${ROS_DISTRO}/setup.bash \
    # Update apt-get because its cache is always cleared after installs to keep image size down
    && apt-get update \
    # UR packages
    && git clone -b ${ROS_DISTRO}-devel https://github.com/ros-industrial/universal_robot.git \
    && git clone -b ${ROS_DISTRO}-devel https://github.com/ros-industrial/ur_modern_driver.git

# Build catkin workspace

RUN cd $CATKIN_WS \
  rosdep install -y --from-paths . --ignore-src --rosdistro ${ROS_DISTRO} \
  catkin_make # not building

RUN echo 'source /opt/ros/kinetic/setup.bash' >> /etc/bash.bashrc
RUN echo 'source /home/catkin_ws/devel/setup.bash' >> /etc/bash.bashrc

ENV ROS_IP=172.24.210.130
