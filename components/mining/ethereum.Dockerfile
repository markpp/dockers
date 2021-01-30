# Install other 
RUN git clone --recurse-submodules https://github.com/ethereum-mining/ethminer

RUN cd ethminer/ && mkdir bin/ && cd bin/ && \
    cmake -D ETHASHCUDA=ON -D ETHASHCL=OFF -D ETHSTRATUM=ON .. && \
    make install -j8
