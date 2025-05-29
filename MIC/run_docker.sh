#!/bin/bash

docker run -it \
    --rm \
    -v /home/jiwon/workspace:/workspace \
    --gpus all \
    --shm-size=64G \
    --network host \
    --ipc host \
    -e ROS_DOMAIN_ID=77 \
    -e TZ=Asia/Seoul \
    -e TERM=xterm-256color \
    --name VI_DEMO_SEG_INDOOR_UDA \
    mic_humble:cuda117_torch113 \
    /bin/bash

# chown -R 1015:1015 /workspace/demo/ros2_ws
