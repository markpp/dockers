FROM nvidia/cuda:11.1-cudnn8-devel-ubuntu20.04

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

# Install standard python tools
RUN pip3 install numpy scipy pandas

# Install python plotting tools
RUN pip3 install matplotlib seaborn quickda

# Install pytorch
RUN pip3 install torch==1.7.1+cu110 torchvision==0.8.2+cu110 -f https://download.pytorch.org/whl/torch_stable.html

# Install pytorch-lightning
RUN pip3 install pytorch-lightning

# Install Deep Graph Library (DGL)
RUN pip3 install --pre dgl-cu110
ENV DGLBACKEND=pytorch

# Install efficientnet
RUN pip3 install efficientnet_pytorch

# Install useful python ML packages
RUN pip3 install sklearn umap-learn gensim albumentations eli5 networkx

# Install useful python packages
RUN pip3 install rasterio # georasters

# Install python packages for manipulating vector data
RUN pip3 install geopandas shapely

# Install useful python pachages
RUN pip3 install folium

# Install sentinelhub python api
RUN pip3 install sentinelhub

# Install earthengine python api
RUN pip3 install earthengine-api

RUN rm -rf /var/lib/apt/lists/*

COPY user.sh /usr/local/bin/
CMD bash -C '/usr/local/bin/user.sh'