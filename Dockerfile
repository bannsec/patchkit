FROM ubuntu:latest

RUN useradd -m patchkit
WORKDIR /home/patchkit
ENV HOME /home/patchkit

RUN apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install git python-pip build-essential git cmake python-dev libglib2.0-dev sudo && \
    echo 'patchkit ALL=(ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo

COPY . patchkit/.

RUN cd /home/patchkit/patchkit && HEADLESS=1 ./deps.sh

RUN cd /home/patchkit/patchkit && \
    HEADLESS=1 build=/home/patchkit/patchkit/build ./install.sh && \
    rm -rf /home/patchkit/patchkit/build && \
    chown -R patchkit:patchkit /home/patchkit

USER patchkit
ENV PATH /home/patchkit/patchkit:$PATH

CMD ["/bin/bash"]
