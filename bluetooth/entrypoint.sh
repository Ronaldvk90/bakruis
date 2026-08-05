#!/bin/sh

## Set the advertisement name from the .env file
sed -i "s/\<NAME\>/$NAME/" /etc/bluetooth/main.conf

/usr/sbin/rfkill unblock bluetooth
/usr/lib/bluetooth/bluetoothd --noplugin=keyboard --experimental