FROM nvidia/cuda:11.1-cudnn8-devel-ubuntu20.04

LABEL maintainer "Mark - Auto generated"

ENV DEBIAN_FRONTEND=noninteractive

# Install standard tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils software-properties-common dirmngr build-essential \ 
    gpg-agent lsb-release git curl unzip wget gedit nano cmake \
    pkg-config checkinstall yasm libopenblas-dev 

# Install other 
RUN git clone --recurse-submodules https://github.com/ethereum-mining/ethminer

RUN cd ethminer/ && mkdir bin/ && cd bin/ && \
    cmake -D ETHASHCUDA=ON -D ETHASHCL=OFF -D ETHSTRATUM=ON .. && \
    make install -j8

RUN rm -rf /var/lib/apt/lists/*

COPY ethereum.sh /usr/local/bin/

COPY user.sh /usr/local/bin/
CMD bash -C '/usr/local/bin/user.sh'