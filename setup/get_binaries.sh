#!/bin/bash

DWNLLDIR="$HOME/opt/download"
mkdir -p $DWNLLDIR

INSTALL_DIR="$HOME/opt"
mkdir -p $INSTALL_DIR

# Get ripgrep
curl -L -o $DWNLLDIR/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz
tar xzf $DWNLLDIR/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz --directory $INSTALL_DIR
mv $INSTALL_DIR/ripgrep-13.0.0-x86_64-unknown-linux-musl/rg ~/bin

# Get exa
curl -L -o $DWNLLDIR/exa-linux-x86_64-musl-v0.10.1.zip https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-musl-v0.10.1.zip
unzip $DWNLLDIR/exa-linux-x86_64-musl-v0.10.1.zip -d $INSTALL_DIR/exa
mv $INSTALL_DIR/exa/bin/exa ~/bin/

# Get bat
curl -L -o $DWNLLDIR/bat-v0.22.1-i686-unknown-linux-musl.tar.gz https://github.com/sharkdp/bat/releases/download/v0.22.1/bat-v0.22.1-i686-unknown-linux-musl.tar.gz
tar xzf $DWNLLDIR/bat-v0.22.1-i686-unknown-linux-musl.tar.gz --directory $INSTALL_DIR
mv $INSTALL_DIR/bat-v0.22.1-i686-unknown-linux-musl/bat ~/bin

# Get fd
# You can use fd to generate input for the command-line fuzzy finder fzf. Check fzf github
curl -L -o $DWNLLDIR/fd-v8.7.0-i686-unknown-linux-musl.tar.gz https://github.com/sharkdp/fd/releases/download/v8.7.0/fd-v8.7.0-i686-unknown-linux-musl.tar.gz
tar xzf $DWNLLDIR/fd-v8.7.0-i686-unknown-linux-musl.tar.gz --directory $INSTALL_DIR
mv $INSTALL_DIR/fd-v8.7.0-i686-unknown-linux-musl/fd ~/bin




