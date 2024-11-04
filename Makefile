# Note
# $@ - targets
# $< - sources

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
	bash -c ./setup/backup_existing_dots.sh
	stow -v git alacritty nvim lazygit ripgrep div bat tmux i3 bash bin

# fuzzzzzy find 
${HOME}/.fzf:
	bash ./setup/fzf_setup.sh
	bash ./setup/setup_zoxide.sh

install_apt_pi:
	apt-get install $$(cat ./packages/packages_pi.apt) -y

install_apt:
	apt-get install $$(cat ./packages/packages.apt) -y

binaries:
	bash ./setup/get_binaries.sh

fonts:
	bash ./fonts/setup_mononoki.sh

#### The major targets that install for different systems ####

install: install_apt neovim ${HOME}/.fzf ${HOME}/.oh-my-zsh fonts dotfiles

install_remote: neovim binaries ${HOME}/.fzf dotfiles
# Guide for setting up zsh
# https://www.drewsilcock.co.uk/compiling-zsh

install_pi: install_apt_pi ${HOME}/.fzf fonts dotfiles

