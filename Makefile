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

neovim:
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


# This symlinks the dotfiles with stow
dotfiles:
	stow -v bash git zsh alacritty nvim lazygit ripgrep div bat tmux i3 fzf

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

install: dotfiles neovim ${HOME}/.fzf ${HOME}/.oh-my-zsh install_apt fonts

# zsh installation is troublesome and not needed on remotes anyway. So made new target for this
install_remote: dotfiles ${HOME}/opt/neovim binaries ${HOME}/.fzf
# Guide for setting up zsh
# https://www.drewsilcock.co.uk/compiling-zsh

install_pi: dotfiles ${HOME}/.fzf install_apt_pi fonts

install_debug: dotfiles
