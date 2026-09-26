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
bash macos/install.sh  # Installs Homebrew, installs packages, switches to modern bash
bash scripts/bootstrap.sh # Symlinks configs, prompts for Git config setup, applies macOS defaults
bash scripts/bootstrap-mac.sh # Symlinks VSCodium settings and install extensions, runs defaults.sh
```

### Linux

```bash
bash linux/arch/install.sh
```

or

```bash
bash linux/debian/install.sh
```

then

```bash
bash scripts/bootstrap.sh  # Symlinks configs, prompts for Git config setup, runs debian/install.sh
bash scripts/boostrap-linux.sh # Symlinks Linux specific configs and system settings, symlinks VSCodium settings
```

## What gets linked

| Source | Destination |
|---|---|
| `config/<dir>/` | `~/.config/<dir>/` |
| `home/.<file>` | `~/.<file>` |
| `vscode/settings.json` | VSCodium `User/settings.json` |

Configs: Fastfetch, Ghostty, Git, Starship, Zed

Shell dotfiles: `.aliases`, `.bash_profile`, `.bashrc`, `.exports`, `.inputrc`

Vim: `.vimrc` + `.vim/`

## Uninstall

```bash
bash scripts/uninstall.sh  # only removes symlinks bootstrap.sh created
```

![screenshot](assets/terminal_screenshot.png)
