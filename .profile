
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Use ALL the colors!
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi

# Show contents of directory after cd-ing into it
chpwd() {
  ls -lrthG
}

# Save a ton of history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

## ALIASES

# Git Shortcuts
alias amend='git commit --amend'
alias gca='git commit -a'
alias gd='git diff'
alias gdc='git diff --cached'
alias gg='git lg'

alias gph='git push'
alias gpl='git pull'

alias gc='git clone'

# Others Shortcuts
alias l='ls -lah'
alias cd.='cd ..'
alias cd..='cd ..'
alias u='cd ..'
alias v='vim -p'
alias vi='vim -p'

# Functions
function take {
  mkdir $1
  cd $1
}



