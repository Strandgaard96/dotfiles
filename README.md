# Dotfiles

My dotfiles for Linux based systems.

![desktop](https://raw.githubusercontent.com/Strandgaard96/dotfiles/main/desktop.png)

## Setup

I use stow and a makefile to create all relevant symlinks and directories as well as installing various commandline tools and neovim. Use at own discretion.

There are multiple build targets that can be used depending on purpose. If you are running on a system without sudo, do install_remote

```bash
sudo make install # Set everything up on local machine with sudo.

make install_remote # Install without certain features. To be used on remote to prevent compiler and version issues that can not be fixed without sudo.
```

## My tools

Amazing linux tools that I use in the dotfiles.

- [bat](https://github.com/sharkdp/bat) - A cat(1) clone with wings
- [exa](https://github.com/ogham/exa) - A Modern replacement for ls
- [fd](https://github.com/sharkdp/fd) - A simple, fast and
  user-friendly alternative to 'find'
  j [zooxide](<>) - A cd command that learns - easily navigate directories
  from the command line
- [ripgrep](https://github.com/BurntSushi/ripgrep) - Ripgrep
  recursively searches directories for a regex pattern while
  respecting your gitignore
- [diff-so-fancy](<>) - Good-lookin' diffs. Actually... nah... The
  best-lookin' diffs. 🎉

### Relevant links

This repo is based on a clone of
[charnley/dotfiles](https://github.com/charnley/dotfiles)

Links for inspiration on future additions:

- <https://github.com/charnley/dotfiles>
- <https://github.com/brainfucksec/neovim-lua>
- <https://github.com/mathiasbynens/dotfiles>
