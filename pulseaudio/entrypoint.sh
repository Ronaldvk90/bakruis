#!/bin/sh
sed -i "s/\<DEVICE\>/$DEVICE/" /etc/pulse/default.pa
su - bakruis -c "pulseaudio --verbose --exit-idle-time=-1 --disallow-exit"