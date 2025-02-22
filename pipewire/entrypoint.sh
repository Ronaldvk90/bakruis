#!/bin/sh
addgroup -g $AUDIO_GROUP pulse_audio && addgroup bakruis pulse_audio && addgroup bakruis audio
su -c pipewire bakruis&
su -c wireplumber bakruis
