# Note
# $@ - sources
# $< - target


# OS Detection
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
    OS = deb
endif
ifeq ($(UNAME_S),Darwin)
    OS = osx
endif
ifeq ($(findstring MINGW,$(UNAME_S)),MINGW)
    OS = Windows
endif
ifeq ($(findstring MSYS,$(UNAME_S)),MSYS)
    OS = Windows
endif
ifeq ($(findstring CYGWIN,$(UNAME_S)),CYGWIN)
    OS = Windows
endif

# Dummy targets
.PHONY: install install_remote clean dotfiles directories

# Default targets
all: dotfiles bin

# Tmux stuff i kindof deprecated. I want to just install it directly. Less trouble. 
# tmux_plugins:
# 	bash ./setup/tmux_plugins.sh
#
# tmux_tpm:

# Path Variables
BIN_PATH := ${HOME}/bin
OPT_PATH := ${HOME}/opt
CONFIG_PATH := ${HOME}/.config
NVIM_PATH := ${HOME}/.config/nvim
SSH_PATH := ${HOME}/.ssh
I3STATUS_PATH := ${HOME}/.config/i3status
I3_PATH := ${HOME}/.config/i3

# Directories
$(BIN_PATH):
	mkdir -p $@

$(OPT_PATH):
	mkdir -p $@

$(CONFIG_PATH):
	mkdir -p $@

$(NVIM_PATH):
	mkdir -p $@

$(SSH_PATH):
	mkdir -p $@

$(I3STATUS_PATH):
	mkdir -p $@

$(I3_PATH):
	mkdir -p $@

directories: $(BIN_PATH) $(OPT_PATH) $(CONFIG_PATH) $(I3STATUS_PATH) $(I3_PATH) $(NVIM_PATH)


${HOME}/bin/vim:
	ln -fs `pwd`/bin.$(OS)/vim ${HOME}/bin/vim

${HOME}/opt/neovim:
	bash setup.$(OS)/nvim_setup.sh
	NEOVIM_SETUP=1

<<<<<<< HEAD
# ${HOME}/opt/tmux-3.2a:
# 	#bash ./setup/tmux_compile.sh 1> /dev/null
# 	bash ./setup/tmux_tpm.sh
# 	bash ./setup/tmux_plugins.sh


=======
>>>>>>> main
${HOME}/.oh-my-zsh:
	bash ./setup/zsh_ohmyzsh.sh
	bash ./setup/zsh_ohmyzsh_plugins.sh

# TODO for bin folder, I should probably use CMakefile for rule generation
bin: ${HOME}/bin bindir_default bindir_$(OS) 

bindir_default:
	@bash ./setup/install_bin_directories.sh bin

bindir_deb:
	@bash ./setup/install_bin_directories.sh bin.deb

bindir_hpc:
	@bash ./setup/install_bin_directories.sh bin.hpc

# Dotfiles

dotfiles: directories dotfiles_defaults dotfiles_$(OS)

# This matches stem. If we have a ${HOME}/.bash_paths target feks then this will run
${HOME}/.%:
	# Move previous dotfiles to backup file
	test -f $@ && mv $@ $@.bk;:
	# Symbolic lincs to the dotfiles in the repo
	ln -s `pwd`/$< $@

dotfiles_defaults: ${HOME}/.bashrc ${HOME}/.bash_profile ${HOME}/.bash_prompt ${HOME}/.bash_aliases ${HOME}/.bash_paths ${HOME}/.condarc ${HOME}/.gitconfig ${HOME}/.tmux.conf ${HOME}/.tmux-osx ${HOME}/.tmux-linux ${HOME}/.config/nvim/init.lua ${HOME}/.config/nvim/lua ${HOME}/.config/neofetch ${HOME}/.hushlogin

${HOME}/.bash_aliases: ./dot/bash_aliases
${HOME}/.bash_paths: ./dot/bash_paths
${HOME}/.bash_profile: ./dot/bash_profile
${HOME}/.bash_prompt: ./dot/bash_prompt
${HOME}/.bashrc: ./dot/bashrc
${HOME}/.condarc: ./dot/condarc
${HOME}/.gitconfig: ./dot/gitconfig
${HOME}/.hushlogin: ./dot/hushlogin
${HOME}/.tmux-linux: ./dot/tmux.linux.conf
${HOME}/.tmux-osx: ./dot/tmux.osx.conf
${HOME}/.tmux.conf: ./dot/tmux.conf

${HOME}/.config/nvim/init.lua: ./dot/neovim/init.lua
${HOME}/.config/nvim/lua: ./dot/neovim/lua

dotfiles_deb: ${HOME}/.inputrc ${HOME}/.Xresources ${HOME}/.config/i3status/config ${HOME}/.config/i3/config

${HOME}/.inputrc: ./dot.deb/inputrc
${HOME}/.Xresources: ./dot.deb/Xresources
${HOME}/.config/i3status/config: ./dot.deb/i3status/config
${HOME}/.config/i3/config: ./dot.deb/i3/config

# fuzzzzzy find 
${HOME}/.fzf:
	bash ./setup/fzf_setup.sh

# Meta

install: dotfiles bin ${HOME}/opt/neovim install_binaries ${HOME}/.fzf install_${OS} ${HOME}/.oh-my-zsh install_apt

# zsh installation is troublesome and not needed on remotes anyway. So made new target for this
install_remote: dotfiles bin ${HOME}/opt/neovim install_binaries ${HOME}/.fzf install_${OS}
>>>>>>> main
# Guide for setting up zsh
# https://www.drewsilcock.co.uk/compiling-zsh

install_apt:
	sudo apt-get install $$(cat ./lists/packages.apt)

install_deb:
	@#

install_binaries:
	bash ./setup/get_binaries.sh

install_fonts:
	bash ./fonts/setup_mononoki.sh
