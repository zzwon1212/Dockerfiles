#!/bin/sh

docker run -it \
    -v /home/jiwon/workspace:/workspace \
    --gpus all \
    --network host \
    --name hugs \
    hugs:final \
    /bin/bash
