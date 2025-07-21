#!/bin/sh

## Set the advertisement name from the .env file
sed -i "s/\<NAME\>/$NAME/" /etc/bluetooth/main.conf

## Actual bluetoothd entrypoint
./usr/lib/bluetooth/bluetoothd