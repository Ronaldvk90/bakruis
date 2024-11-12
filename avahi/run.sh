#!/bin/sh
avahipid=$(pidof avahi-daemon)
kill $avahipid
avahi-daemon --no-chroot --debug
