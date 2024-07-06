# Setup fzf
# ---------
if [[ ! "$PATH" == */home/magstr/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/magstr/.fzf/bin"
fi

source <(fzf --zsh)

# Fzf
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none
  --color=bg+:#283457 \
  --color=bg:#16161e \
  --color=border:#27a1b9 \
  --color=fg:#c0caf5 \
  --color=gutter:#16161e \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude=.git'
export FZF_CTRL_T_COMMAND='fd -t f -HF -E=.git --exclude=.git -I'
# export FZF_TMUX_OPTS='-p 90%'

