#!/bin/sh

## Set the advertisement name from the .env file
sed -i "s/\<NAME\>/$NAME/" /etc/bluetooth/main.conf

/usr/lib/bluetooth/bluetoothd --noplugin=keyboard --experimental&

/usr/local/bin/bluetoothaccept
