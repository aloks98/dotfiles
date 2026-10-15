#!/bin/bash
set -euo pipefail
repo_dir="$(cd "$(dirname "$0")" && pwd)"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"
backup_dir="$HOME/.local/state/dotfiles/backups/$(date +%Y%m%d-%H%M%S)-$$"
while IFS= read -r -d '' source_file; do
  relative="${source_file#"$repo_dir/config/"}"
  target="$config_dir/$relative"
  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source_file" ]; then
    continue
  fi
  mkdir -p "$(dirname "$target")"
  if [ -e "$target" ] || [ -L "$target" ]; then
    mkdir -p "$backup_dir/$(dirname "$relative")"
    mv "$target" "$backup_dir/$relative"
  fi
  ln -s "$source_file" "$target"
  printf 'Linked %s
' "$target"
done < <(find "$repo_dir/config" -type f -print0)
printf '
Backups, if needed: %s
' "$backup_dir"
printf 'Next: follow README.md for Fisher, Git and Docker plugin setup.
'
