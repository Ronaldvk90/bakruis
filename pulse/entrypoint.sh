#!/bin/sh

ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
echo "$TZ" > /etc/timezone

mkdir -p /var/run/dbus
rm -rf /run/dbus/dbus.pid
dbus-uuidgen --ensure
dbus-daemon --system
avahi-daemon --daemonize --no-chroot
sleep 5
su - bakruis -c "pulseaudio --verbose --exit-idle-time=-1 --disallow-exit"
