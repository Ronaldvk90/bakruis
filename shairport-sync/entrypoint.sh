#!/bin/sh
set -e

addgroup -g $AUDIO_GROUP shairport_audio && addgroup bakruis shairport_audio && addgroup bakruis audio && addgroup pulse shairport_audio

/usr/local/bin/nqptp &
exec /usr/local/bin/shairport-sync "$@"