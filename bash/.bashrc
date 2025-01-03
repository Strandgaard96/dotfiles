### bashrc configuration file ###

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Preserve bash history in multiple terminal windows
export HISTFILE=~/.history
export HISTCONTROL=ignoredups:erasedups:ignorespace
export HISTIGNORE='lth:ls:bf:fg:history:l:sound:dock:undock:headphones:top:htop:l:mocp:rm'
export HISTSIZE=1000000     # big big history
export HISTFILESIZE=1000000 # big big history
shopt -s histappend         # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND='history -a'

# Enable vim mode
set -o vi

# source and export paths before aliases to ensure binaries are detected in ~/bin
if test -f ~/.bash_paths; then . ~/.bash_aliases; fi

# all my aliases
if test -f ~/.bash_aliases; then . ~/.bash_aliases; fi

# bash completion
if test -f /etc/bash_completion; then . /etc/bash_completion; fi

# Run this to get the file curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.bash_git
# Source git file to have promp work
if test -f $HOME/.bash_git; then source $HOME/.bash_git; fi

# Get bash prompt
if test -f ~/.bash_prompt; then . ~/.bash_prompt; fi

if test -f ~/.bash_functions; then . ~/.bash_functions; fi

if test $TERM == "xterm"; then export TERM=xterm-256color; fi

if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# Set ripgrep config path
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# Source local bashrc if present
if test -f $HOME/.bashrc_local; then source $HOME/.bashrc_local; fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh

# zoxide init
eval "$(zoxide init bash)"
. "$HOME/.cargo/env"
