# Dotfiles

My configuration for macOS and Linux.

## Install

Download with:

```bash
curl -L https://codeberg.org/parser/dotfiles/raw/branch/main/remote-install.sh | sh
cd dotfiles/
```

### macOS

```bash
homebrew/install.sh  # installs Homebrew, installs packages, switches to modern bash
bootstrap.sh         # symlinks configs, prompts for Git config setup, applies macOS defaults
```

### Linux (Debian-based)

```bash
bootstrap.sh  # symlinks configs, prompts for Git config setup, runs debian/install.sh
```

## What gets linked

| Source | Destination |
|---|---|
| `config/<dir>/` | `~/.config/<dir>/` |
| `home/.<file>` | `~/.<file>` |

Configs: Alacritty, Ghostty, Git, Starship, Zed  
Shell dotfiles: `.aliases`, `.bash_profile`, `.bashrc`, `.exports`, `.inputrc`

## Uninstall

```bash
uninstall.sh  # removes only symlinks bootstrap.sh created; leaves ~/.config/git/config.local
```

![screenshot](assets/terminal_screenshot.png)
