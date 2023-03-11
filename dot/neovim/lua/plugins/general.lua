-- Importing plugins

--- Setup lazy
return {

  'MattesGroeger/vim-bookmarks',   -- Easy bookmark shortcuts
  'ap/vim-css-color',              -- Preview CSS Colors
  'chaoren/vim-wordmotion',        -- Better word motion
  'justinmk/vim-sneak',            -- Jump to char. Issuses with leader key mapping
  {'junegunn/fzf', build= './install --all'},

  {'numToStr/Comment.nvim',config=true},     -- For Commenting gcc & gc (Treesitter support)
  'gorkunov/smartpairs.vim',   -- Extend visual selection of bracket

  --Interface
  { 'folke/tokyonight.nvim',         lazy = true }, -- colorscheme
  --'navarasu/onedark.nvim',

  'vim-airline/vim-airline',
  'vim-airline/vim-airline-themes',
  {'folke/which-key.nvim', config=true},   -- Show

  --IDE like
  {'windwp/nvim-autopairs',event="VeryLazy",config=true},--For completing the brackets/parentheis etc when typing

  -- Detect tabstop and shiftwidth automatically. Since i added this, i removed the functions doing this before.
  'tpope/vim-sleuth',

  {
      -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  {'ray-x/lsp_signature.nvim',
  opts = {

    handler_opts = {
        border = "single",   -- double, rounded, single, shadow, none
    },
    hint_prefix = "",  -- Panda for parameter

        },
        },

  {'danymat/neogen',config=true},             -- generate docstrings (with treesitter)

  'airblade/vim-gitgutter',     -- Git indication
  'APZelos/blamer.nvim',        -- Git blame line

  { 'nvim-lualine/lualine.nvim', dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true } },

    {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
}
  ---Want to add--
  -- https://github.com/glepnir/dashboard-nvim
  -- https://github.com/tpope/vim-fugitive -- This should replace git-gutter
  -- https://github.com/junegunn/vim-peekaboo
  -- https://github.com/preservim/vimux
  -- https://github.com/nvim-lualine/lualine.nvim
}

