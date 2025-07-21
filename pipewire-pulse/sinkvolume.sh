#!/bin/sh

## Basicaly do set-sink-volume 100% for all sinks in a loop.
for SINK in $(pactl list short sinks | awk '{print $1}'); do
  pactl set-sink-volume "$SINK" 100%
done