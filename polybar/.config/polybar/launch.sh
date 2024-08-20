#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload mybar -c /home/magstr/.config/polybar/config.ini 2>/tmp/polybar_newlog1.log &
  done
else
  polybar --reload mybar -c /home/magstr/.config/polybar/config.ini 2>/tmp/polybar_newlog1.log &
fi

# Launch Polybar, using default config location ~/.config/polybar/config
# polybar -c /home/magstr/.config/polybar/config.ini mybar 2>/tmp/polybar_newlog1.log &

echo "Polybar launched..."
