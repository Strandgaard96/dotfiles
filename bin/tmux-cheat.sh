#!/usr/bin/env bash

# https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/bin/tmux-cht.sh

##################
#  NOT WORKING  #
# Opens new pane and does fzf searhc. But nothing happens when you select something
##################

# set -x
set -e
set -u

# Query cheat.sh in new tmux window 

tmux neww -n "cheat" bash -c "cheat.sh"
