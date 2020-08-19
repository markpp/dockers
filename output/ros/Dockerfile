FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04

LABEL maintainer "Auto generated, Mark"

ENV DEBIAN_FRONTEND=noninteractive

# Install standard tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils git curl unzip openssh-client wget \
    build-essential cmake libcanberra-gtk-module \
    libopenblas-dev libsm6 libxext6 libxrender-dev \
    gedit nano lsb-release

# install python3
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip python3-dev python3-tk python3-setuptools

# Update pip
RUN pip3 --no-cache-dir install --upgrade \
    pip setuptools

# ROS #
ENV ROS_DISTRO melodic
ENV ROS_WS /home/catkin_ws

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# install bootstrap tools
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    python-cv-bridge \
    python-catkin-tools

# bootstrap rosdep
RUN rosdep init && \
    rosdep update --rosdistro $ROS_DISTRO && \
    mkdir -p $ROS_WS/src

# install ros packages
RUN apt-get update && apt-get install -y --allow-unauthenticated \
    ros-$ROS_DISTRO-desktop-full ros-$ROS_DISTRO-rosbridge-server ros-$ROS_DISTRO-moveit ros-$ROS_DISTRO-pcl-ros \
    && rm -rf /var/lib/apt/lists/*

WORKDIR $ROS_WS

RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
RUN echo 'source $ROS_WS/devel/setup.bash' >> /.bashrc

#ENV ROS_IP=172.17.32.15
ENV ROS_IP=127.0.0.1
#ENV ROS_IP=192.168.1.100

ENV ROS_MASTER_URI=http://$ROS_IP:11311

RUN rm -rf /var/lib/apt/lists/*
