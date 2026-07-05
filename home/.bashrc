if [[ "$OSTYPE" == darwin* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv bash)"
fi

# Everything below is for interactive shells only
[[ $- == *i* ]] || return 0

# Load dotfiles
for file in ~/.{exports,aliases}; do
    [[ -r "$file" && -f "$file" ]] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Append to history instead of overwriting it
shopt -s histappend

# Flush history after each command so other terminals see it immediately
PROMPT_COMMAND="history -a${PROMPT_COMMAND:+; $PROMPT_COMMAND}"

# Record timestamps in history
HISTTIMEFORMAT='%F %T '

# Setup for bash-completion@2 (macOS) / bash-completion (Linux)
if [[ "$OSTYPE" == darwin* ]]; then
    if [[ -s /opt/homebrew/etc/profile.d/bash_completion.sh ]]; then
        . /opt/homebrew/etc/profile.d/bash_completion.sh
    fi
elif [[ "$OSTYPE" == linux* ]]; then
    if [[ -r /usr/share/bash-completion/bash_completion ]]; then
        . /usr/share/bash-completion/bash_completion
    fi
fi

# Load Git completion
if ! type __git_complete &>/dev/null; then
    for f in /usr/share/bash-completion/completions/git "${HOMEBREW_PREFIX:-/opt/homebrew}/share/bash-completion/completions/git"; do
        [[ -r "$f" ]] && . "$f" && break
    done
    unset f
fi

# Enable tab completion for `g` by marking it as an alias for `git`
if type __git_complete &>/dev/null; then
    __git_complete g __git_main
fi

# Initialize Starship
if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
fi
