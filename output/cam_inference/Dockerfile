FROM nvidia/cuda:11.0-cudnn8-devel-ubuntu18.04

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

# OpenCV
RUN apt-get update && apt-get install -y libopencv-dev python3-opencv

# Install pytorch
RUN pip3 install torch==1.7.1+cu110 torchvision==0.8.2+cu110 -f https://download.pytorch.org/whl/torch_stable.html

# Install pytorch-lightning
RUN pip3 install pytorch-lightning


# Install efficientnet
RUN pip3 install efficientnet_pytorch

# Install useful python pachages 
RUN pip3 install numpy scipy sklearn umap-learn pandas matplotlib gensim pillow albumentations


# Vimba camera SDK
ARG VIMBA_TARBALL=Vimba_v3.1_Linux.tgz
ARG VIMBA_SDK="https://www.alliedvision.com/fileadmin/content/software/software/Vimba/${VIMBA_TARBALL}"
ADD ${VIMBA_SDK} /
RUN tar --wildcards -xzf ${VIMBA_TARBALL} 'Vimba*/Vimba*/*/x86_64bit'
ARG VIMBA_SDK_PREFIX=Vimba_3_1
ENV GENICAM_GENTL64_PATH=:/${VIMBA_SDK_PREFIX}/VimbaGigETL/CTI/x86_64bit

RUN rm -rf /var/lib/apt/lists/*


COPY user.sh /usr/local/bin/
CMD bash -C '/usr/local/bin/user.sh'