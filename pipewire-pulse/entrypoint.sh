#!/bin/sh

ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
echo "$TZ" > /etc/timezone

su -c pipewire-pulse bakruis