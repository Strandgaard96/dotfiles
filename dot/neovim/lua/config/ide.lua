-- More like IDE
-- Lualine
--require('lualine').setup {
--  options = {
--    icons_enabled = false,
--    theme = 'onelight',
--    },
--}

vim.api.nvim_set_keymap("n", "<Leader>nd", ":lua require('neogen').generate()<CR>",
  { noremap = true, silent = true, desc = "Generate docstring" })


--- Treesitter. Gives nice highlighting for languages!!!

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
configs.setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'lua', 'python', 'help', "bash", "c", "json", "yaml", "markdown", "markdown_inline"},

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = true,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
      },
      goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
      },
      goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
      },
      goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
            ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
            ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '[dis', vim.diagnostic.disable, { desc = "Disable diagnostic message" })
vim.keymap.set('n', '[ena', vim.diagnostic.enable, { desc = "Enable diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
