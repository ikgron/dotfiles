# Add `~/bin` to `$PATH`
if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi

# Load dotfiles
for file in ~/.{bash_prompt,exports,aliases}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Setup for homebrew bash-completion@2
if [[ $(uname) == "darwin" ]] && command -v brew >/dev/null; then
  BREW_PREFIX=$(brew --prefix)

  if [[ -s $BREW_PREFIX/etc/profile.d/bash_completion.sh ]]; then
    . "$BREW_PREFIX/etc/profile.d/bash_completion.sh"
  fi

  # Homebrew completion
  [ -f "$BREW_PREFIX/etc/bash_completion.d/brew" ] && source "$BREW_PREFIX/etc/bash_completion.d/brew"
fi

# Enable tab completion for `g` by marking it as an alias for `git`
if type __git_complete &>/dev/null; then
  __git_complete g __git_main
fi

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari SystemUIServer Terminal" killall
