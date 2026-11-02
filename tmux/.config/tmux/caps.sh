#!/usr/bin/env bash

TMUX_BIN="${TMUX_BIN:-tmux}"

# Single instance: tmux.conf starts this on every config reload
exec 9>"${XDG_RUNTIME_DIR:-/tmp}/tmux-caps.lock"
flock -n 9 || exit 0

# The LED's sysfs file sends no inotify events, so poll it. Everything in the loop is a bash builtin
# (glob, read, and read -t on a pipe nothing writes to as the sleep), so polling spawns no processes;
# tmux is only called when the state changes, and then the bar is redrawn at once instead of at status-interval
exec {sleep_fd}<> <(:)

# exit with the tmux server, so the next server's copy can take the lock (tmux leaves its socket file behind)
server_pid="$("$TMUX_BIN" display-message -p '#{pid}')" || exit 0

last=""

while [ -d "/proc/$server_pid" ]; do
  state=0
  # any keyboard: built-in and USB keyboards each have their own LED, and USB ones come and go
  for f in /sys/class/leds/*::capslock/brightness; do
    read -r b < "$f" 2>/dev/null && [ "$b" != "0" ] && state=1 && break
  done

  if [ "$state" != "$last" ]; then
    [ "$state" = "1" ] && text="🔒 CAPS" || text=""
    "$TMUX_BIN" set-option -gq @caps_indicator "$text" || exit 0
    "$TMUX_BIN" list-clients -F '#{client_name}' | while read -r c; do
      "$TMUX_BIN" refresh-client -S -t "$c"
    done
    last="$state"
  fi

  read -rt 0.15 -u "$sleep_fd"
done
