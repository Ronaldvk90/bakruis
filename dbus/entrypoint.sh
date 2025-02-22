#!/bin/sh
rm -rf /run/dbus/dbus.pid
dbus-daemon --system --nofork --print-address