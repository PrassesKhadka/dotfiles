#!/usr/bin/env bash

TMUX_BIN="${TMUX_BIN:-tmux}"

caps_file=""
for f in /sys/class/leds/*::capslock/brightness; do
  [ -r "$f" ] && caps_file="$f" && break
done

[ -n "$caps_file" ] || exit 0

last=""

update() {
  state="$(cat "$caps_file" 2>/dev/null)"
  if [ "$state" = "1" ]; then
    text="🔒 CAPS"
  else
    text=""
  fi

  if [ "$text" != "$last" ]; then
    "$TMUX_BIN" set-option -gq @caps_indicator "$text"
    last="$text"
  fi
}

update

if command -v inotifywait >/dev/null 2>&1; then
  while inotifywait -qq -e modify "$caps_file"; do
    update
  done
else
  while :; do
    update
    sleep 0.1
  done
fi
