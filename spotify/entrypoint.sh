#!/bin/sh
sed -i "s/\<NAME\>/$NAME/" /spotifyd.conf
spotifyd --verbose --no-daemon --config-path /spotifyd.conf