
.PHONY: vim_update

all: vim_update install

vim_update:
	vim +PlugClean +PlugInstall +PlugUpdate +qall

~/bin/vim:
	bash setup/nvim_setup.sh

install: ~/bin/vim vim_update
	bash --login

symlink:
	# TODO needs to be OSX specific

symlink_clean:
	# TODO if there and is symlink, rm

packages.linux:
	# server related

packages.linux.x:
	echo # x related

packages.mac:
	# brew packages

bin_folder:
	# TODO Needs to find a better and osx specific way
	mkdir -p ~/bin
	# Don't overwrite anything
	for x in bin/*; do \
		if [ ! -f ~/$$x  ]; then\
			ln -s `pwd`/$$x ~/$$x;\
		fi; \
	done

