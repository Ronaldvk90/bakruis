#!/bin/sh

for SINK in $(pactl list short sinks | awk '{print $1}'); do
  pactl set-sink-volume "$SINK" 100%
done
