vim.api.nvim_set_keymap(
  "n",
  "<Leader>nd",
  ":lua require('neogen').generate()<CR>",
  { noremap = true, silent = true, desc = "Generate docstring" }
)
return {
  {
    "danymat/neogen",
    opts = { snippet_engine = "nvim" },
    ft = "python",
  }, -- generate docstrings (with treesitter)
}
