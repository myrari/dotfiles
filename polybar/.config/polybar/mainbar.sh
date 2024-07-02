#!/usr/bin/zsh

# terminate already running polybar instances
polybar-msg cmd quit

# launch main bar on all available monitors
if type "xrandr"; then
  for m in $(polybar -m | cut -d":" -f1); do
    MONITOR=$m polybar --reload main &
  done
else
  polybar --reload main &
fi
