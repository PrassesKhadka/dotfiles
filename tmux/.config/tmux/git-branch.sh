#!/usr/bin/env bash
# Git branch of a directory for the tmux status bar: " main", "* " appended when there are uncommitted
# changes to tracked files; prints nothing outside a repo. tmux runs it in the background (#()), so the
# bar never waits on git; it re-runs every status-interval and when the pane's directory changes.

out=$(git -C "$1" --no-optional-locks status --porcelain=v1 --branch --untracked-files=no 2>/dev/null) || exit 0

head=${out%%$'\n'*}
case $head in
  "## No commits yet on "*) branch=${head##* } ;;
  "## HEAD (no branch)") branch=$(git -C "$1" rev-parse --short HEAD 2>/dev/null) ;;
  *) branch=${head#\#\# }; branch=${branch%%...*}; branch=${branch%% *} ;;
esac

dirty=""
[[ $out == *$'\n'* ]] && dirty="*"

printf ' %s%s' "$branch" "$dirty"
