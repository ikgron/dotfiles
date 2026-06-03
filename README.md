# Dotfiles

My configuration for macOS and Linux. Download with a simple command (This will create `~/Projects` if it doesn't already exist):

```bash
curl -L https://codeberg.org/parser/dotfiles/raw/branch/main/remote-install.sh | sh
cd ~/Projects/dotfiles/
```

If on macOS, first run:
```bash
bash macos/homebrew_install.sh
```

Then bootstrap with:

```bash
bash bootstrap.sh
```

Contains setup for Bash, Homebrew, macOS defaults, Alacritty, Ghostty, Zed, and more.

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
