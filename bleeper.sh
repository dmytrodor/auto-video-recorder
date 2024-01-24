#!/bin/bash

LED_PIN=27
WORKING_DELAY=1
EXCEPTION_DELAY=0.1

# Export the pin for use
if echo "$LED_PIN" > /sys/class/gpio/export; then
    echo "Exported pin for use"
else
    echo "$LED_PIN" > /sys/class/gpio/unexport
    sleep 1
    echo "$LED_PIN" > /sys/class/gpio/export
fi
sleep 0.5

# Set the pin as an output
echo "out" > /sys/class/gpio/gpio${LED_PIN}/direction


bleep() {
    local n_times=$1
    local work_delay=$2
    for ((i = 1; i <= $n_times; i++ )); do
        echo "1" > /sys/class/gpio/gpio${LED_PIN}/value
        sleep $work_delay
        echo "0" > /sys/class/gpio/gpio${LED_PIN}/value
        sleep $work_delay
    done
}


while true; do
    #if [ -e "$(ps -e | egrep -i ffmpeg)" ]; then
    if pgrep ffmpeg >/dev/null 2>&1; then
        echo "[i] ffmpeg found - long blinking"
        $(bleep 1 1)
    else
        echo "[i] ffmpeg not found - fast blinking"
        $(bleep 10 0.1)
    fi
done

echo "$LED_PIN" > /sys/class/gpio/unexport