# Note
# $@ - sources
# $< - target


# Dummy targets
.PHONY: install install_remote clean dotfiles directories


# Default targets
all: dotfiles

neovim:
	bash ./setup/nvim_setup.sh
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


# This symlinks the dotfiles with stow
dotfiles:
	bash ./backup_existing_dots.sh
	stow -v git zsh alacritty nvim lazygit ripgrep div bat tmux i3 fzf bin

# fuzzzzzy find 
${HOME}/.fzf:
	bash ./setup/fzf_setup.sh

install_apt_pi:
	apt-get install $$(cat ./packages/packages_pi.apt) -y

install_apt:
	apt-get install $$(cat ./packages/packages.apt) -y

binaries:
	bash ./setup/get_binaries.sh

fonts:
	bash ./fonts/setup_mononoki.sh


#### The major targets that install for different systems ####

install: dotfiles neovim ${HOME}/.fzf ${HOME}/.oh-my-zsh install_apt fonts

install_remote: dotfiles neovim binaries ${HOME}/.fzf
	#
# Guide for setting up zsh
# https://www.drewsilcock.co.uk/compiling-zsh

install_pi: dotfiles ${HOME}/.fzf install_apt_pi fonts

install_debug: dotfiles
