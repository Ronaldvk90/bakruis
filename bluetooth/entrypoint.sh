#!/bin/sh
sed -i "s/\<ALIAS\>/$ALIAS/" /etc/bluetooth/main.conf
./usr/lib/bluetooth/bluetoothd