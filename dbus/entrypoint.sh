#!/bin/sh
rm -rf /run/dbus/dbus.pid
dbus-daemon --session --fork --print-address
dbus-daemon --system --nofork --print-address