Dotfiles
========

My dotfiles. Entirely based on `this repo <https://github.com/charnley/dotfiles>`_ , huge shoutout


Setup
-----

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
