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
	echo "Backup dots"
	bash -c ./setup/backup_existing_dots.sh
	echo "Running simulation of stowing the dotfiles"
	stow -v -t ${HOME} bin
	stow -v -t ${HOME} -n git alacritty nvim lazygit ripgrep div bat tmux i3 bash

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

install: dotfiles install_apt neovim ${HOME}/.fzf ${HOME}/.oh-my-zsh fonts

install_remote: dotfiles neovim binaries ${HOME}/.fzf

install_pi: dotfiles install_apt_pi ${HOME}/.fzf fonts binaries

