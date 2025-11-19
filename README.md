# Dotfiles

This repository contains my personal configuration files (dotfiles) for various tools and utilities. It includes a bootstrap script to easily install and configure the environment based on the desired profile.

## Contents

The repository includes configurations for:

*   **Window Manager**: [i3](https://i3wm.org/) (includes [Polybar](https://polybar.github.io/), [Picom](https://github.com/yshui/picom), [Rofi](https://github.com/davatorium/rofi), [Dunst](https://dunst-project.org/), [i3lock](https://i3wm.org/i3lock/))
*   **Terminal**: [Alacritty](https://alacritty.org/)
*   **Shell**: [Zsh](https://www.zsh.org/) (configured with [Zimfw](https://zimfw.sh/))
*   **Editor**: [Vim](https://www.vim.org/) (includes plugins and custom configuration)
*   **Aliases**: Useful shell aliases

## Usage

To install the dotfiles, clone the repository and run the `bootstrap.sh` script.

```bash
git clone https://github.com/hieunt79/dotfiles
cd dotfiles
./bootstrap.sh <mode> [--debug]
```

### Modes

The script supports three modes:

1.  **`server`**
    *   Minimal installation suitable for servers.
    *   Installs: Vim configuration (basic), Aliases.
    *   Does **NOT** install: Zsh plugins, GUI applications.

2.  **`dev`**
    *   Development environment installation.
    *   Installs: Vim configuration (with plugins), Zsh configuration (with Zimfw), Aliases.
    *   Does **NOT** install: GUI applications (Alacritty, i3).

3.  **`graphic`**
    *   Full graphical environment installation.
    *   Installs: Everything in `dev` mode **PLUS** GUI applications.
    *   Installs & Configures: Alacritty, i3, Polybar, Picom, Rofi, Dunst, i3lock.
    *   **Note**: This mode will attempt to install packages using `apt` (requires `sudo`).

### Example

```bash
# Install minimal server config
./bootstrap.sh server

# Install development config (vim plugins, zsh)
./bootstrap.sh dev

# Install full graphical environment (i3, alacritty, etc.)
./bootstrap.sh graphic
```
