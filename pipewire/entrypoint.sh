#!/bin/sh
addgroup -g $AUDIO_GROUP pulse_audio && addgroup bakruis pulse_audio && addgroup bakruis audio
sed -i "s/\<OUTPUT\>/$OUTPUT/" /etc/pipewire/pipewire.conf
su -c pipewire bakruis
