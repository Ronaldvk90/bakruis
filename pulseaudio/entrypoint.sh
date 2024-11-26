#!/bin/sh

mkdir -p /var/run/dbus
rm -rf /run/dbus/dbus.pid
dbus-daemon --system
sed -i "s/\<DEVICE\>/$DEVICE/" /etc/pulse/default.pa.d/default.pa
su - bakruis -c "pulseaudio --verbose --exit-idle-time=-1 --disallow-exit"