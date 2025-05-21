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

# Enable vim mode
#set -o vi

# source and export paths before aliases to ensure binaries are detected in ~/bin
if test -f ~/.bash_paths; then . ~/.bash_paths; fi

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

eval "$(zoxide init bash)"
# Disable annoying warning
# _ZO_DOCTOR=0

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

# Add fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if test -f $HOME/.cargo; then source $HOME/.cargo/env; fi

export GPG_TTY=$(tty)

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# --- Terminal Title Function ---
# Sets the terminal window title using escape sequences.
# Usage: settitle "New Title"
settitle() {
    # Check if an argument was provided
    if [ -n "$1" ]; then
        # \033]0; = Start sequence for setting title
        # $1     = The desired title string
        # \a     = Bell character, often used to terminate the sequence
        echo -ne '\033]0;'"$1"'\a'
    fi
}

# --- Color Definitions ---
# Use \[ and \] around non-printing escape sequences for correct line wrapping in Bash.
COLOR_DEV='\[\e[38;5;82m\]'   # Green for 'dev' (using 256-color code)
COLOR_NONP='\[\e[38;5;220m\]' # Yellow for 'nonp'
COLOR_PREP='\[\e[38;5;208m\]' # Orange for 'prep'
COLOR_PROD='\[\e[38;5;196m\]' # Red for 'prod'
COLOR_USER='\[\e[38;5;39m\]'  # Bluish for username
COLOR_AT='\[\e[97m\]'         # Bright White for @
COLOR_HOST='\[\e[38;5;34m\]'  # Blue for hostname
COLOR_PATH='\[\e[38;5;33m\]'  # Yellowish for path
COLOR_GIT='\[\e[91m\]'        # Red for git info
COLOR_STATUS_ERR='\[\e[31m\]' # Red for non-zero exit status
COLOR_RESET='\[\e[0m\]'       # Reset all attributes

# --- Git Prompt Function Check ---
# Check if __git_ps1 function exists (usually loaded from git's bash completion script)
# If it doesn't exist, define a dummy function to avoid errors.
if ! type -t __git_ps1 &>/dev/null; then
    __git_ps1() { :; } # Define a no-op function
    # Optional: Print a warning
    # echo "Warning: __git_ps1 function not found. Git prompt info disabled." >&2
fi

# --- Main Prompt Setting Function ---
# This function is called by PROMPT_COMMAND before each prompt.
set_bash_prompt() {
    local exit_status=$? # Capture exit status immediately

    # --- Determine AWS Profile and Color ---
    local profile_str=""
    local profile_color="${COLOR_RESET}" # Default to reset
    local title_profile=""               # Profile name for the title

    if [ -n "$AWS_SSO_PROFILE" ]; then
        # Use a simple indicator like 👤 or just the profile name
        # Corrected the mojibake 'Γÿü∩╕Å' to a simple space prefix
        profile_str=" $AWS_SSO_PROFILE "
        title_profile="$AWS_SSO_PROFILE" # Use raw profile for title

        case "$AWS_SSO_PROFILE" in
        *dev*) profile_color="${COLOR_DEV}" ;;
        *nonp*) profile_color="${COLOR_NONP}" ;;
        *prep*) profile_color="${COLOR_PREP}" ;;
        *prod*) profile_color="${COLOR_PROD}" ;;
        *) profile_color='\[\e[97m\]' ;; # Default to white if no match
        esac
        profile_str="${profile_color}${profile_str}${COLOR_RESET}"
    fi

    # --- Check for Python Virtual Environment ---
    local venv_str=""
    if [ -n "$VIRTUAL_ENV" ]; then
        # Use the standard VIRTUAL_ENV variable
        venv_str="(.venv) "
        # Alternative: show the name: venv_str="($(basename "$VIRTUAL_ENV")) "
    fi

    # --- Set Terminal Title ---
    # Set title to AWS profile if available, otherwise fallback to user@host:path
    if [ -n "$title_profile" ]; then
        settitle "$title_profile"
    else
        settitle "\u@\h:\w" # Use standard bash prompt escapes for title
    fi

    # --- Construct the PS1 String ---
    # First line: Profile, Venv, User, Host, Path, Git
    PS1="${profile_str}${venv_str}${COLOR_USER}\u${COLOR_AT}@${COLOR_HOST}\h${COLOR_RESET}:${COLOR_PATH}\w${COLOR_GIT}\$(__git_ps1 ' (%s)')${COLOR_RESET}"
    # Newline
    PS1+="\n"
    # Second line: Exit status (if non-zero) and prompt symbol
    # if [ $exit_status -ne 0 ]; then
    #     PS1+="${COLOR_STATUS_ERR}${exit_status} ${COLOR_RESET}" # Show non-zero exit status in red
    # fi
    PS1+="> " # Prompt symbol ($ for user, # for root) followed by space

    # Note: We don't need to manually call settitle here anymore,
    # as it's handled within set_bash_prompt which runs via PROMPT_COMMAND.
}

# --- Set PROMPT_COMMAND ---
# This command is executed just before Bash displays the prompt.
PROMPT_COMMAND="set_bash_prompt;__zoxide_hook;echo"

# (Optional) Explicitly unset PS1 before setting it via PROMPT_COMMAND
# This can prevent potential issues if PS1 was complexly defined elsewhere.
# unset PS1

# Note: No need to call set_bash_prompt manually here,
# PROMPT_COMMAND will handle it before the *first* prompt appears.
#
#
# This needs to be turned of for lazyvim clipboard to work when using WSL
export WAYLAND_DISPLAY=

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

complete -C /usr/bin/terraform terraform
