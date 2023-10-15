return {

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_istalled = {
        "csv",
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["ar"] = "@assignment.rhs",
            ["a="] = "@assignment.outer",
            ["al"] = "@assignment.lhs",
          },
        },
      },
    },
  },
}
