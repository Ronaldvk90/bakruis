#!/bin/sh
echo "Starting nqptp"
/usr/local/bin/nqptp&

echo "Starting shairport-sync"
# pass all commandline options to shairport-sync
/usr/local/bin/shairport-sync "$@"
