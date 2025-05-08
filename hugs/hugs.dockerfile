FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN sed -i 's|http://archive.ubuntu.com/ubuntu/|http://mirror.kakao.com/ubuntu/|g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
        apt-utils \
        build-essential \
        git \
        vim \
        wget \
        cmake \
        g++ \
        ninja-build \
        cuda-toolkit-11-8 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Miniconda
RUN wget -q -P /root https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash /root/Miniconda3-latest-Linux-x86_64.sh -b -p /root/miniconda3 && \
    rm /root/Miniconda3-latest-Linux-x86_64.sh && \
    /root/miniconda3/bin/conda init bash

RUN /root/miniconda3/bin/conda create -n hugs python=3.10 -y

# PyTorch
RUN /root/miniconda3/bin/conda run -n hugs \
        pip install torch==2.3.1+cu118 torchvision==0.18.1+cu118 --extra-index-url https://download.pytorch.org/whl/cu118

# tiny-cuda-nn
RUN git clone --recursive https://github.com/nvlabs/tiny-cuda-nn.git && \
    cd tiny-cuda-nn && \
    cmake . -B build -DCMAKE_BUILD_TYPE=RelWithDebInfo && \
    cmake --build build --config RelWithDebInfo -j

ENV TCNN_CUDA_ARCHITECTURES=86

RUN /root/miniconda3/bin/conda run -n hugs \
        pip install git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch

# pytorch3D
RUN /root/miniconda3/bin/conda run -n hugs \
        pip install --extra-index-url https://miropsota.github.io/torch_packages_builder pytorch3d==0.7.5+pt2.3.1cu118

# flow-vis-torch
RUN apt-get update && apt-get install -y git && \
    /root/miniconda3/bin/conda run -n hugs \
        pip install git+https://github.com/ChristophReich1996/Optical-Flow-Visualization-PyTorch

WORKDIR /workspace

CMD ["/bin/bash"]
