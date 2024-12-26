return {
  {
    "garymjr/nvim-snippets",
    opts = { search_paths = { vim.fn.stdpath("config") .. "/home/magstr/.config/snippets" } },
  },

  -- {
  --   "hrsh7th/nvim-cmp",
  --   opts = function(_, opts)
  --     local cmp = require("cmp")
  --     opts.mapping = cmp.mapping({
  --       ["<C-j>"] = cmp.mapping.select_next_item(),
  --       ["<C-k>"] = cmp.mapping.select_prev_item(),
  --       ["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
  --       ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
  --       ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --     })
  --   end,
  -- },
}
