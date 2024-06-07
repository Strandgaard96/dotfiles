# Setup fzf
# ---------
if [[ ! "$PATH" == */home/magstr/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/magstr/.fzf/bin"
fi

source <(fzf --zsh)
