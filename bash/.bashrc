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
source $HOME/.bash_paths

# all my aliases
if test -f ~/.bash_aliases; then . ~/.bash_aliases; fi

# bash completion
# The dot before /etc means source the content of the file!
if test -f /etc/bash_completion; then . /etc/bash_completion; fi

# Symbolic link all bash_completion files
#ln -fs `pwd`/dot/bash_completion/* /etc/bash_completion.d/

#if test -f $HOME/git/dotfiles/bash_completion/tma; then . $HOME/git/dotfiles/bash_completion/tma; fi
#if test -f $HOME/git/dotfiles/bash_completion/tmk; then . $HOME/git/dotfiles/bash_completion/tmk; fi

# I would like to have colours in my terminal
if test $TERM == "xterm"; then export TERM=xterm-256color; fi

if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# PS1
#
# 0;30m   Black
# 0;31m   Red
# 0;32m   Green
# 0;33m   Yellow
# 0;34m   Blue
# 0;35m   Purple
# 0;36m   Cyan
# 0;37m   White

#  Customize BASH PS1 prompt to show current GIT repository and branch.
#  by Mike Stewart - http://MediaDoneRight.com

#  SETUP CONSTANTS
#  Bunch-o-predefined colors.  Makes reading code easier than escape sequences.
#  Found here : https://gist.github.com/vratiu/9780109

# Reset
Color_Off="\[\033[0m\]" # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"  # Black
Red="\[\033[0;31m\]"    # Red
Green="\[\033[0;32m\]"  # Green
Yellow="\[\033[0;33m\]" # Yellow
Blue="\[\033[0;34m\]"   # Blue
Purple="\[\033[0;35m\]" # Purple
Cyan="\[\033[0;36m\]"   # Cyan
White="\[\033[0;37m\]"  # White

# Bold
BBlack="\[\033[1;30m\]"  # Black
BRed="\[\033[1;31m\]"    # Red
BGreen="\[\033[1;32m\]"  # Green
BYellow="\[\033[1;33m\]" # Yellow
BBlue="\[\033[1;34m\]"   # Blue
BPurple="\[\033[1;35m\]" # Purple
BCyan="\[\033[1;36m\]"   # Cyan
BWhite="\[\033[1;37m\]"  # White

# Underline
UBlack="\[\033[4;30m\]"  # Black
URed="\[\033[4;31m\]"    # Red
UGreen="\[\033[4;32m\]"  # Green
UYellow="\[\033[4;33m\]" # Yellow
UBlue="\[\033[4;34m\]"   # Blue
UPurple="\[\033[4;35m\]" # Purple
UCyan="\[\033[4;36m\]"   # Cyan
UWhite="\[\033[4;37m\]"  # White

# Background
On_Black="\[\033[40m\]"  # Black
On_Red="\[\033[41m\]"    # Red
On_Green="\[\033[42m\]"  # Green
On_Yellow="\[\033[43m\]" # Yellow
On_Blue="\[\033[44m\]"   # Blue
On_Purple="\[\033[45m\]" # Purple
On_Cyan="\[\033[46m\]"   # Cyan
On_White="\[\033[47m\]"  # White

# High Intensty
IBlack="\[\033[0;90m\]"  # Black
IRed="\[\033[0;91m\]"    # Red
IGreen="\[\033[0;92m\]"  # Green
IYellow="\[\033[0;93m\]" # Yellow
IBlue="\[\033[0;94m\]"   # Blue
IPurple="\[\033[0;95m\]" # Purple
ICyan="\[\033[0;96m\]"   # Cyan
IWhite="\[\033[0;97m\]"  # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"  # Black
BIRed="\[\033[1;91m\]"    # Red
BIGreen="\[\033[1;92m\]"  # Green
BIYellow="\[\033[1;93m\]" # Yellow
BIBlue="\[\033[1;94m\]"   # Blue
BIPurple="\[\033[1;95m\]" # Purple
BICyan="\[\033[1;96m\]"   # Cyan
BIWhite="\[\033[1;97m\]"  # White

# High Intensty backgrounds
On_IBlack="\[\033[0;100m\]"  # Black
On_IRed="\[\033[0;101m\]"    # Red
On_IGreen="\[\033[0;102m\]"  # Green
On_IYellow="\[\033[0;103m\]" # Yellow
On_IBlue="\[\033[0;104m\]"   # Blue
On_IPurple="\[\033[10;95m\]" # Purple
On_ICyan="\[\033[0;106m\]"   # Cyan
On_IWhite="\[\033[0;107m\]"  # White

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"

a=#00FF
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

if [ -z "$PS1NOGIT" ]; then
	export PS1="$PS1"'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # @4 - Clean repository - nothing to commit
    echo "'$Green'"$(__git_ps1 " (%s)"); \
  else \
    # @5 - Changes to working tree
    echo "'$Red'"$(__git_ps1 " {%s}"); \
  fi)"; \
fi)'

fi

export PS1='$(_conda_info)'$PS1"$Color_Off → "

# If this is an xterm set the title to user@host:dir
case "$TERM" in xterm* | rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\w\a\]$PS1"
	;;
*) ;;
esac

# fuzzy search
test -f $HOME/.fzf.bash && source ~/.fzf.bash

# Set ripgrep config path
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# Dont send me messages
if $(tty -s); then mesg n; fi

# Source local bashrc if present
if test -f $HOME/.bashrc_local; then source $HOME/.bashrc_local; fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh

# zoxide init
eval "$(zoxide init bash)"

# TODOS
# Could be interesting to check this prompt
# https://github.com/mathiasbynens/dotfiles/blob/main/.bash_prompt
