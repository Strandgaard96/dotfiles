return {
  "m4xshen/hardtime.nvim", -- Help learn proper nvim workflow
  enable = false,
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
}
