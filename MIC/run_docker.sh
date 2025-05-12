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
    --name mic_tmp \
    mic:cuda110_torch107 \
    /bin/bash

# chown -R 1015:1015 /workspace/demo/ros2_ws
