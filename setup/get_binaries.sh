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


# Get fd




