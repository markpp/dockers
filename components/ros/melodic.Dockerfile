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
#RUN rosdep init && \
#    rosdep update --rosdistro $ROS_DISTRO && \
#    mkdir -p $ROS_WS/src

# install ros packages
RUN apt-get update && apt-get install -y --allow-unauthenticated \
    ros-$ROS_DISTRO-desktop-full ros-$ROS_DISTRO-rosbridge-server ros-$ROS_DISTRO-moveit ros-$ROS_DISTRO-pcl-ros \
    && rm -rf /var/lib/apt/lists/*

RUN echo 'source /opt/ros/melodic/setup.bash' >> ~/.bashrc

ENV ROS_IP=127.0.0.1
#ENV ROS_IP=192.168.1.100

ENV ROS_MASTER_URI=http://$ROS_IP:11311

WORKDIR $ROS_WS
