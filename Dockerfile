FROM ubuntu:latest
<<<<<<< HEAD
=======
MAINTAINER David Manouchehri
>>>>>>> f0b7477301597fd9563fa3ece7e7cad41db0ffa4

RUN useradd -m patchkit
WORKDIR /home/patchkit
ENV HOME /home/patchkit

RUN apt-get -y update && \
<<<<<<< HEAD
    DEBIAN_FRONTEND=noninteractive apt-get -y install git python-pip build-essential git cmake python-dev libglib2.0-dev sudo && \
    echo 'patchkit ALL=(ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo

COPY . patchkit/.

RUN cd /home/patchkit/patchkit && HEADLESS=1 ./deps.sh

RUN cd /home/patchkit/patchkit && \
    HEADLESS=1 build=/home/patchkit/patchkit/build ./install.sh && \
    rm -rf /home/patchkit/patchkit/build && \
    chown -R patchkit:patchkit /home/patchkit
=======
	DEBIAN_FRONTEND=noninteractive apt-get -y install git python-pip build-essential git cmake python-dev libglib2.0-dev && \
	su - patchkit -c "git clone https://github.com/lunixbochs/patchkit.git" && \
	su - patchkit -c "cd /home/patchkit/patchkit && HEADLESS=1 ./deps.sh" && \
	cd /home/patchkit/patchkit && \
	HEADLESS=1 build=/home/patchkit/patchkit/build ./install.sh && \
	rm -rf /home/patchkit/patchkit/build
>>>>>>> f0b7477301597fd9563fa3ece7e7cad41db0ffa4

USER patchkit
ENV PATH /home/patchkit/patchkit:$PATH

CMD ["/bin/bash"]
