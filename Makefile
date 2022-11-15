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
.PHONY: vim_plugins install clean dotfiles directories

# Default targets
all: dotfiles bin vim_plugins tmux_plugins

vim_plugins:
	NEOVIM_SETUP=1 ${HOME}/bin/vim --headless -c 'autocmd User PackerComplete quitall' -c 'silent PackerSync'

tmux_plugins:
	bash ./setup/tmux_plugins.sh

tmux_tpm:
	bash ./setup/tmux_tpm.sh

# Directories

${HOME}/bin:
	mkdir -p $@

${HOME}/opt:
	mkdir -p $@

${HOME}/.config:
	mkdir -p $@

${HOME}/.config/nvim: ${HOME}/.config
	mkdir -p $@

${HOME}/.ssh:
	mkdir -p $@

directories: ${HOME}/bin ${HOME}/opt ${HOME}/.config/nvim

# Executables

${HOME}/bin/vim:
	ln -fs `pwd`/bin.$(OS)/vim ${HOME}/bin/vim

${HOME}/opt/neovim:
	bash setup.$(OS)/nvim_setup.sh
	bash setup/neovim_packer.sh
	NEOVIM_SETUP=1 ${HOME}/bin/vim --headless -c 'autocmd User PackerComplete quitall' -c 'silent PackerSync'

${HOME}/opt/tmux-3.2a:
	bash ./setup/tmux_compile.sh 1> /dev/null
	bash ./setup/tmux_tpm.sh
	bash ./setup/tmux_plugins.sh

${HOME}/bin/zsh:
	bash ./setup/zsh_install.sh

${HOME}/.oh-my-zsh:
	bash ./setup/zsh_ohmyzsh.sh
	bash ./setup/zsh_ohmyzsh_plugins.sh

# TODO for bin folder, I should probably use CMakefile for rule generation
bin: ${HOME}/bin bindir_default bindir_$(OS) bindir_dev

bindir_default:
	@bash ./setup/install_bin_directories.sh bin

bindir_dev:
	@bash ./setup/install_bin_directories.sh bin.dev

bindir_deb:
	@bash ./setup/install_bin_directories.sh bin.deb

bindir_hpc:
	@bash ./setup/install_bin_directories.sh bin.hpc

# Dotfiles

dotfiles: directories dotfiles_defaults dotfiles_$(OS)

# wtf does this do?
${HOME}/.%:
	test -f $@ && mv $@ $@.bk;:
	ln -s `pwd`/$< $@

dotfiles_defaults: ${HOME}/.bashrc ${HOME}/.bash_profile ${HOME}/.bash_aliases ${HOME}/.bash_paths ${HOME}/.condarc ${HOME}/.gitconfig ${HOME}/.tmux.conf ${HOME}/.tmux-osx ${HOME}/.tmux-linux ${HOME}/.config/nvim/init.lua ${HOME}/.config/nvim/lua ${HOME}/.vsnip ${HOME}/.zshrc ${HOME}/.config/alacritty ${HOME}/.config/neofetch ${HOME}/.hushlogin

${HOME}/.bash_aliases: ./dot/bash_aliases
${HOME}/.bash_paths: ./dot/bash_paths
${HOME}/.bash_profile: ./dot/bash_profile
${HOME}/.bashrc: ./dot/bashrc
${HOME}/.condarc: ./dot/condarc
${HOME}/.gitconfig: ./dot/gitconfig
${HOME}/.hushlogin: ./dot/hushlogin
${HOME}/.tmux-linux: ./dot/tmux.linux.conf
${HOME}/.tmux-osx: ./dot/tmux.osx.conf
${HOME}/.tmux.conf: ./dot/tmux.conf
${HOME}/.zshrc: ./dot/zshrc

${HOME}/.config/neofetch: ./dot/neofetch
${HOME}/.config/alacritty: ./dot/alacritty
${HOME}/.config/nvim/init.lua: ./dot/neovim/init.lua
${HOME}/.config/nvim/lua: ./dot/neovim/lua
${HOME}/.vsnip: ./dot/neovim/snippets

dotfiles_deb: ${HOME}/.inputrc

${HOME}/.inputrc: ./dot.deb/inputrc

#
${HOME}/.fzf:
	bash ./setup/fzf_setup.sh

# Meta

install: dotfiles bin ${HOME}/opt/neovim ${HOME}/.fzf install_${OS} ${HOME}/opt/tmux-3.2a ${HOME}/.oh-my-zsh ${HOME}/.oh-my-zsh

# tmux installation is troublesome and not needed on remotes anyway. So made new target for this
install_remote: dotfiles bin ${HOME}/opt/neovim ${HOME}/.fzf install_${OS} ${HOME}/.oh-my-zsh ${HOME}/.oh-my-zsh


install_deb:
	@#

install_apt:
	sudo apt-get install $$(cat ./lists/packages.apt)

install_fonts:
	bash ./fonts/setup_mononoki.sh

symlink_clean:
	# TODO if there and is symlink, rm. For example, if symlink points to dotfiles, but is deprecated

clean: symlink_clean
