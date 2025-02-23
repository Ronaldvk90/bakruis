#!/bin/sh
echo "Starting nqptp"
/usr/local/bin/nqptp&

#Set the hostname
sed -i "s/\<NAME\>/$NAME/" /etc/shairport-sync

echo "Starting shairport-sync"
# pass all commandline options to shairport-sync
/usr/local/bin/shairport-sync "$@"
