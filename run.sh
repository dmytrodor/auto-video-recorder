#!/bin/bash

DEVICE="/dev/video0"
FILE_EXT=".ts"
DATA_DIR="/home/${USER}/Videos"
VIDEO_RES="640x480"

# Function to check if camera is available
is_camera_available() {
    if [ -e "$DEVICE" ]; then
        return 0 # true
    else
        return 1 # false
    fi
}

# Function to get file path
get_file_path() {
    local path=$1
    mkdir -p "$path" # create output directory if not exists
    local file_id=$(ls ${path}/*${FILE_EXT} | wc -l)
    echo "${path}/${file_id}${FILE_EXT}"
}

# Main loop
while true; do
    if ! is_camera_available; then
        sleep 1
        echo "No camera found, waiting ..."
    else
        output=$(get_file_path "$DATA_DIR")
        cmd="ffmpeg -f v4l2 -framerate 30 -video_size $VIDEO_RES -c:v mjpeg -i $DEVICE -vcodec libx264 -r 30 -preset veryfast -tune zerolatency -y $output"
        echo "--------------------------------------------------------------------------------"
        echo "$cmd"
        echo "--------------------------------------------------------------------------------"
        eval $cmd
        break
    fi
done
