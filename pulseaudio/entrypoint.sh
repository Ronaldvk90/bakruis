#!/bin/sh

## Set the "bakruis" user to the needed audio group
addgroup -g $AUDIO_GROUP pulse_audio && addgroup bakruis pulse_audio && addgroup bakruis audio && addgroup pulse bakruis_audio

# Set all sinks 100% no matter what
#/usr/local/bin/sinkvolume &

## Start pulseaudio
pulseaudio -v --exit-idle-time=-1 --disallow-exit=yes
