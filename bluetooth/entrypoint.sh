#!/bin/sh

## Set the advertisement name from the .env file
sed -i "s/\<NAME\>/$NAME/" /etc/bluetooth/main.conf

## Actual bluetoothd Simple agent entrypoint
/usr/lib/bluetooth/bluetoothd&
bluetoothctl discoverable yes
. /root/venv/bin/activate && cd /bluez-5.9/test/ && python simple-agent --capability=NoInputNoOutput
