# add `~/bin` to `$PATH`
if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi

# load dotfiles
for file in ~/.{path,bash_prompt,exports,aliases}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# append to the Bash history file, rather than overwriting it
shopt -s histappend

# autocorrect typos in path names when using `cd`
shopt -s cdspell

# load bash completion from homebrew
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

# enable tab completion for `g` by marking it as an alias for `git`
__git_complete g __git_main

# add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari SystemUIServer Terminal" killall
