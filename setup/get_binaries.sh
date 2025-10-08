#!/bin/bash

DWNLLDIR="$HOME/opt/download"
mkdir -p $DWNLLDIR

INSTALL_DIR="$HOME/opt"
mkdir -p $INSTALL_DIR

# Get ripgrep
curl -L -o $DWNLLDIR/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz
tar xzf $DWNLLDIR/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz --directory $INSTALL_DIR
mv $INSTALL_DIR/ripgrep-13.0.0-x86_64-unknown-linux-musl/rg ~/bin

# Get bat
curl -L -o $DWNLLDIR/bat-v0.22.1-i686-unknown-linux-musl.tar.gz https://github.com/sharkdp/bat/releases/download/v0.22.1/bat-v0.22.1-i686-unknown-linux-musl.tar.gz
tar xzf $DWNLLDIR/bat-v0.22.1-i686-unknown-linux-musl.tar.gz --directory $INSTALL_DIR
mv $INSTALL_DIR/bat-v0.22.1-i686-unknown-linux-musl/bat ~/bin

# Get diff-so-fancy
curl -L -o $INSTALL_DIR/diff-so-fancy https://github.com/so-fancy/diff-so-fancy/releases/latest/download/diff-so-fancy
mv $INSTALL_DIR/diff-so-fancy ~/bin

# Setup eza
# sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

# Get fd
# You can use fd to generate input for the command-line fuzzy finder fzf. Check fzf github
curl -L -o $DWNLLDIR/fd-v8.7.0-i686-unknown-linux-musl.tar.gz https://github.com/sharkdp/fd/releases/download/v8.7.0/fd-v8.7.0-i686-unknown-linux-musl.tar.gz
tar xzf $DWNLLDIR/fd-v8.7.0-i686-unknown-linux-musl.tar.gz --directory $INSTALL_DIR
mv $INSTALL_DIR/fd-v8.7.0-i686-unknown-linux-musl/fd ~/bin

# Get and install zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# Dops
wget "https://github.com/Mikescher/better-docker-ps/releases/latest/download/dops_linux-amd64-static" -O "${HOME}/bin/dops" && sudo chmod +x "/usr/local/bin/dops"

# Get tre
curl -L -o $DWNLLDIR/tre-v0.4.0-x86_64-unknown-linux-musl.tar.gz https://github.com/dduan/tre/releases/download/v0.4.0/tre-v0.4.0-x86_64-unknown-linux-musl.tar.gz
tar xzf $DWNLLDIR/tre-v0.4.0-x86_64-unknown-linux-musl.tar.gz --directory $INSTALL_DIR
mv $INSTALL_DIR/tre-v0.4.0-x86_64-unknown-linux-musl.tar.gz/tre ~/bin

# TODO
# Make something that also moves the manual pages for the stuff!!!!!!
