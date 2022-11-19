-- Importing plugins

--Auto run PackerCompile when plugins.lua is updated. Obtained from Packer git page.
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Set plugins
return require('packer').startup(function(use)

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'MattesGroeger/vim-bookmarks'  -- Easy bookmark shortcuts
    use 'ap/vim-css-color'  -- Preview CSS Colors
    use 'chaoren/vim-wordmotion' -- Better word motion
    use 'justinmk/vim-sneak'  -- Jump to char
    use {'junegunn/fzf', run= './install --all'}  -- Fuzzy find searching
    use 'junegunn/fzf.vim'  -- Fuzzy find searching
    use 'numToStr/Comment.nvim' -- For Commenting gcc & gc (Treesitter support)
    use 'gorkunov/smartpairs.vim' -- Extend visual selection of bracket

    -- Interface
    use 'nanotech/jellybeans.vim' -- colorscheme
    use 'folke/tokyonight.nvim'
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'folke/which-key.nvim'  -- I can't remember what <leader><char> does

    -- IDE like
    use "williamboman/nvim-lsp-installer"
    use 'kabouzeid/nvim-lspinstall'
    use 'windwp/nvim-autopairs'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/vim-vsnip'
    use 'neovim/nvim-lspconfig'
    use {'nvim-treesitter/nvim-treesitter', run= ':TSUpdate'}
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'rafamadriz/friendly-snippets'
    use 'ray-x/lsp_signature.nvim'  --  https://github.com/ray-x/lsp_signature.nvim
    use 'danymat/neogen'  -- generate docstrings (with treesitter)

    use 'airblade/vim-gitgutter' -- Git indication
    use 'APZelos/blamer.nvim' -- Git blame line

    ---Want to add--
    -- https://github.com/tpope/vim-fugitive
    -- https://github.com/junegunn/vim-peekaboo
    -- https://github.com/preservim/vimux
    -- https://github.com/nvim-lualine/lualine.nvim

end)
