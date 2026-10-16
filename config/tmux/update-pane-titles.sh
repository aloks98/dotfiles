#!/bin/sh
# Refresh every window so pane moves also update the source window.
tmux list-windows -a -F '#{window_id} #{window_panes}' |
while read -r window panes; do
  if [ "$panes" -gt 1 ]; then
    tmux set-option -w -t "$window" pane-border-status top
  else
    tmux set-option -w -t "$window" pane-border-status off
  fi
done
