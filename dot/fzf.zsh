# Setup fzf
# ---------
if [[ ! "$PATH" == */home/magstr/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/magstr/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/magstr/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/magstr/.fzf/shell/key-bindings.zsh"

# default options
# export FZF_DEFAULT_OPTS='--height 30%
#     --color fg:223,bg:235,hl:208,fg+:229,bg+:237,hl+:167
#     --color info:246,prompt:214,pointer:214,marker:142,spinner:246,header:214'


export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=fg:#c0caf5,bg:#1a1b26,hl:#ff9e64 \
--color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"

# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" 2> /dev/null'
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_DEFAULT_COMMAND='rg --files --hidden --follow 2> /dev/null'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow 2> /dev/null'
export FZF_TMUX=1
export FZF_TMUX_HEIGHT=30%
export FZF_COMPLETION_TRIGGER='**'

export FZF_CTRL_T_OPTS="--no-reverse
--preview 'bat -n --color=always {}'"
export FZF_CTRL_R_OPTS='--no-reverse'
export FZF_ALT_C_OPTS='--no-reverse'
export FZF_COMPLETION_OPTS='--no-reverse'
