#!/bin/sh
rm -rf /var/run/avahi-daemon/pid
rm -rf /etc/avahi/services/*.service
avahi-daemon