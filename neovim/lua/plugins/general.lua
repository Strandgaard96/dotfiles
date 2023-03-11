-- Importing plugins

--- Setup lazy
return {

	"MattesGroeger/vim-bookmarks", -- Easy bookmark shortcuts
	{ "norcalli/nvim-colorizer.lua", config = true },
	--'chaoren/vim-wordmotion',      -- Better word motion

	{
		"m4xshen/hardtime.nvim", -- Help learn proper nvim workflow
		opts = {
			restricted_keys = {
				["h"] = { "v" },
				["j"] = { "v" },
				["k"] = { "v" },
				["l"] = { "v" },
				["-"] = { "n", "v" },
				["+"] = { "n", "v" },
				["gj"] = { "n", "v" },
				["gk"] = { "n", "v" },
				["<CR>"] = { "n", "v" },
				["<C-M>"] = { "n", "v" },
				["<C-N>"] = { "n", "v" },
				["<C-P>"] = { "n", "v" },
			},
		},
	},

	{
		"ggandor/leap.nvim",
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
			{ "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
			{ "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
		},
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
			leap.add_default_mappings(true)
			vim.keymap.del({ "x", "o" }, "x")
			vim.keymap.del({ "x", "o" }, "X")
		end,
	},

	{ "junegunn/fzf", build = "./install --all" },
	"LunarVim/bigfile.nvim", -- disables unnecesary stuff for big files

	{ "numToStr/Comment.nvim", config = true }, -- For Commenting gcc & gc (Treesitter support)
	"gorkunov/smartpairs.vim", -- Extend visual selection of bracket

	--Interface
	{ "folke/tokyonight.nvim", lazy = true }, -- colorscheme
	{ "catppuccin/nvim", name = "catppuccin", lazy = true },
	{ "rose-pine/neovim", name = "rose-pine", lazy = false },
	--'navarasu/onedark.nvim',<

	{ "folke/which-key.nvim", config = true }, -- Show

	-- Lua
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was openeddash
		opts = {
			-- add any custom options here
		},
	},

	"mbbill/undotree",

	{ "ojroques/nvim-osc52", config = true },

	{ "windwp/nvim-autopairs", event = "VeryLazy", config = true }, --For auto creating closing bracket

	-- Detect tabstop and shiftwidth automatically. Since i added this, i removed the functions doing this before.
	"tpope/vim-sleuth",

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},

	{
		"ray-x/lsp_signature.nvim",
		opts = {
			handler_opts = {
				border = "single", -- double, rounded, single, shadow, none
			},
			hint_prefix = "", -- Panda for parameter
		},
	},

	{ "danymat/neogen", opts = { snippet_engine = "luasnip" } }, -- generate docstrings (with treesitter)

	-- better diagnostics list and others
	-- TODO
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
			{ "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").previous({ skip_groups = true, jump = true })
					else
						vim.cmd.cprev()
					end
				end,
				desc = "Previous trouble/quickfix item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						vim.cmd.cnext()
					end
				end,
				desc = "Next trouble/quickfix item",
			},
		},
	},

	-- todo comments
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
	},

  { 'junegunn/fzf',          build = './install --all' },
  "LunarVim/bigfile.nvim",               -- disables unnecesary stuff for big files

  { 'numToStr/Comment.nvim', config = true }, -- For Commenting gcc & gc (Treesitter support)
  'gorkunov/smartpairs.vim',             -- Extend visual selection of bracket

  --Interface
  { 'folke/tokyonight.nvim', lazy = true },-- colorscheme
  { "catppuccin/nvim", name = "catppuccin", lazy=true},
  --'navarasu/onedark.nvim',<

  { 'folke/which-key.nvim',  config = true }, -- Show


  { "folke/trouble.nvim",    dependencies = { "kyazdani42/nvim-web-devicons", lazy = true }, config = true },

  --IDE like
  { 'windwp/nvim-autopairs', event = "VeryLazy", config = true }, --For auto creating closing bracket

  -- Detect tabstop and shiftwidth automatically. Since i added this, i removed the functions doing this before.
  'tpope/vim-sleuth',

  {
    -- Add indentation guides evenairline on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  {
    'ray-x/lsp_signature.nvim',
    opts = {
      handler_opts = {
        border = "single", -- double, rounded, single, shadow, none
      },
      hint_prefix = "",    -- Panda for parameter
    },
  },

  { 'danymat/neogen',            config = true }, -- generate docstrings (with treesitter)

  'airblade/vim-gitgutter',       -- Git indication
  'APZelos/blamer.nvim',          -- Git blame line

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
