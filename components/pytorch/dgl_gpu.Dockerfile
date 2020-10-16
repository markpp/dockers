# Install Deep Graph Library (DGL)
RUN pip3 install --pre dgl-cu102
ENV DGLBACKEND=pytorch
