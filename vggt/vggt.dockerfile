FROM pytorch/pytorch:2.3.1-cuda11.8-cudnn8-runtime

ARG DEBIAN_FRONTEND=noninteractive

RUN sed -i 's|http://archive.ubuntu.com/ubuntu/|http://mirror.kakao.com/ubuntu/|g' /etc/apt/sources.list

RUN pip install \
        torch==2.3.1 \
        torchvision==0.18.1 \
        numpy==1.26.1 \
        Pillow \
        huggingface_hub \
        einops \
        safetensors

RUN pip install \
        gradio==5.17.1 \
        viser==0.2.23 \
        tqdm \
        hydra-core \
        omegaconf \
        opencv-python \
        scipy \
        onnxruntime \
        requests \
        trimesh \
        matplotlib

RUN apt-get update && apt-get install -y \
        libgl1-mesa-glx \
        libglib2.0-0

# RUN apt-get update && apt-get install -y \
#         apt-utils \
#         vim \
#         wget \
#         curl \
#         libgl1-mesa-glx \
#         libglib2.0-0 \
#         g++ \
#         ninja-build \
#         cuda-toolkit-11-3 && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

CMD ["/bin/bash"]
