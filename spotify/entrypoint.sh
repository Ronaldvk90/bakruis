#!/bin/sh

## Set the name for advertisement
sed -i "s/\<NAME\>/$NAME/" /etc/spotifyd.conf

## SpotidyD, the actual entrypoint
su -c "spotifyd --no-daemon --config-path=/etc/spotifyd.conf" bakruis