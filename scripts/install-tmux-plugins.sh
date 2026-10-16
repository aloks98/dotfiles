#!/bin/bash
set -euo pipefail
export PATH="/opt/homebrew/bin:$PATH"
mkdir -p "$HOME/.tmux/plugins"
for repository in tmux-plugins/tpm tmux-plugins/tmux-resurrect tmux-plugins/tmux-open binara-sachin/tmux-ui-manager tmux-plugins/tmux-continuum; do
  plugin="${repository##*/}"
  dest="$HOME/.tmux/plugins/$plugin"
  if [ ! -d "$dest" ]; then
    git clone "https://github.com/$repository.git" "$dest"
  fi
  test -d "$dest/.git"
done
# Build before reloading, so compilation does not block the tmux server.
cargo build --release --locked --manifest-path "$HOME/.tmux/plugins/tmux-ui-manager/Cargo.toml"
if [ -n "${TMUX:-}" ]; then
  tmux source-file "$HOME/.config/tmux/tmux.conf"
  tmux show-option -g @continuum-save-interval
  tmux show-option -g @continuum-restore
  tmux list-keys -T prefix C-s
  tmux list-keys -T prefix C-r
  tmux list-keys -T prefix I
  tmux list-keys -T prefix U
  tmux list-keys -T prefix e
  tmux list-keys -T prefix P
  tmux list-keys -T copy-mode-vi o
  tmux list-keys -T copy-mode-vi S
  echo 'Plugins installed and loaded.'
else
  echo 'Plugins installed. Start tmux, or reload inside it with prefix then r.'
fi
