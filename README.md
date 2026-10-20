# Dotfiles

My configuration for macOS and Linux.

## Install

Download with:

```bash
curl -L https://codeberg.org/parser/dotfiles/raw/branch/main/scripts/remote-install.sh | bash
cd dotfiles/
```

### macOS

```bash
bash macos/install.sh  # Installs Homebrew and packages
bash macos/bootstrap.sh # Symlinks configs and ~/* stuff, prompts for Git config setup, install VSCodium extensions, symlinks VSCodium settings, runs defaults.sh, switches to modern bash
```

### Linux

```bash
bash linux/install.sh # Installs packages
bash linux/bootstrap.sh # Symlinks configs and ~/* stuff, prompts for Git config setup, install VSCodium extensions, symlinks VSCodium settings, symlinks Linux specific configs and system settings
```

## What gets linked

| Source                 | Destination                   |
| ---------------------- | ----------------------------- |
| `config/<dir>/<file>`  | `~/.config/<dir>/<file>`      |
| `home/.<file>`         | `~/.<file>`                   |
| `vscode/settings.json` | VSCodium `User/settings.json` |

Configs: Fastfetch, Ghostty, Git, Starship, Zed

Shell dotfiles: `.aliases`, `.bash_profile`, `.bashrc`, `.exports`, `.inputrc`

Vim: `.vimrc` + `.vim/`

![screenshot](assets/terminal_screenshot.png)
