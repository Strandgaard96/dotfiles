-- Importing plugins

--- Setup lazy
return {
    'MattesGroeger/vim-bookmarks',  -- Easy bookmark shortcuts
    'ap/vim-css-color',  -- Preview CSS Colors
    'chaoren/vim-wordmotion', -- Better word motion
    'justinmk/vim-sneak',  -- Jump to char. Issuses with leader key mapping
    {'junegunn/fzf', build= './install --all'},  -- Fuzzy find searching
    'junegunn/fzf.vim',  -- Fuzzy find searching
    'numToStr/Comment.nvim', -- For Commenting gcc & gc (Treesitter support)
    'gorkunov/smartpairs.vim', -- Extend visual selection of bracket

    --Interface
    'nanotech/jellybeans.vim', -- colorscheme
    'folke/tokyonight.nvim', -- colorscheme
    'navarasu/onedark.nvim',

    'vim-airline/vim-airline',
    'vim-airline/vim-airline-themes',
    'folke/which-key.nvim',  -- I can't remember what <leader><char> does

    --IDE like
    "williamboman/nvim-lsp-installer",
    'kabouzeid/nvim-lspinstall',
    'windwp/nvim-autopairs',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/nvim-cmp',
    'hrsh7th/vim-vsnip',
    'neovim/nvim-lspconfig',

    {'nvim-treesitter/nvim-treesitter', build= ':TSUpdate'},
    'nvim-treesitter/nvim-treesitter-textobjects',
    'JoosepAlviste/nvim-ts-context-commentstring',

    'rafamadriz/friendly-snippets',
    'ray-x/lsp_signature.nvim',  --  https://github.com/ray-x/lsp_signature.nvim
    'danymat/neogen',  -- generate docstrings (with treesitter)

    'airblade/vim-gitgutter', -- Git indication
    'APZelos/blamer.nvim', -- Git blame line

    {'nvim-lualine/lualine.nvim',dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true }},

    ---Want to add--
    -- https://github.com/tpope/vim-fugitive -- This should replace git-gutter
    -- https://github.com/junegunn/vim-peekaboo
    -- https://github.com/preservim/vimux
    -- https://github.com/nvim-lualine/lualine.nvim
}