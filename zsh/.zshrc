#!/usr/bin/env zsh

#zmodload zsh/zprof

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
unsetopt CDABLE_VARS

# Disable auto-update prompt
DISABLE_AUTO_UPDATE=true

# TODO https://www.youtube.com/watch?v=eLEo4OQ-cuQ
# TODO https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52

# export fpath=($HOME/opt/zsh/share/zsh/5.8/functions "${fpath[@]}" )

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# colors
#load colors
autoload colors && colors
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
    eval $COLOR='%{$fg_no_bold[${(L)COLOR}]%}'  #wrap colours between %{ %} to avoid weird gaps in autocomplete
    eval BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done
eval RESET='%{$reset_color%}'

# https://github.com/subnixr/minimal/blob/master/minimal.zsh
MNML_OK_COLOR="2"
MNML_ERR_COLOR="1"

function git_fast_status() {
    local color="%{\e[0;32m%}"
    local bname="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"

    if test -n "$bname"; then
        git diff-index --quiet HEAD --
        if test ! $? -eq 0; then
            color="%{\e[0;31m%}"
        fi
    fi

    printf '%b' "$color$bname%{\e[0m%}"
}

function mnml_git {
    local statc="%{\e[0;32m%}" # assume clean
    local bname="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"

    if [ -n "$bname" ]; then
        if [ -n "$(git status --porcelain 2> /dev/null)" ]; then
            statc="%{\e[0;31m%}"
        fi
        printf '%b' "$statc$bname%{\e[0m%}"
    fi
}

function conda_env {
    if test -n "$CONDA_PREFIX"
    then
        local basename=$(basename $CONDA_PREFIX)
        CONDA_ENV="($basename)"
    else
        CONDA_ENV=""
    fi
    print "%b" "$CONDA_ENV"
}

# %m hostname
# %n usernamne
# %1~ dirname

PROMPT='→ '
# RPROMPT='%1~ $(mnml_git)'
# RPROMPT='$(conda_env) $(mnml_git) %(4~|.../%3~|%~)'
RPROMPT='$(conda_env) $(git_fast_status) %(4~|.../%3~|%~)'


# Check for host names
#valid_hostnames=(laptop)
#needle=`hostname`
# matching https://unix.stackexchange.com/questions/411304/how-do-i-check-whether-a-zsh-array-contains-a-given-value
#if [[ ${valid_hostnames[(ie)$needle]} -le ${#valid_hostnames} ]]
#then
#    PROMPT='> '
#else
    # PROMPT='%F{blue}%m > '
#    PROMPT='%m > '
#fi

case $(hostname) in
    sunray )
        PROMPT='${GREEN}%m$RESET ${GREEN}>$RESET ';;
    fend0[1-5].cluster )
        PROMPT='${PURPLE}%m$RESET ${PURPLE}>$RESET ';;
    magnus-work )
        # PROMPT='${BLUE}%m$RESET ${BLUE}>$RESET ';;
        PROMPT=' ${BLUE}>$RESET ';;
    *slid* )
        export EASYBUILD_PREFIX_ME=/home/niflheim/jchang/modules
        module use $EASYBUILD_PREFIX_ME/modules/all
        export EASYBUILD_PREFIX=/home/energy/modules
        module use $EASYBUILD_PREFIX/modules/all
        export VASP_PP_PATH=/home/niflheim2/arbh/pot/
        export VASP_COMMAND='mpiexec vasp_std'
        module load X11
        export SCMLICENSE=/home/energy/modules/software/ADF/DEV/license_pdes.txt
        export SCM_OPENGL1_FALLBACK=1
        export SCM_OPENGL_SOFTWARE=1
        # set p4vasp environment variables
        export PATH=$PATH:/home/energy/arbh/p4vasp/bin
        module use /home/energy/stly/modules/modules/all
        PROMPT='${YELLOW}%m$RESET ${YELLOW}>$RESET ';;
    * )
        PROMPT='${BLUE}%m ${YELLOW}>$RESET ';;
esac


# Remove rprompt on enter
setopt TRANSIENT_RPROMPT

# Plugins
plugins=(
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-vi-mode
)
VI_MODE_SET_CURSOR=true

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

test -d $ZSH && source $ZSH/oh-my-zsh.sh


# History
HISTSIZE=10000000
SAVEHIST=10000000
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
HISTORY_IGNORE="b:e:cd:gs:gd:ll:ls:"
ZSH_AUTOSUGGEST_HISTORY_IGNORE="cd *"
ZSH_AUTOSUGGEST_COMPLETION_IGNORE="git *"

# I don't like underline
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# all my paths
source ${HOME}/.bash_paths

if test -f ~/.bash_aliases; then . ~/.bash_aliases; fi

# export PATH="$HOME/opt/anaconda3/bin:$PATH"  # commented out by conda initialize

# fuzzy search
test -f ~/.fzf.zsh && source ~/.fzf.zsh

# Silver surver init for fzf. Currently not used.  
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g "" "${FZF_BASE:-.}"'
    export FZF_CTRL_T_COMMAND='ag -p ~/.gitignore -g "" "${FZF_BASE:-.}"'
fi

# Need to be set for ripgrep to find config.
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc


# home and end
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

# Source local zshrc if present. 
test -f $HOME/.zshrc.local && source $HOME/.zshrc.local

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# zoxide
eval "$(zoxide init zsh)"

# Set up fzf key bindings and fuzzy completion
# source <(fzf --zsh)
# Define an init function and append to zvm_after_init_commands
function my_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}
zvm_after_init_commands+=(my_init)

# Only works on zsh
#matrix() { echo -e "\e[1;40m" ; clear ; while :; do echo $LINES $COLUMNS $(( $RANDOM % $COLUMNS)) $(( $RANDOM % 72 )) ;sleep 0.05; done|awk '{ letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()"; c=$4;        letter=substr(letters,c,1);a[$3]=0;for (x in a) {o=a[x];a[x]=a[x]+1; printf "\033[%s;%sH\033[2;32m%s",o,x,letter; printf "\033[%s;%sH\033[1;37m%s\033[0;0H",a[x],x,letter;if (a[x] >= $1) { a[x]=0; } }}' }
