#!/bin/bash

# set -x
set -e
set -u

# mkdir ~/.local/share/fonts
# echo "[-] Download fonts [-]"
# echo "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Mononoki.zip"
# wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Mononoki.zip
# unzip Mononoki.zip -d ~/.local/share/fonts
# fc-cache -fv
# echo "done!"

font_url='https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Mononoki.zip'
font_name=${font_url##*/}
wget ${font_url} && unzip ${font_name} -d ~/.fonts && fc-cache -fv
