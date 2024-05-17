#!/bin/sh
ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
echo "$TZ" > /etc/timezone
su -c "spotifyd --no-daemon --config-path=/etc/spotifyd.conf" bakruis