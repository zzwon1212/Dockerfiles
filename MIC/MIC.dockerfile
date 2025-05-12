FROM nvidia/cuda:11.0.3-runtime-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN sed -i 's|http://archive.ubuntu.com/ubuntu/|http://mirror.kakao.com/ubuntu/|g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-utils \
        build-essential \
        git \
        wget \
        vim \
        openssh-client \
        libgl1-mesa-glx \
        libglib2.0-0 \
        cmake \
        ninja-build && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Python3
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3.8 \
        python3.8-dev \
        python3-pip && \
    python3.8 -m pip install --upgrade pip setuptools wheel && \
    rm -rf /var/lib/apt/lists/*

# MIC
COPY requirements.txt /root/.

RUN python3.8 -m pip install \
        -r /root/requirements.txt \
        -f https://download.pytorch.org/whl/torch_stable.html && \
    python3.8 -m pip install mmcv-full==1.3.7

WORKDIR /workspace

CMD ["/bin/bash"]
