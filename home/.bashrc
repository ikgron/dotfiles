if [[ "$(uname)" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv bash)"
fi

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

# Setup for bash-completion@2
if [[ "$(uname)" == "Darwin" ]] && [[ -d /opt/homebrew ]]; then
    if [[ -s /opt/homebrew/etc/profile.d/bash_completion.sh ]]; then
        . /opt/homebrew/etc/profile.d/bash_completion.sh
    fi
fi

# Load Git on terminal launch so Git completion works (Linux only)
if [[ "$(uname)" == "Linux" ]]; then
    if [[ -f /usr/share/bash-completion/completions/git ]]; then
        . /usr/share/bash-completion/completions/git
    fi
fi

# Enable tab completion for `g` by marking it as an alias for `git`
if type __git_complete &>/dev/null; then
    __git_complete g __git_main
fi

# Initialize Starship
eval "$(starship init bash)"
