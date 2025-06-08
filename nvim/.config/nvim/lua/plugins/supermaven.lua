return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "Kaiser-Yang/blink-cmp-avante",
      -- ... Other dependencies
    },
    opts = {
      sources = {
        -- Add 'avante' to the list
        default = { "avante", "lsp", "path", "snippets", "buffer" },

        providers = {
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            opts = {
              -- options for blink-cmp-avante
            },
          },
        },
      },
      keymap = {
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },
    },
  },
  -- {
  --   "saghen/blink.cmp",
  --   dependencies = { "saghen/blink.compat" },
  --   -- dependencies = {
  --   --   {
  --   --     "supermaven-inc/supermaven-nvim",
  --   --     opts = {
  --   --       disable_inline_completion = false, -- disables inline completion for use with cmp
  --   --       disable_keymaps = false, -- disables built in keymaps for more manual control
  --   --     },
  --   --   },
  --   --   {
  --   --     "huijiro/blink-cmp-supermaven",
  --   --   },
  --   -- },
  --   opts = {
  --     -- sources = {
  --     --   default = { "lsp", "path", "snippets", "buffer" },
  --     --   -- providers = {
  --     --   --   supermaven = {
  --     --   --     name = "supermaven",
  --     --   --     module = "blink-cmp-supermaven",
  --     --   --     async = true,
  --     --   --   },
  --     --   -- },
  --     -- },
  --     sources = {
  --       default = { "avante_commands", "avante_mentions", "avante_files" },
  --       providers = {
  --         avante_commands = {
  --           name = "avante_commands",
  --           module = "blink.compat.source",
  --           score_offset = 90, -- show at a higher priority than lsp
  --           opts = {},
  --         },
  --         avante_files = {
  --           name = "avante_commands",
  --           module = "blink.compat.source",
  --           score_offset = 100, -- show at a higher priority than lsp
  --           opts = {},
  --         },
  --         avante_mentions = {
  --           name = "avante_mentions",
  --           module = "blink.compat.source",
  --           score_offset = 1000, -- show at a higher priority than lsp
  --           opts = {},
  --         },
  --       },
  --     },
  --
  --     keymap = {
  --       ["<C-k>"] = { "select_prev", "fallback" },
  --       ["<C-j>"] = { "select_next", "fallback" },
  --     },
  --   },
  -- },
}
