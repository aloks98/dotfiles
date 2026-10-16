#!/bin/sh
set -eu
config_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
width="$(tput cols 2>/dev/null || printf '80')"
export LESS= LESSHISTFILE=- PAGER='/usr/bin/less -R -i'
export CLICOLOR_FORCE=1 COLORTERM=truecolor
exec /opt/homebrew/bin/glow -s "$config_dir/cheatsheet-style.json" -w "$width" -p "$config_dir/cheatsheet.md"
