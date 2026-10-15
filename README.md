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
