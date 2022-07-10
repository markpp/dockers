# Install Deep Graph Library (DGL)
RUN pip3 install --pre dgl-cu110
ENV DGLBACKEND=pytorch
