FROM nvidia/cuda:11.3.1-cudnn8-runtime-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN sed -i 's|http://archive.ubuntu.com/ubuntu/|http://mirror.kakao.com/ubuntu/|g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
        apt-utils \
        vim \
        wget \
        curl \
        libgl1-mesa-glx \
        libglib2.0-0 \
        g++ \
        ninja-build \
        cuda-toolkit-11-3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Miniconda
RUN wget -q -P /root https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash /root/Miniconda3-latest-Linux-x86_64.sh -b -p /root/miniconda3 && \
    rm /root/Miniconda3-latest-Linux-x86_64.sh && \
    /root/miniconda3/bin/conda init bash

RUN /root/miniconda3/bin/conda create -n environment python=3.7 -y && \
    /root/miniconda3/bin/conda install -n environment pytorch==1.10.1 torchvision==0.11.2 torchaudio==0.10.1 cudatoolkit=11.3 -c pytorch -c conda-forge

RUN bash -c "source /root/miniconda3/bin/activate environment && \
    pip install openmim && \
    mim install mmcv-full==1.4.0 && \
    mim install mmdet==2.14.0 && \
    mim install mmsegmentation==0.14.1"

RUN bash -c "source /root/miniconda3/bin/activate environment && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"

WORKDIR /workspace

CMD ["/bin/bash"]
