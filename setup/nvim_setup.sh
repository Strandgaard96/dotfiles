#!/bin/bash

# set -x
set -e

mkdir -p ~/opt
cd ~/opt

mkdir -p neovim
cd neovim

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage

# ln -s ~/opt/neovim/nvim.appimage ~/bin/vim
