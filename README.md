# Dotfiles

Personal macOS configuration for Apple Silicon. Fish + Fisher + Starship, Alacritty with BlexMono Nerd Font Mono (13 pt and copy on selection), and Zed with its default fonts, Ayu Dark theme, JetBrains keymap and the project panel on the left.

## Contents

- `config/`: curated shell and editor preferences; tool initialization is guarded where appropriate.
- `config/fish/fish_plugins`: Fisher and fzf.fish; generated plugin files are restored through Fisher.
- `git/config`: delta preferences without identity, remotes or credentials.
- `Brewfile`: selected command-line tools, Alacritty, Zed and BlexMono. Package versions follow Homebrew; project runtime versions belong in each project's mise.toml.
- `install.sh`: links the tracked config files and backs up existing destinations. It does not install packages, change the login shell, start services or alter Git settings.

Histories, fish universal-variable state, credentials, Docker authentication, VM data, mise trust records and Zed's trust-all-worktrees setting are intentionally excluded. Plugin settings and abbreviations made outside these files may need to be added explicitly.

## Restore

Install Homebrew from https://brew.sh first. In fish:

```fish
cd ~/projects/dotfiles
brew bundle --file Brewfile
bash install.sh
exec fish
```

The script creates file symlinks into this repository. Keep it at its final location after installation. Existing files are moved into a timestamped directory under `~/.local/state/dotfiles/backups/`. To undo a link, remove that symlink and move its corresponding backed-up file into place.

### Fish plugins

With fish active, bootstrap Fisher from its official repository, then install the saved plugin list:

```fish
curl -fsSL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
fisher update
```

Fisher writes into its functions/completions directories; those generated files are not tracked here.

### Git

Include the shared preferences once, keeping your identity and authentication local:

```fish
git config --global --add include.path ~/projects/dotfiles/git/config
```

If existing global settings override these values, review them with `git config --show-origin --get core.pager`. Configure your own Git name/email and hosting authentication separately.

### Docker and Colima

```fish
mkdir -p ~/.docker/cli-plugins
ln -sfn /opt/homebrew/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose
ln -sfn /opt/homebrew/opt/docker-buildx/bin/docker-buildx ~/.docker/cli-plugins/docker-buildx
colima start
docker run --rm hello-world
```

### Default shell

Alacritty and Zed explicitly launch Homebrew fish. To change a new machine's account login shell as well, register `/opt/homebrew/bin/fish` in `/etc/shells` and run `chsh -s /opt/homebrew/bin/fish`.

## Updating

After running install.sh, edits to linked config files update this repository. Review `git diff` before committing. Re-run install.sh when adding tracked files. Store personal overrides and secrets separately; review every change before pushing to a remote.

No remote is configured by this setup.

### tmux

The config uses fish, mouse/trackpad scrolling, clipboard copying, and a cyan/purple status bar.
Map Caps Lock to Control in macOS System Settings > Keyboard > Keyboard Shortcuts > Modifier Keys (choose each keyboard). Then Caps Lock + A is the prefix. Release it before the next key.

Start: `tmux new -A -s main`. Prefix shortcuts:

- `|` / `-`: side-by-side / stacked panes in the current directory.
- Arrow keys or `h j k l`: navigate panes; uppercase `H J K L`: resize.
- `c`: new window; `n` / `p`: next / previous window.
- `z`: zoom pane; `d`: detach; `r`: reload config.
- `[`: scrollback; `v` selects, `y` copies to the macOS clipboard, `q` exits.
- Drag to select and copy; click panes to focus, drag borders to resize.
- `a`: send Ctrl-a through to the shell.

Reattach with `tmux attach -t main`. Sessions survive terminal closure, but not a reboot.

### tmux plugins

After restoring config symlinks, run `bash scripts/install-tmux-plugins.sh` to install TPM, Resurrect, Open and Continuum. Run inside tmux to also reload and check bindings. Plugin checkouts and saved sessions live under ~/.tmux, outside this repo.

Continuum saves every 15 minutes while the tmux status bar is active and restores when a new tmux server starts. Start it after reboot with `tmux new -A -s main`; automatic restore does not launch tmux itself. Saves live in `~/.tmux/resurrect/` (the `last` symlink selects the latest snapshot), and plugin clones live in `~/.tmux/plugins/`. Layouts and directories are restored; arbitrary live process state is not preserved. Native tmux formatting displays PREFIX and COPY indicators.

After Caps Lock + A (release before the next key): Ctrl-s saves, Ctrl-r restores, uppercase I installs plugins, uppercase U updates plugins. In copy mode, use v to select and o to open a URL/file; Shift-s searches selected text online. Mouse selection copies immediately, so use keyboard selection for Open.

Keep TPM initialization at the bottom of tmux.conf and Continuum last in the plugin list.

### tmux workspace managers

`brew bundle --file Brewfile` installs Rust (to build tmux-ui-manager) and `okakoh/tap/tmux-manager`. Run `bash install.sh` to link the project configuration, then `bash scripts/install-tmux-plugins.sh` to clone/build the popup plugin. Clones and compiled plugin files stay in `~/.tmux/plugins/`.

- Prefix then `e`: session/window/pane manager. Use `h j k l` or arrows to navigate, Enter to jump, `n` to create, `r` to rename, Space to move, and `q` to close. `x` asks before killing the selection.
- Prefix then uppercase `P`: project manager in a new window. Enter launches/attaches the selected project; `/` filters; `s` opens settings; `?` shows help; `q` quits. The starter dotfiles workspace has fish and lazygit windows and attaches to an existing session without recreating it.
- Prefix then `s` / `w`: original tmux session/window trees remain available.

Project definitions are in `config/tmux-manager/config.yaml`, linked to `~/.config/tmux-manager/config.yaml`. Review changes made through the settings UI with `git diff`; keep private paths and secrets out of the shared config. Launch from fish directly with `env SHELL=/bin/sh tmux-manager`: its command wrapper needs a POSIX shell, while the shell tool explicitly starts fish.
