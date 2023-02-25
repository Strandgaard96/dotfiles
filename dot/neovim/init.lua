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

require("lazy").setup("plugins")

require 'base' -- Standard VIM settings
require 'maps' -- Most key mappings
require 'gui' -- Everything related to visual
require 'colorscheme' -- Set colorscheme

-- Check if vim is being installed for the first time
local is_not_setup = vim.env.NEOVIM_SETUP

if is_not_setup == nil then
    require 'ide'
end


