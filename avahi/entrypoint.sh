#!/bin/sh

## Make sure there is no pidfile, or else the daemon won't start
rm -rf /var/run/avahi-daemon/pid

## Avahi actual entrypoint
avahi-daemon