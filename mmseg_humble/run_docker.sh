#!/bin/bash

docker run -it \
    --rm \
    -v /home/jiwon/workspace:/workspace \
    --gpus all \
    --shm-size=64G \
    --network host \
    --ipc=host \
    -e TZ=Asia/Seoul \
    -e TERM=xterm-256color \
    --name mmseg_tmp \
    mmseg:cuda117_torch201_humble \
    /bin/bash

# cd demo/ros2_ws/src/semantic_segmentation/library/mmsegmentation/
# pip install -v -e .

# chown -R 1015:1015 /workspace/demo/ros2_ws
