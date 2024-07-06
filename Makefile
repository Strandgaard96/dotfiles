# Note
# $@ - sources
# $< - target


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

$(SSH_PATH):
	mkdir -p $@

$(I3STATUS_PATH):
	mkdir -p $@

$(I3_PATH):
	mkdir -p $@

directories: $(BIN_PATH) $(OPT_PATH) $(CONFIG_PATH) $(I3STATUS_PATH) $(I3_PATH)
	
bin: ${HOME}/bin bindir_default

bindir_default:
	@bash ./setup/install_bin_directories.sh bin

bindir_deb:
	@bash ./setup/install_bin_directories.sh bin.deb

bindir_hpc:
	@bash ./setup/install_bin_directories.sh bin.hpc


${HOME}/bin/vim:
	ln -fs `pwd`/bin/vim ${HOME}/bin/vim

${HOME}/opt/neovim:
	bash setup/nvim_setup.sh
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

# Dotfiles

dotfiles: directories dotfiles_defaults

# This matches stem. If we have a ${HOME}/.bash_paths target feks then this will run
${HOME}/.%:
	# Move previous dotfiles to backup file
	test -f $@ && mv $@ $@.bk;:
	# Symbolic lincs to the dotfiles in the repo
	ln -sf `pwd`/$< $@

dotfiles_defaults: ${HOME}/.bashrc ${HOME}/.bash_profile ${HOME}/.bash_prompt ${HOME}/.bash_aliases ${HOME}/.bash_paths ${HOME}/.condarc ${HOME}/.gitconfig ${HOME}/.tmux.conf ${HOME}/.hushlogin ${HOME}/.config/nvim/ ${HOME}/.inputrc ${HOME}/.Xresources ${HOME}/.config/i3status/config ${HOME}/.config/i3/config

${HOME}/.bash_aliases: ./dot/bash_aliases
${HOME}/.bash_paths: ./dot/bash_paths
${HOME}/.bash_profile: ./dot/bash_profile
${HOME}/.bash_prompt: ./dot/bash_prompt
${HOME}/.bashrc: ./dot/bashrc
${HOME}/.condarc: ./dot/condarc
${HOME}/.gitconfig: ./dot/gitconfig
${HOME}/.hushlogin: ./dot/hushlogin
${HOME}/.tmux.conf: ./dot/tmux.conf

# This ensures that lazyvim gets copied over. Nice
${HOME}/.config/nvim: ./dot/nvim

${HOME}/.inputrc: ./dot.deb/inputrc
${HOME}/.Xresources: ./dot.deb/Xresources
${HOME}/.config/i3status/config: ./dot.deb/i3status/config
${HOME}/.config/i3/config: ./dot.deb/i3/config

# fuzzzzzy find 
${HOME}/.fzf:
	bash ./setup/fzf_setup.sh

install_apt_pi:
	sudo apt-get install $$(cat ./dot/packages_pi.apt)

install_apt:
	sudo apt-get install $$(cat ./dot/packages.apt)

binaries:
	bash ./setup/get_binaries.sh

fonts:
	bash ./fonts/setup_mononoki.sh


#The major targets that install for different systems. 

install: dotfiles bin ${HOME}/opt/neovim ${HOME}/.fzf ${HOME}/.oh-my-zsh install_apt fonts

# zsh installation is troublesome and not needed on remotes anyway. So made new target for this
install_remote: dotfiles bin ${HOME}/opt/neovim binaries ${HOME}/.fzf
# Guide for setting up zsh
# https://www.drewsilcock.co.uk/compiling-zsh

install_pi: dotfiles bin ${HOME}/.fzf install_apt_pi fonts

install_debug: dotfiles bin
