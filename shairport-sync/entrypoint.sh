#!/bin/sh
set -e

addgroup -g $AUDIO_GROUP shairport_audio && addgroup bakruis shairport_audio && addgroup bakruis audio && addgroup pulse shairport_audio

exec /usr/local/bin/shairport-sync "$@"