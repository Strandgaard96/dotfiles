#!/bin/bash

# Bash aliases and function
# ---------------------

# Set standard editor
export EDITOR=vim

# Easy access
alias dotf='cd $HOME/git/dotfiles'

# Sort according to modified and see timestamps
alias cl='clear'

# Screen
alias scr='screen -r'

# Git Shortcuts
alias gco='git commit'
alias gca='git commit -a'
alias gad='git add .'
alias gamend='git commit --amend'

alias gd='git diff --color-words'
alias gdc='git diff --cached'
alias gg='git lg'

alias gs='git status -s'
alias gph='git push'
alias gpl='git pull --rebase'

# Call function to show branch commit log
alias ggl='fzf_log'

# Lazygit
alias lg='lazygit'

alias cona='conda activate'
alias cond='conda deactivate'
alias cmol='conda activate mols_test'

alias unmount="fusermount -u"

alias open="wsl-open"

# AWS
alias awso='aws-sso'
alias te='terraform'

# Call function
alias gc='gitclone' # from bin

# tmux
# TODO When starting a new session use tmg as default
alias tm='tmux'
alias tma='tmux_attach'
alias tml='tmux ls'
alias tmk='tmux kill-session -t $1'
alias tmg='tmux new -s $(basename $(pwd))'

# tmux clean. Kill all integer tmux sessions
alias tmclean='tmux ls -F "#{session_name}" | while read -r line; do if [[ $line =~ ^-?[0-9]+$  ]]; then tmux kill-session -t $line; fi; done'

# Clear scrollback buffer if in tmux
if [ -z "$TMUX" ]; then
	alias clear_tm='clear && tmux clear-history'
fi

# Call awesome function
alias e='fast_edit'
alias vi='vim'

# Get outward facing ip
alias myip='echo $(curl -s https://api.ipify.org)'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# if local
test -f $HOME/.bash_aliases.local && source $HOME/.bash_aliases.local

# slurm specific commands that are only set if slurm is present
if test -x "$(command -v sinfo)"; then
	alias s_idle='sinfo | grep idle'
	alias s_busy='sinfo | grep alloc; sinfo | grep mix'
	alias q='squeue -u $USER'
	alias ql='squeue | grep $USER | wc -l'

	# Better squeue format
	alias sq='squeue -u magstr -o "%.18i %.9P %.8j %.8u %.2t %.10M %.6D %R %C %m"'

	# Function to show directory job was submitted from
	function sub_dir() {
		job=$1
		scontrol show job $job | awk -F= '/Command=/{print $2}'
	}
fi

# Check for installed commands and set aliases if active
command -v bat &>/dev/null && alias c='bat -p' || alias c='cat'
command -v fd &>/dev/null && alias fd='fd --hidden --follow' || alias fd='find . -name'
command -v rg &>/dev/null && alias rg='rg --hidden --follow --smart-case --no-ignore 2>/dev/null' || alias rg='grep --color=auto --exclude-dir=.git -R'
command -v eza &>/dev/null && alias ll='eza -l --group-directories-first --sort modified --reverse --icons --no-user --color-scale' || alias ll='ls --color=auto --group-directories-first -lth'
command -v eza &>/dev/null && alias llg='eza -l --group-directories-first --sort modified --reverse --icons --no-user --color-scale --git' || alias ll='ls --color=auto --group-directories-first -lth'
command -v eza &>/dev/null && alias la='eza -l -a' || alias la='ll -A'

# Font
# I followed this guide to get font that worked with icons: https://bytexd.com/how-to-install-nerd-fonts-on-linux/

#------ FUNCTIONS ------
#!/bin/bash

# Command to replace string in previous command

# Set hostn variable based on if using bash or zsh
if [ -z ${HOSTNAME+x} ]; then
	#echo "var is unset setting zsh syntax";
	: ${hostn:=$(hostname)}
else
	#echo "var is set to '$HOSTNAME'";
	: ${hostn:=$HOSTNAME}
fi

# Set alias for repo  based on host
function ga() {
	case $hostn in
	magnus-work)
		cd ${HOME}/Documents/GB_GA
		;;
	*slid*)
		cd ${HOME}/nitrogenase/schrock/GB_GA
		;;
	fend0[1-5].cluster)
		cd ${HOME}/GB_GA
		;;
	*)
		echo "Not configured for this host"
		;;
	esac
}

function git_use_private {
	git config user.name "Strandgaard96"
	git config user.email "magus.str@gmail.com"
}

# Git clone function
function gitclone {

	url=$1
	out=$2

	if [[ $url != *"@"* && $url != *"http"* ]]; then
		git clone git@github.com:$url $out
	else
		git clone $1 $out
	fi

}

# Show commits in branch if in repo
fzf_log() {
	hash=$(git log --color=always --format="%h%d %an %ae %s %cr" "$@" | fzf -m | awk '{print $1}' | xargs)
	echo -n $hash | yank
	git show $(echo $hash | xargs)
}

# https://junegunn.kr/2016/07/fzf-git
# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236

# Will return non-zero status if the current directory is not managed by git
is_in_git_repo() {
	git rev-parse HEAD >/dev/null 2>&1
}

# fzf downards from current line
fzf-down() {
	fzf --height 50% "$@" --border
}

# Look for files in folder and edit. Super nice and fast
function fast_edit() {
	# Quickly go to folder and find the files you want to edit
	if command -v bat &>/dev/null; then
		preview="bat --color always {}"
	else
		preview="cat {}"
	fi

	git branch &>/dev/null
	if test $? -eq 0; then
		$EDITOR $(git ls-files | fzf -m --preview="$preview") $@
	else
		$EDITOR $(fzf -m --preview="$preview") $@
	fi
}

# Set conda env prompt
_conda_info() {
	if test -n "$CONDA_PREFIX"; then
		basename=$(basename $CONDA_PREFIX)
		CONDA_ENV="($basename) "
	else
		CONDA_ENV=""
	fi
	echo -n "$CONDA_ENV"
}

# Extraction function for all types
extract() {
	if [ -f $1 ]; then
		case $1 in
		*.tar.bz2) tar xvjf $1 ;;
		*.tar.gz) tar xvzf $1 ;;
		*.bz2) bunzip2 $1 ;;
		*.rar) unrar x $1 ;;
			#            *.gz)        gunzip $1 ;;
		*.gz) tar xvf $1 ;;
		*.tar) tar xvf $1 ;;
		*.tbz2) tar xvjf $1 ;;
		*.tgz) tar xvzf $1 ;;
		*.zst) tar -I zstd xvzf $1 ;;
		*.zip) unzip $1 ;;
		*.Z) uncompress $1 ;;
		*.7z) 7z x $1 ;;
		*.tar.*) tar xvf $1 ;;
		*) echo "don't know how to extract '$1'..." ;;
		esac
	else
		echo "'$1' is not a valid file!"
	fi
}

# Move 'up' so many directories instead of using several cd ../../, etc.
up() { cd $(eval printf '../'%.0s {1..$1}) && pwd; }

# make directory and change directory
function take {
	mkdir -p $1
	cd $1
}

# Remove symlinks in dir
function remove_sym {
	DIR=$1
	find -L $DIR -maxdepth 1 -type l -delete
}

# Get code snippets
cheat() {
	where="$1"
	shift
	echo "https://cht.sh/$where/$*"
	IFS=+ curl "https://cht.sh/$where/$*"
}

function tmux_attach() {
	# Fuzzy find session if no session is given
	if test ! -z "$1"; then
		tmux attach -dt $1
	else
		tmux attach -dt $(tmux ls | fzf | cut -f1 -d":")
	fi
}
function gr_last() {
	for a in $(find . -name '*orca.out'); do
		grep "FINAL" $a /dev/null | tail -n 1
	done
}

# Better help
function help() {
	"$@" --help 2>&1 | bat --plain --language=help
}

function rs() {
	rsync -avP "$1:$2" $3
}

# Turn up or down the brightness from commandline
alias lightup='brightnessctl -d "intel_backlight" set +10%'
alias lightdown='brightnessctl -d "intel_backlight" set 10%-'

# Tailscale
alias ts=tailscale

# One liner for delte multiple files mathicng patterns recursively
#find . \( -name "*.er" -o -name "*.err" -o -name "*.opt" -o -name "*orca_trj.xyz" -o -name "*.out" \) -type f -delete

### FUN ###
disappointed() { echo -n " ಠ_ಠ \n" | tee /dev/tty | xclip -selection clipboard; }

flip() { echo -n "（╯°□°）╯ ┻━┻\n" | tee /dev/tty | xclip -selection clipboard; }

shrug() { echo -n "¯\_(ツ)_/¯\n" | tee /dev/tty | xclip -selection clipboard; }
