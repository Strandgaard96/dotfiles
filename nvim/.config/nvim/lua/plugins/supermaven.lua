return {
  "saghen/blink.cmp",
  -- dependencies = {
  --   {
  --     "supermaven-inc/supermaven-nvim",
  --     opts = {
  --       disable_inline_completion = false, -- disables inline completion for use with cmp
  --       disable_keymaps = false, -- disables built in keymaps for more manual control
  --     },
  --   },
  --   {
  --     "huijiro/blink-cmp-supermaven",
  --   },
  -- },
  opts = {
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      -- providers = {
      --   supermaven = {
      --     name = "supermaven",
      --     module = "blink-cmp-supermaven",
      --     async = true,
      --   },
      -- },
    },
    keymap = {
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
    },
  },
}
