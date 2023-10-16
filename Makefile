# Note
# $@ - sources
# $< - target

# Check operating system
ifeq '$(findstring ;,$(PATH))' ';' # Windows
	detected_OS := Windows
else
	detected_OS := $(shell uname 2>/dev/null || echo Unknown)
	detected_OS := $(patsubst CYGWIN%,Cygwin,$(detected_OS))
	detected_OS := $(patsubst MSYS%,MSYS,$(detected_OS))
	detected_OS := $(patsubst MINGW%,MSYS,$(detected_OS))
endif

ifeq ($(detected_OS),Darwin) # Mac OS X
	OS = osx
endif

ifeq ($(detected_OS),Linux) # Linux
	OS = deb
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
# 	bash ./setup/tmux_tpm.sh

# Directories

${HOME}/bin:
	mkdir -p $@

${HOME}/opt:
	mkdir -p $@

${HOME}/.config:
	mkdir -p $@

${HOME}/.config/nvim:
	mkdir -p $@

${HOME}/.ssh:
	mkdir -p $@

${HOME}/.config/i3status:
	mkdir -p $@

${HOME}/.config/i3:
	mkdir -p $@

directories: ${HOME}/bin ${HOME}/opt ${HOME}/.config ${HOME}/.config/i3status ${HOME}/.config/i3 ${HOME}/.config/nvim

# Executables

${HOME}/bin/vim:
	ln -fs `pwd`/bin.$(OS)/vim ${HOME}/bin/vim

${HOME}/opt/neovim:
	bash setup.$(OS)/nvim_setup.sh
	NEOVIM_SETUP=1

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
