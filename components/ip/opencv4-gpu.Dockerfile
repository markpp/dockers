# OpenCV 4.4.0

# Generic tools
#RUN apt-get install -y --no-install-recommends \
#    build-essential cmake pkg-config unzip yasm git checkinstall

# Image/Video/Audio libs
RUN apt-get install -y --no-install-recommends \
    libjpeg-dev libtiff-dev libpng-dev \
    libavcodec-dev libavformat-dev libswscale-dev libavresample-dev /
    libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev /
    libxvidcore-dev x264 libx264-dev /
    libfaac-dev libmp3lame-dev libtheora-dev libvorbis-dev
    
# Cameras interface libs
#RUN apt-get install -y --no-install-recommends \
#    libdc1394-22 libdc1394-22-dev libxine2-dev

# UI
RUN apt-get install -y --no-install-recommends \
    libgtk-3-dev

# Performance
RUN apt-get install -y --no-install-recommends \
    libtbb-dev libatlas-base-dev gfortran

# Other
RUN apt-get install -y --no-install-recommends \
    libprotobuf-dev protobuf-compiler libgoogle-glog-dev libgflags-dev /
    libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

# Get source from github
#RUN git clone -b 4.4.0 --depth 1 https://github.com/opencv/opencv.git /usr/local/src/opencv

RUN wget -O opencv.zip https://github.com/opencv/opencv/archive/4.4.0.zip && /
    wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.4.0.zip && /
    unzip opencv.zip && /
    unzip opencv_contrib.zip

# Compile
RUN cd /usr/local/src/opencv && mkdir build && cd build && \
    cmake -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D BUILD_TESTS=OFF \
          -D BUILD_PERF_TESTS=OFF \
          -D PYTHON_DEFAULT_EXECUTABLE=$(which python3) \
          .. && \
    make -j"$(nproc)" && \
    make install
