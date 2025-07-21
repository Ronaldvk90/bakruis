#!/bin/sh

## Set the "bakruis" user to the nedded audio group
addgroup -g $AUDIO_GROUP pulse_audio && addgroup bakruis pulse_audio && addgroup bakruis audio

## Start PipeWire and PipeWire-Pulse
su -c pipewire bakruis&
su -c pipewire-pulse bakruis&

## Putting the volume to 100% for the default sink. Whatever the default will be
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

## Start the actual Wireplumber entrypoint
su -c wireplumber bakruis