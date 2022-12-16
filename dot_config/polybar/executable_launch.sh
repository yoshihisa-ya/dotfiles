#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

MONITOR=DP-1-8 polybar --reload main &
MONITOR=DP-1-1-8 polybar --reload secondary &
# echo "Polybar launched..."
# if type "xrandr"; then
#     for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#         MONITOR=$m polybar --reload example &
#     done
# else
#     polybar --reload example &
# fi
