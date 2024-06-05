# Dotfiles

My dotfiles.

![desktop](https://raw.githubusercontent.com/Strandgaard96/dotfiles/main/dot/desktop.png)

## Setup

A makefile is used to create all relevant symlinks and directories. Also
downloads various tools. There are multiple build targets. If you are
running on a system without sudo, do install_remote

```bash
make install_apt # only for systems you have sudo. Installs all packages via apt-get. Much of the functionality in the dotfiles rely on installing these packages

make install # Set everything up on local machine with sudo.

make install_remote # Install without certain features. To be used on remote to prevent compiler and version issues that can not be fixed without sudo.
```

## My tools

Useful tools for linux commandline that are incredibly useful.

- [bat](https://github.com/sharkdp/bat) - A cat(1) clone with wings
- [exa](https://github.com/ogham/exa) - A Modern replacement for ls
- [fd](https://github.com/sharkdp/fd) - A simple, fast and
  user-friendly alternative to 'find'
- [zooxide](<>) - A cd command that learns - easily navigate directories
  from the command line
- [ripgrep](https://github.com/BurntSushi/ripgrep) - Ripgrep
  recursively searches directories for a regex pattern while
  respecting your gitignore
- [diff-so-fancy](<>) - Good-lookin' diffs. Actually... nah... The
  best-lookin' diffs. 🎉

### Relevant links

This repo is based on a clone of
[charnley/dotfiles](https://github.com/charnley/dotfiles)

Links for inspiration on future additions.

- <https://github.com/charnley/dotfiles>
- <https://github.com/brainfucksec/neovim-lua>
- <https://github.com/mathiasbynens/dotfiles>
