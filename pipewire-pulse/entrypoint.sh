#!/bin/sh

## Set the "bakruis" user to the nedded audio group
groupadd -g $AUDIO_GROUP pulse_audio
usermod -aG pulse_audio bakruis
usermod -aG audio bakruis

## Start PipeWire and PipeWire-Pulse
su -c pipewire bakruis&
su -c pipewire-pulse bakruis&

# Set all sinks 100% no matter what
/usr/local/bin/sinkvolume &

## Start the actual Wireplumber entrypoint
su -c wireplumber bakruis
