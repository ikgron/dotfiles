# add `~/bin` to `$PATH`
if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi

# load dotfiles
for file in ~/.{bash_prompt,exports,aliases}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# append to the Bash history file, rather than overwriting it
shopt -s histappend

# autocorrect typos in path names when using `cd`
shopt -s cdspell

if which brew >/dev/null; then

  # bash completion.
  if [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
    source "$(brew --prefix)/share/bash-completion/bash_completion"
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi

  # homebrew completion
  source "$(brew --prefix)/etc/bash_completion.d/brew"
fi

# Enable tab completion for `g` by marking it as an alias for `git`
if type __git_complete &>/dev/null; then
  __git_complete g __git_main
fi

# add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari SystemUIServer Terminal" killall
