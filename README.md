# Dotfiles

Arch Linux dotfiles

## Quick Start

```bash
make setup    # Full system setup
```

Or just the dotfiles:

```bash
make dotfiles
```

## Structure

- `ghostty/` - Ghostty terminal config
- `assets/` - SDDM theme
- `bin/` - User scripts
- `git/` - Git config
- `hypr/` - Hyprland config
- `nvim/` - Neovim config
- `tmux/` - Tmux config
- `waybar/` - Waybar config
- `wofi/` - Wofi config
- `zsh/` - Zsh config

## Manual Deployment

```bash
stow wofi waybar ghostty zsh nvim tmux git
```

## Requirements

See Makefile for full package list.
