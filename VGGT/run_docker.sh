#!/bin/sh

docker run -it \
    -v /home/jiwon/workspace:/workspace \
    --gpus all \
    --network host \
    -e ROS_DOMAIN_ID=17 \
    --name vgg \
    vgg \
    /bin/bash
