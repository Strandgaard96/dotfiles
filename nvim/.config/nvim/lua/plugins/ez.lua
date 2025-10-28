return {

  -- colorscheme
  { "EdenEast/nightfox.nvim" }, -- lazy
  {
    "craftzdog/solarized-osaka.nvim",
    -- lazy = false,
    -- priority = 1000,
    -- opts = {},
  },
  { "kepano/flexoki-neovim" }, -- lazy

  "benomahony/uv.nvim",
  opts = {
    picker_integration = true,
  },
  { "nvim-focus/focus.nvim", version = "*", config = true },

  { "karb94/neoscroll.nvim", opts = {} },

  {

    "rachartier/tiny-inline-diagnostic.nvim",

    event = "VeryLazy", -- Or `LspAttach`

    priority = 1000, -- needs to be loaded in first

    config = function()
      require("tiny-inline-diagnostic").setup({
        options = {
          add_messages = true,
          multilines = {
            enabled = true,
            always_show = true,
          },
        },
      })

      vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
  },

  "sphamba/smear-cursor.nvim",
  opts = { -- Default  Range
    stiffness = 0.8, -- 0.6      [0, 1]
    trailing_stiffness = 0.5, -- 0.4      [0, 1]
    stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
    trailing_stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
    distance_stop_animating = 0.5, -- 0.1      > 0
  },

  "ojroques/nvim-osc52",
  config = function()
    require("osc52").setup({
      max_length = 0, -- Maximum length of selection (0 for no limit)
      silent = false, -- Disable message on successful copy
      trim = false, -- Trim surrounding whitespaces before copy
    })
    local function copy()
      if (vim.v.event.operator == "y" or vim.v.event.operator == "d") and vim.v.event.regname == "" then
        require("osc52").copy_register("")
      end
    end

    vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
  end,

  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {
      -- your options here
    },
  },
}
