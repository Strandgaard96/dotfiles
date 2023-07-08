#!/bin/bash

# set -x
set -e
set -u


mkdir ~/.local/share/fonts
echo "[-] Download fonts [-]"
echo "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Mononoki.zip"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Mononoki.zip
unzip Mononoki.zip -d ~/.local/share/fonts
fc-cache -fv
echo "done!"

