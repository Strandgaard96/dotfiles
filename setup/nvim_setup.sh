#!/bin/bash

# set -x
set -e

mkdir -p ~/opt
cd ~/opt

mkdir -p neovim
cd neovim

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage

# Create the vim alias file
cat <<'EOF' >vim
#!/bin/bash

##  TERM is a variable that is set before the command is run each time.
TERM=screen-256color $HOME/opt/neovim/nvim.appimage --appimage-extract-and-run "$@" 2>/dev/null
EOF
