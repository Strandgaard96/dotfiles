#!/bin/bash

# set -x
set -e
set -u

# Download and install a nice font called 'Monaco Linux'
# wget -O Monaco_linux.ttf http://www.gringod.com/wp-upload/software/Fonts/Monaco_Linux.ttf

wget -O monaco_linux.ttf https://github.com/todylu/monaco.ttf/raw/master/monaco.ttf
wget -O monaco_linux-powerline.ttf https://gist.github.com/epegzz/1634235/raw/4691e901750591f9cab0b4ae8b7c0731ebf28cce/Monaco_Linux-Powerline.ttf

# sudo mkdir /usr/share/fonts/truetype/custom
#
# sudo mv monaco_linux.ttf /usr/share/fonts/truetype/custom/
# sudo mv monaco_linux-powerline.ttf /usr/share/fonts/truetype/custom/


if [[ $(uname -s) == Linux ]]
then
    mv monaco_linux.ttf ${HOME}/.fonts
    mv monaco_linux-powerline.ttf ${HOME}/.fonts
else
    # Darwin
    mv monaco_linux.ttf ${HOME}/Library/Fonts/
    mv monaco_linux-powerline.ttf ${HOME}/Library/Fonts/
fi
