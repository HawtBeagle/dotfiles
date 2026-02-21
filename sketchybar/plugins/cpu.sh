#!/bin/bash

CORE_COUNT=$(sysctl -n hw.ncpu)
CPU_PERCENT=$(ps -A -o %cpu | awk -v cores=$CORE_COUNT '{s+=$1} END {print s/cores}' | awk '{printf "%02.0f", $1}')

sketchybar --set $NAME label="$CPU_PERCENT%"
