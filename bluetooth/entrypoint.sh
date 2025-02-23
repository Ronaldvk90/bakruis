#!/bin/sh
sed -i "s/\<NAME\>/$NAME/" /etc/bluetooth/main.conf
./usr/lib/bluetooth/bluetoothd