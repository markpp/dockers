FROM nvcr.io/nvidia/deepstream-l4t:6.0.1-iot

LABEL maintainer "Mark"

ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_ROOT_USER_ACTION=ignore

WORKDIR /workspace

# install base dependencies and tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl wget unzip pkg-config cmake build-essential autoconf automake lsb-release \
    nano gcc g++ gnupg2 m4 libtool apt-transport-https ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install tools for opencv
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgirepository1.0-dev zlib1g-dev libcairo2-dev libglib2.0-dev libglib2.0-dev-bin \
    libjpeg-dev libjpeg8-dev libjpeg-turbo8-dev libpng-dev libtiff-dev libopenjp2-7 libopenjp2-tools \
    libavcodec-dev libavformat-dev libswscale-dev libglew-dev \
    libgtk2.0-dev libgtk-3-dev libcanberra-gtk* \
    libxvidcore-dev libx264-dev libgtk-3-dev \
    libtbb2 libtbb-dev libdc1394-22-dev libxine2-dev libv4l-dev v4l-utils qv4l2 \
    gstreamer1.0-tools \
    libgstreamer1.0-0 \
    gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
    #libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-good1.0-dev \
    #libgstrtspserver-1.0-dev gstreamer1.0-rtsp \
    #gstreamer1.0-libav gstreamer1.0-doc gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa \
    #gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio \
    libavresample-dev libvorbis-dev libxine2-dev libtesseract-dev \
    libfaac-dev libmp3lame-dev libtheora-dev libpostproc-dev \
    libopencore-amrnb-dev libopencore-amrwb-dev \
    libopenblas-dev libatlas-base-dev libblas-dev \
    liblapack-dev liblapacke-dev libeigen3-dev gfortran \
    libhdf5-dev protobuf-compiler \
    libprotobuf-dev libgoogle-glog-dev libgflags-dev \
    && rm -rf /var/lib/apt/lists/*

# Install python and python tools
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-dev python3-numpy python3-tk python3-setuptools python3-gi python3-gst-1.0 \
    && rm -rf /var/lib/apt/lists/*

# Update pip and install base python packages
RUN pip3 install --upgrade \
    pip setuptools wheel \
    && rm -rf /root/.cache/pip

#
# install OpenCV (with GStreamer support)
#
COPY packages/jetson-ota-public.asc /etc/apt/trusted.gpg.d/jetson-ota-public.asc

RUN echo "deb https://repo.download.nvidia.com/jetson/common r32.4 main" > /etc/apt/sources.list.d/nvidia-l4t-apt-source.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
            libopencv-python \
    && rm /etc/apt/sources.list.d/nvidia-l4t-apt-source.list \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

RUN pip3 install \
    pgi paho-mqtt asyncio transitions

# setup entrypoint for indiviualized scripts
COPY ./packages/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
#CMD ["bash"]


# run fixed or common code between jetson
#COPY packages/ui.py /workspace/ui.py
#RUN chmod +x /workspace/ui.py
CMD ["python3", "/workspace/ui.py"]
