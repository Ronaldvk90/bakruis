#!/bin/sh

ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
echo "$TZ" > /etc/timezone

sed -i "s/\<OUTPUT\>/$OUTPUT/" /etc/pipewire/pipewire.conf

su -c pipewire bakruis
