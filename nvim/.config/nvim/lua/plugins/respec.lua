return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "night" },
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        search = {
          enabled = false,
        },
      },
    },
  },

  {
    "Exafunction/codeium.nvim",
    event = "InsertEnter",
    config = function()
      -- your Codeium config goes here
      vim.g.codeium_filetype = {
        -- disable for tex
        tex = false,
        -- any other modifications
      }
    end,
  },
}
