local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- Leader key. This is required to be here by laxy!
vim.g.mapleader = ","

require("lazy").setup("plugins", {
  git = {
    -- defaults for the `Lazy log` command
    -- log = { "-10" }, -- show the last 10 commits
    log = { "--since=3 days ago" }, -- show commits from the last 3 days
    timeout = 120, -- kill processes that take more than 2 minutes
    url_format = "https://github.com/%s.git",
    -- lazy.nvim requires git >=2.19.0. If you really want to use lazy with an older version,
    -- then set the below to false. This is should work, but is NOT supported and will
    -- increase downloads a lot.
    filter = false,
  },
})

require 'base' -- Standard VIM settings
require 'maps' -- Most key mappings
require 'gui' -- Everything related to visual
require 'colorscheme' -- Set colorscheme

-- Check if vim is being installed for the first time
local is_not_setup = vim.env.NEOVIM_SETUP

if is_not_setup == nil then
    require 'ide'
end


