# This is where the neovim magic happens

# tl;dr changes to key bindings

## Basic extension of vim

| key                   | desc                               |
| --------------------- | ---------------------------------- |
| **Git stuff**         |                                    |
| ,gb                   | Toggle git blame                   |
| ,gh                   | Git show changed                   |
| ,gn                   | Git find next hunk                 |
| ,gp                   | Git find previous hunk             |
| ,gu                   | Git undo hunk                      |
| **cut/paste**         |                                    |
| ,d                    | Cut line(s) (old `dd`)             |
| ,p                    | Toggle pastemode                   |
| ,y                    | Copy yank to clipboard (via OSC52) |
| **Custom formatting** |                                    |
| ,nf                   | Run format (`~/bin/format file`)   |
| ,nw                   | Remove all trailing whitespaces    |
| **Buffer stuff**      |                                    |
| Shift y               | Copy to ~/.vbuf                    |
| Tab                   | Goto next buffer                   |
| Tab+Shift             | Goto previous buffer               |
| bd                    | Delete current buffer              |
| bn                    | Goto next buffer                   |
| bp                    | Goto previous buffer               |

## IDE Like behavior

| key | desc                |
| --- | ------------------- |
| ,ld | lsp goto definition |
| ,ln | lsp rename variable |

TODO note on auto-complete and tab

## Write mode (Spelling and gramma)

| key | desc                      |
| --- | ------------------------- |
| ,z  | activate spelling mode    |
| zg  | Add word to spelling dict |

## Telescope

## Standard VIM

### Standard maps i learned

| key    | desc                                           |
| ------ | ---------------------------------------------- |
| %      | switch between matching brackets where you are |
| gi     | goto last insertion                            |
| gv     | goto last visual selection                     |
| dsfdsf | dsf d                                          |

:

### Live Replacement in NVIM 0.6

Changes "from" to "to" in this case. The g flag means global replace, so its does it for all occurences in the file.

:%s/from/to/g

## Very useful

Yank inside brackets any brackets and send to local clipboard when using tmux/vim via ssh

    # y(ank)
    # i(nside)
    # v (closets bracket)
    # ,y (leader y, send yank to ~/bin/yank)
    yiv,y

where osc52 (~/bin/yank) makes the local terminal put content in local clipboard.

## TODO

- TODO https://github.com/elianiva/dotfiles/tree/master/nvim/.config/nvim
- TODO https://github.com/junegunn/vim-easy-align " Easy align CSV data
- TODO Write mode rhysd/vim-grammarous
- TODO https://github.com/folke/zen-mode.nvim
- TODO https://github.com/mizlan/dotfiles/blob/master/.config/nvim/init.lua
- TODO https://github.com/romainl/vim-cool

## Lua stuff

This is from the lazy docs. You dunt have to set require(plugin).setup if you set opts :D

More docs: https://www.lazyvim.org/configuration/examples

```lua
    {
    "nvim-neorg/neorg",
    -- lazy-load on filetype
    ft = "norg",
    -- custom config that will be executed when loading the plugin
    config = function()
      require("neorg").setup()
    end,
  },

  -- the above could also be written as:
  {
    "nvim-neorg/neorg",
    ft = "norg",
    config = true, -- run require("neorg").setup()
  },

  -- or set custom options:
  {
    "nvim-neorg/neorg",
    ft = "norg",
    opts = { foo = "bar" }, -- run require("neorg").setup({foo = "bar"})
  },
```

## How to help yourself

    :h index # See all the standard keymaps and their explanation
    :verbose map "key" # See explanation for a map and where it was set
    :h keycodes # See the keycode notation labels!
