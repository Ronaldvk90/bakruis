#!/bin/sh

ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
echo "$TZ" > /etc/timezone
avahi-daemon --daemonize --no-chroot
sed -i "s/\<OUTPUT\>/$OUTPUT/" /etc/pipewire/pipewire.conf
sed -i "s/\<OUTPUT\>/$OUTPUT/" /etc/pipewire/pipewire-pulse.conf
su -c pipewire bakruis