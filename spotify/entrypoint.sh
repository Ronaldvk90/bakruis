#!/bin/sh
ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
echo "$TZ" > /etc/timezone
sed -i "s/\<HOSTNAME\>/$HOSTNAME/" /etc/spotifyd.conf
su -c "spotifyd --no-daemon --config-path=/etc/spotifyd.conf" bakruis