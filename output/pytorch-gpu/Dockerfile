FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04
LABEL maintainer "Auto generated, Mark"
ENV DEBIAN_FRONTEND=noninteractive
# Install standard tools

RUN apt-get update && apt-get install -y --no-install-recommends \

    apt-utils git curl unzip openssh-client wget \

    build-essential cmake libcanberra-gtk-module \

    libopenblas-dev libsm6 libxext6 libxrender-dev \

    gedit nano
# install python3

RUN apt-get update && apt-get install -y --no-install-recommends \

    python3 python3-pip python3-dev python3-tk python3-setuptools



# Update pip

RUN pip3 --no-cache-dir install --upgrade \

    pip setuptools
# Install pytorch

RUN pip3 install torch torchvision
RUN rm -rf /var/lib/apt/lists/*
WORKDIR /home
