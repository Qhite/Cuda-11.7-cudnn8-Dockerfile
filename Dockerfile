FROM nvidia/cuda:11.7.1-cudnn8-devel-ubuntu22.04

# Remove any third-party apt sources to avoid issues with expiring keys.
RUN rm -f /etc/apt/sources.list.d/*.list

# Install some basic utilities & python prerequisites
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get clean && apt-get update
RUN apt-get install -y sudo vim nano pip curl wget ssh apt-utils net-tools cmake xvfb git x11-apps swig \
    python3 python3-pyglet python3-opengl python3-openssl python3-dev &&\
    rm -rf /var/lib/apt/lists/*

RUN echo "\nalias sb=\"source ~/.bashrc\"" >> ~/.bashrc
RUN echo "alias eb=\"nano ~/.bashrc\"" >> ~/.bashrc

RUN mkdir -p /root/miniconda3
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
RUN bash /root/miniconda3/miniconda.sh -b -u -p ~/miniconda3
RUN rm -rf /root/miniconda3/miniconda.sh

RUN /root/miniconda3/bin/conda init bash
RUN /root/miniconda3/bin/conda init zsh
ENV PATH /root/miniconda3/bin:$PATH
RUN /bin/bash -c "source ~/.bashrc"

RUN conda create --name venv python==3.9
ENV PATH /root/miniconda3/envs/venv/bin:$PATH
RUN echo "source activate venv" >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"
