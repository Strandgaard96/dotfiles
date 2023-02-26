Dotfiles
========

My dotfiles. Entirely based on a clone of this repo `charnley/dotfiles <https://github.com/charnley/dotfiles>`_ 
with additional personal modifications and additions.

Setup
-----

A makefile is used to create all relevant symlinks and directories. Also downloads various tools. 

.. code-block:: bash

    # fresh installation on new system

    make install_apt # only for systems you have sudo
    make install # Compile and download dependencies (such as tmux and neovim)

    # Install without tmux on remote as this often gives compiler issues
    make install_remote # Compile and download dependencies (such as zsh and neovim)


.. code-block:: bash

    # Check for updated dotfiles and check all plugins (e.g. VIM plugin update)
    git pull # Get latest changed
    make # Check all symlinks and plugins

Testing
-----
I have made a dockerfile that works for testing install_remote. Tmux and zsh is still trouble sometimes but the image can still be used to test the basic dotfiles and neovim.
docker-test.sh creates a docker image and then a container based on this image.
To test, ensure docker is installed and that the docker deamon is dunning. Then run the following in bash

.. code-block:: bash

    # Setup docker env
    ./docker-test.sh

My tools
---------
Useful tools for linux commandline

- bat_ - A cat(1) clone with wings
- exa_ - A Modern replacement for ls
- fd_ - A simple, fast and user-friendly alternative to 'find'
- autojump_ - A cd command that learns - easily navigate directories from the command line


.. _bat: https://github.com/sharkdp/bat
.. _exa: https://github.com/ogham/exa
.. _fd : https://github.com/sharkdp/fd
.. _autojump: https://github.com/wting/autojump

Relevant links
_________________
Links for inspiration on future additions. 

- `<https://github.com/charnley/dotfiles>`_
- `<https://github.com/brainfucksec/neovim-lua>`_
- `<https://github.com/mathiasbynens/dotfiles>`_

Some script for downloading binaries.
- https://gist.github.com/sjparkinson/327dc78c60ab81a06c946630b4288910


