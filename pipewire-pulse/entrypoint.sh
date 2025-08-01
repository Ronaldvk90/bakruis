#!/bin/sh

## Set the "bakruis" user to the needed audio group
addgroup -g $AUDIO_GROUP pulse_audio && addgroup bakruis pulse_audio && addgroup bakruis audio

## Start PipeWire and PipeWire-Pulse
su -c pipewire bakruis&
su -c pipewire-pulse bakruis&

# Set all sinks 100% no matter what
/usr/local/bin/sinkvolume &

## Start the actual Wireplumber entrypoint
su -c wireplumber bakruis
