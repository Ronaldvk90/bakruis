#!/bin/sh
addgroup -g $AUDIO_GROUP pulse_audio && addgroup bakruis pulse_audio && addgroup bakruis audio
su -c pipewire bakruis&
su -c pipewire-pulse bakruis&

while true; do
    defaultdevice=$(pactl get-default-sink)
    if [[ "$defaultdevice" == "$DEVICE" ]]; then
        break
    else
        pactl set-default-sink $DEVICE
    fi
    sleep 5
done &

su -c wireplumber bakruis