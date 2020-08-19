# install python3
RUN apt-get update && apt-get install -y --no-install-recommends \
    python python-pip python-dev python-tk python-setuptools

# Update pip
RUN pip --no-cache-dir install --upgrade \
    pip setuptools
