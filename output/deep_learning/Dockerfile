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

# Install pytorch
RUN pip3 install torch torchvision

# Install pytorch-lightning
RUN pip3 install pytorch-lightning


# Install efficientnet
RUN pip3 install efficientnet_pytorch

# Install useful python pachages 
RUN pip3 install numpy scipy sklearn umap-learn pandas matplotlib gensim pillow albumentations


RUN rm -rf /var/lib/apt/lists/*


COPY user.sh /usr/local/bin/
CMD bash -C '/usr/local/bin/user.sh'