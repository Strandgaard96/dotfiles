#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
polybar -c /home/magstr/.config/polybar/config.ini mybar 2> /tmp/polybar_newlog1.log &

echo "Polybar launched..."