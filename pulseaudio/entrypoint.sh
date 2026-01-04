#!/bin/sh

## Set the "bakruis" user to the needed audio group
addgroup -g $AUDIO_GROUP pulse_audio && addgroup bakruis pulse_audio && addgroup bakruis audio && addgroup pulse bakruis_audio


while true; do
    defaultdevice=$(pactl get-default-sink)
    if [[ "$defaultdevice" = "$DEVICE" ]]; then
        /sinkvolume.sh
        break
    else
        pactl set-default-sink $DEVICE
    fi
    sleep 5
done &

## Start pulseaudio
pulseaudio -v --exit-idle-time=-1 --disallow-exit=yes
