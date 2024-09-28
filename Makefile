# Note
# $@ - sources
# $< - target


# Dummy targets
.PHONY: install install_remote clean dotfiles directories


# Default targets
all: dotfiles

neovim:
	bash ./setup/nvim_setup.sh

${HOME}/.oh-my-zsh:
	bash ./setup/zsh_ohmyzsh.sh
	bash ./setup/zsh_ohmyzsh_plugins.sh


# This symlinks the dotfiles with stow
dotfiles:
	bash -c ./backup_existing_dots.sh
	stow -v git alacritty nvim lazygit ripgrep div bat tmux i3 fzf bin

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

install: neovim ${HOME}/.fzf ${HOME}/.oh-my-zsh install_apt fonts dotfiles

install_remote: neovim binaries ${HOME}/.fzf dofiles 
# Guide for setting up zsh
# https://www.drewsilcock.co.uk/compiling-zsh

install_pi: ${HOME}/.fzf install_apt_pi fonts dotfiles

install_debug: dotfiles
