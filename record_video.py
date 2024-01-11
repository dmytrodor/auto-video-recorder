import os
import glob
from time import sleep
from subprocess import call, check_output, CalledProcessError


DEVICE = "/dev/video0"
FILE_EXT = ".ts"
DATA_DIR = "/home/zero/Videos"
VIDEO_RES = "640x480"


def is_camera_available() -> bool:
    try:
        res = check_output(f"ls {DEVICE}".split())
    except CalledProcessError:
        return False
    return res.strip().decode() == DEVICE


def get_file_path(path: str) -> str:
    existing_files = glob.glob(os.path.join(path, f"*{FILE_EXT}"))
    file_id = len(existing_files)
    return os.path.join(path, f"{file_id}{FILE_EXT}")


def main():
    while True:
        if not is_camera_available():
            sleep(1)
            print("No camera found, waiting ...")
        else:
            # create output directory if not exists
            os.makedirs(DATA_DIR, exist_ok=True)
            cmd = f"ffmpeg -f v4l2 -framerate 30 -video_size {VIDEO_RES} -c:v mjpeg -i {DEVICE} -c:v copy -r 30 -preset veryfast -tune zerolatency -y " + get_file_path(DATA_DIR)
            print("-" * 100 + "\n", cmd, "\n" + "-" * 100)
            call(cmd.split())
            break


if __name__ == "__main__":
    main()
