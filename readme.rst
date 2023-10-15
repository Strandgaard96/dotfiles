Dotfiles
========

My dotfiles.

|desktop|

.. |desktop| image:: https://raw.githubusercontent.com/Strandgaard96/dotfiles/main/dot/desktop.png

Setup
-----

A makefile is used to create all relevant symlinks and directories. Also downloads various tools. 

.. code-block:: bash

    make install_apt # only for systems you have sudo. Installs all packages via apt-get. 

    make install # Set everything up on local machine with sudo.

    make install_remote # Install without certain features. To be used on remote to prevent compiler and version issues that can not be fixed without sudo.


.. Testing
.. -----
.. I have made a dockerfile that works for testing install_remote. Tmux and zsh is still trouble sometimes but the image can still be used to test the basic dotfiles and neovim.
.. docker-test.sh creates a docker image and then a container based on this image.
.. To test, ensure docker is installed and that the docker deamon is dunning. Then run the following in bash
..
.. .. code-block:: bash
..
..     # Setup docker env
..     ./docker-test.sh

My tools
---------
Useful tools for linux commandline that I use.

- bat_ - A cat(1) clone with wings
- exa_ - A Modern replacement for ls
- fd_ - A simple, fast and user-friendly alternative to 'find'
- zooxide_ - A cd command that learns - easily navigate directories from the command line
- ripgrep_ - Ripgrep recursively searches directories for a regex pattern while respecting your gitignore


.. _bat: https://github.com/sharkdp/bat
.. _exa: https://github.com/ogham/exa
.. _fd : https://github.com/sharkdp/fd
.. _zoxide: https://github.com/ajeetdsouza/zoxide
.. _ripgrep: https://github.com/BurntSushi/ripgrep

Relevant links
_________________

This repo is based on a clone of `charnley/dotfiles <https://github.com/charnley/dotfiles>`_ 

Links for inspiration on future additions. 

- `<https://github.com/charnley/dotfiles>`_
- `<https://github.com/brainfucksec/neovim-lua>`_
- `<https://github.com/mathiasbynens/dotfiles>`_
