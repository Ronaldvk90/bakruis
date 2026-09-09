#!/bin/sh
set -e

addgroup -g $AUDIO_GROUP shairport_audio && addgroup bakruis shairport_audio && addgroup bakruis audio && addgroup pulse shairport_audio

/usr/local/bin/nqptp > /dev/null 2>&1
exec /usr/local/bin/shairport-sync "$@"