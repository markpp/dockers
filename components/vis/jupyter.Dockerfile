# Install jupyter deps
RUN apt-get update && apt-get install -y firefox wget libcanberra-gtk-module libcanberra-gtk3-module
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update && apt-get install -y nodejs

# Install jupyter notebook etc.
#RUN pip3 install jupyterlab RISE
RUN pip3 install notebook RISE
RUN jupyter-nbextension enable rise --py --sys-prefix
