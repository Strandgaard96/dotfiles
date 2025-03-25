-- -- This ensures nice borders on lsp hover
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

-- For LSP window border
require("lspconfig.ui.windows").default_options.border = "single"

return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    window = {
      completion = {
        border = "rounded",
      },
      documentation = {
        border = "rounded",
      },
    },
    opts = {
      inlay_hints = {
        enabled = false,
      },
    },
  },
}
