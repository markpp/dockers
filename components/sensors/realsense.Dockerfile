# realsense #
RUN apt-get update -y && apt-get install --no-install-recommends lsb-release -y && \
    echo 'deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo `lsb_release -sc` main' || tee /etc/apt/sources.list.d/realsense-public.list && \
    apt-key adv --keyserver keys.gnupg.net --recv-key C8B3A55A6F3EFCDE || apt-key adv --keyserver hkp://keys.gnupg.net:80 --recv-key C8B3A55A6F3EFCDE && \
    add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo `lsb_release -sc` main"

RUN apt-get update && apt-get install -y --allow-unauthenticated \
    librealsense2-dkms librealsense2-dev ros-$ROS_DISTRO-ddynamic-reconfigure
