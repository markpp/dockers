# Install standard tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils software-properties-common dirmngr build-essential \ 
    gpg-agent lsb-release git curl unzip wget gedit nano cmake \
    pkg-config checkinstall yasm libopenblas-dev 
