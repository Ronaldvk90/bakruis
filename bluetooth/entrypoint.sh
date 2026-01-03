#!/bin/sh

## Set the advertisement name from the .env file
sed -i "s/\<NAME\>/$NAME/" /etc/bluetooth/main.conf

/usr/lib/bluetooth/bluetoothd --noplugin=keyboard --experimental&
rfkill unblock bluetooth

# Bluetooth has te be powered in order to work correctly
while true; do
  powered=$(bluetoothctl show | grep Powered | awk '{print $2}')
  if [ "$powered" = "yes" ]; then
    break
  fi
  echo "waiting for bluetooth controller power..."
  sleep 1
done

echo "Bluetooth controller powered on!"

bluetoothctl << EOF
pairable on
discoverable on
discoverable-timeout 0
EOF

echo "Turned on discovery"

/usr/local/bin/bluetoothaccept
