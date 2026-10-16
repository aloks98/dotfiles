# Tmux Shortcuts

Prefix = Ctrl-a (or Caps Lock + A). Release before the next key.
Uppercase letters mean Shift + letter. Ctrl keys keep Control held.
This sheet: arrows / j k scroll, Space next page, / search, n next match,
           g / G top / bottom, q close. No prefix needed in this popup.

## Custom Prefix Shortcuts

- `/`: Open this cheat sheet
- `|`: Split into side-by-side panes in the current directory
- `-`: Split into stacked panes in the current directory
- `c`: New window in the current directory
- `h / j / k / l`: Focus pane left / down / up / right
- `H / J / K / L`: Resize pane left / down / up / right by 5 cells
- `Tab`: Switch to last window; repeat to toggle
- `u`: Set pane label; empty resets to the running command. Labels show only when the window has multiple panes
- `Ctrl-p`: Temporary fish scratch popup in the current directory. Close with exit or Ctrl-d; shell state is not retained
- `e`: Open the session/window/pane manager popup
- `P (Shift-p)`: Open project manager in a new window
- `r`: Reload tmux configuration
- `a / Ctrl-a`: Send a literal Ctrl-a to the program in the pane

## Plugin Prefix Shortcuts

- `Ctrl-s`: Save sessions with tmux-resurrect
- `Ctrl-r`: Restore the most recent tmux-resurrect snapshot
- `I (Shift-i)`: Install TPM plugins
- `U (Shift-u)`: Update TPM plugins
- `Alt-u`: Remove plugin clones no longer in the TPM plugin list

## Copy Mode (Enter With Prefix Then [; No Prefix For Keys Below)

- `v`: Begin selecting text
- `y / Enter`: Copy selection to the macOS clipboard and exit copy mode
- `o`: Open selected URL or file with the macOS default app
- `Ctrl-o`: Open selected file in $EDITOR (plugin defaults to vi)
- `S (Shift-s)`: Search selected text with Google
- `/`: Search scrollback forward; n repeats the search
- `q`: Exit copy mode
- `Mouse drag`: Select and copy to the macOS clipboard immediately Use keyboard selection for Open/Search instead

## Session / Window / Pane Manager (Prefix Then E)

- `j / k, Up/Down`: Move selection within a column
- `h / l, arrows`: Move between session, window, and pane columns
Tab / Shift-Tab Move between columns
- `Enter`: Jump to selected session/window/pane and close popup
- `n`: Create a session/window/pane in the focused column
- `r`: Rename the selection
- `x`: Kill selection, with confirmation
- `z`: Toggle pane zoom
- `Space / m`: Pick up a window/pane to move it
- `g / G`: First / last row
- `Esc / q`: Cancel current action; close popup when idle
- `Mouse`: Select, double-click to jump, drag windows/panes to move

## Project Manager (Prefix Then P)

- `Enter`: Open selected project's details / launch / attach flow
- `/`: Filter projects
- `w`: Choose target window
- `s`: Open settings
- `b`: View live tmux bindings
- `?`: Show project manager help
- `r`: Recreate selected project's session
- `k`: Kill selected project's session
- `q`: Quit

Settings: Tab switches editors; Enter edits; Ctrl-s validates and saves.

Project definitions: ~/.config/tmux-manager/config.yaml (linked to dotfiles).

## Useful Standard Tmux Prefix Shortcuts

- `n / p`: Next / previous window
- `1 ... 9`: Select window by number
- `,`: Rename window (bottom tab)
- `s / w`: Session / window tree
- `Arrow keys`: Focus adjacent pane
- `z`: Toggle pane zoom
- `d`: Detach; session keeps running
- `[ / ]`: Enter scrollback / paste tmux buffer
- `?`: Native tmux key list; q closes it
- `:`: tmux command prompt; list-keys shows all live bindings

Mouse: click panes to focus, drag borders to resize, scroll for scrollback.
Native PREFIX / COPY status indicators show prefix and copy-mode state.
Continuum saves every 15 minutes while the status bar is active and restores
when a new server starts. Snapshots: ~/.tmux/resurrect/; plugins: ~/.tmux/plugins/.
