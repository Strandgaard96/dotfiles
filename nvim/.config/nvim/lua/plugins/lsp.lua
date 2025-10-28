-- File: nvim/.config/nvim/lua/plugins/lsp.lua

-- For LSP window border
require("lspconfig.ui.windows").default_options.border = "single"

return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = function(_, opts)
      -- Merge the existing opts table from LazyVim
      -- Find the jsonls server settings and disable formatting
      opts.servers = opts.servers or {}
      opts.servers.jsonls = vim.tbl_deep_extend("force", opts.servers.jsonls or {}, {
        -- Settings passed to vscode-json-language-server
        -- See https://github.com/microsoft/vscode-json-languageservice/blob/main/docs/configuration.md
        settings = {
          json = {
            format = {
              enable = false, -- Explicitly disable formatting
            },
            validate = { enable = true },
          },
        },
        -- Disable formatting capabilities even if the server offers them
        capabilities = vim.tbl_deep_extend("force", {}, opts.capabilities or {}, {
          textDocument = {
            formatting = false,
            rangeFormatting = false,
          },
        }),
        -- Ensure init_options also reflects no formatter if needed, though settings usually suffice
        init_options = {
          provideFormatter = false,
        },
      })

      -- You had this here before, keep it if you still want it
      opts.inlay_hints = {
        enabled = false,
      }

      -- Set border options (these might be superseded by LazyVim defaults or other plugins like noice.nvim)
      opts.window = {
        completion = { border = "rounded" },
        documentation = { border = "rounded" },
      }

      return opts
    end,
  },
}
