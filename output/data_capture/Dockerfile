FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04

LABEL maintainer "Mark - Auto generated"

ENV DEBIAN_FRONTEND=noninteractive

# Install standard tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils software-properties-common dirmngr build-essential \ 
    gpg-agent lsb-release git curl unzip wget gedit nano cmake \
    pkg-config checkinstall yasm libopenblas-dev 

# install python3
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip python3-dev python3-tk python3-setuptools

# Update pip
RUN pip3 --no-cache-dir install --upgrade \
    pip setuptools

# OpenCV 4.4.0
RUN apt-get install -y --no-install-recommends \
    libjpeg8-dev libtiff5-dev libpng-dev \
    libavcodec-dev libavformat-dev libswscale-dev libgtk2.0-dev

# Get source from github
RUN git clone -b 4.4.0 --depth 1 https://github.com/opencv/opencv.git /usr/local/src/opencv
# Compile
RUN cd /usr/local/src/opencv && mkdir build && cd build && \
    cmake -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D BUILD_TESTS=OFF \
          -D BUILD_PERF_TESTS=OFF \
          -D PYTHON_DEFAULT_EXECUTABLE=$(which python3) \
          .. && \
    make -j"$(nproc)" && \
    make install

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
#RUN echo 'source $ROS_WS/devel/setup.bash' >> /.bashrc

ENV ROS_IP=127.0.0.1
#ENV ROS_IP=192.168.1.100

ENV ROS_MASTER_URI=http://$ROS_IP:11311

WORKDIR $ROS_WS

COPY melodic.sh /usr/local/bin/

# realsense #
RUN apt-get update -y && apt-get install --no-install-recommends lsb-release -y && \
    echo 'deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo `lsb_release -sc` main' || tee /etc/apt/sources.list.d/realsense-public.list && \
    apt-key adv --keyserver keys.gnupg.net --recv-key C8B3A55A6F3EFCDE || apt-key adv --keyserver hkp://keys.gnupg.net:80 --recv-key C8B3A55A6F3EFCDE && \
    add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo `lsb_release -sc` main"

RUN apt-get update && apt-get install -y --allow-unauthenticated \
    librealsense2-dkms librealsense2-dev ros-$ROS_DISTRO-ddynamic-reconfigure

COPY realsense.sh /usr/local/bin/

# Setup the ZED SDK

ENV UBUNTU_RELEASE_YEAR 18
ENV ZED_SDK_MAJOR 3
ENV ZED_SDK_MINOR 2

ENV CUDA_MAJOR 10
ENV CUDA_MINOR 0

RUN apt-get update -y && apt-get install --no-install-recommends lsb-release wget less udev sudo  build-essential cmake -y && \
    wget -O ZED_SDK_Linux_Ubuntu${UBUNTU_RELEASE_YEAR}.run https://download.stereolabs.com/zedsdk/${ZED_SDK_MAJOR}.${ZED_SDK_MINOR}/cu${CUDA_MAJOR}${CUDA_MINOR}/ubuntu${UBUNTU_RELEASE_YEAR} && \
    chmod +x ZED_SDK_Linux_Ubuntu${UBUNTU_RELEASE_YEAR}.run ; ./ZED_SDK_Linux_Ubuntu${UBUNTU_RELEASE_YEAR}.run -- silent skip_tools && \
    rm ZED_SDK_Linux_Ubuntu${UBUNTU_RELEASE_YEAR}.run && \
    rm -rf /var/lib/apt/lists/*

# ZED Python API
RUN wget download.stereolabs.com/zedsdk/pyzed -O /usr/local/zed/get_python_api.py && \
    python3 /usr/local/zed/get_python_api.py && \
    python3 -m pip install numpy opencv-python *.whl && \
    rm *.whl

COPY zed.sh /usr/local/bin/

RUN rm -rf /var/lib/apt/lists/*

CMD bash -C '/usr/local/bin/melodic.sh';'/usr/local/bin/realsense.sh';'/usr/local/bin/zed.sh';'bash'
