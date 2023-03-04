-- Importing plugins

--- Setup lazy
return {
  'MattesGroeger/vim-bookmarks',   -- Easy bookmark shortcuts
  'ap/vim-css-color',              -- Preview CSS Colors
  'chaoren/vim-wordmotion',        -- Better word motion
  'justinmk/vim-sneak',            -- Jump to char. Issuses with leader key mapping

  --{'junegunn/fzf', build= './install --all'},  -- Fuzzy find searching
  --'junegunn/fzf.vim',  -- Fuzzy find searching
  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },


  'numToStr/Comment.nvim',     -- For Commenting gcc & gc (Treesitter support)
  'gorkunov/smartpairs.vim',   -- Extend visual selection of bracket

  --Interface
  'nanotech/jellybeans.vim',                -- colorscheme
  { 'folke/tokyonight.nvim',         lazy = false }, -- colorscheme
  'navarasu/onedark.nvim',

  'vim-airline/vim-airline',
  'vim-airline/vim-airline-themes',
  'folke/which-key.nvim',   -- I can't remember what <leader><char> does

  --IDE like
  'windwp/nvim-autopairs',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',
  {
      -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },
  -- Detect tabstop and shiftwidth automatically. Since i added this, i removed the functions doing this before.
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
      -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },
  'JoosepAlviste/nvim-ts-context-commentstring',

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

  'rafamadriz/friendly-snippets',
  'ray-x/lsp_signature.nvim',   --  https://github.com/ray-x/lsp_signature.nvim
  'danymat/neogen',             -- generate docstrings (with treesitter)

  'airblade/vim-gitgutter',     -- Git indication
  'APZelos/blamer.nvim',        -- Git blame line

  { 'nvim-lualine/lualine.nvim', dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true } },

  -- dashboard
  {
    "goolord/alpha-nvim",
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      -- ASCII TEXT: https://github.com/glepnir/dashboard-nvim/wiki/Ascii-Header-Text
      local logo = [[
              ▀████▀▄▄              ▄█
                █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█
        ▄        █          ▀▀▀▀▄  ▄▀
       ▄▀ ▀▄      ▀▄              ▀▄▀
      ▄▀    █     █▀   ▄█▀▄      ▄█
      ▀▄     ▀▄  █     ▀██▀     ██▄█
       ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █
        █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀
       █   █  █      ▄▄           ▄▀
      ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("l", "L " .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },




  ---Want to add--
  -- https://github.com/glepnir/dashboard-nvim
  -- https://github.com/tpope/vim-fugitive -- This should replace git-gutter
  -- https://github.com/junegunn/vim-peekaboo
  -- https://github.com/preservim/vimux
  -- https://github.com/nvim-lualine/lualine.nvim
}

