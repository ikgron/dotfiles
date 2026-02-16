# Dotfiles

My configuration for macOS and Linux. Download with a simple command (This will create `~/Projects` if it doesn't already exist):

```bash
curl -L https://codeberg.org/parser/dotfiles/raw/branch/main/remote-install.sh | sh
cd ~/Projects/dotfiles/
```

If on macOS, first run:
```bash
bash homebrew/install.sh
bash homebrew/brew.sh
```

Then bootstrap with:

```bash
bash bootstrap.sh
```

Install apps on Debian based distros:
```bash
bash debian/install.sh
```

Contains setup for Bash, Homebrew, macOS defaults, Alacritty, Zed, and more.

![screenshot](assets/terminal_screenshot.png)

## Credits

A lot of stuff was taken from
<br>
https://github.com/mathiasbynens/dotfiles/
<br>
and
<br>
https://github.com/paulirish/dotfiles/
<br>
and
<br>
https://github.com/paulmillr/dotfiles/
