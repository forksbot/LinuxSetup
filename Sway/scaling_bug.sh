#!/bin/sh

set -x
output0=DP-1
output1=DP-2

swaymsg "output $output0 resolution 3840x2160 position 0 0 scale 2"
swaymsg "output $output1 resolution 3840x2160 position 1920 0 scale 2"
sleep 2

swaymsg "output $output0 scale 1"
swaymsg "output $output1 position 3840x2160 0"
sleep 2

swaymsg "output $output0 scale 2"
swaymsg "output $output1 position 1920 0"
sleep 2

swaymsg "output * dpms off"
sleep 15
swaymsg "output * dpms on"
