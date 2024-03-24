-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.opt.autoindent = true
--vim.opt.indentexpr = O
-- vim.opt.shiftwidth = 4
-- vim.opt.smartindent = true
-- vim.opt.smarttab = true
-- vim.opt.softtabstop = 4
-- vim.opt.tabstop = 4
-- vim.opt.grepprg = "rg --vimgrep"
-- vim.opt.termguicolors = true

-- Leader key. This is required to be before lazy is loaded in top level init.lua
vim.g.mapleader = ","

-- vim.opt.clipboard = "unnamedplus" i should strive to keep vim and system clipboard separate.
-- vim.opt.hlsearch = false -- highlight searched words
-- vim.opt.incsearch = true -- highlight searched words
-- vim.opt.ignorecase = true -- Case-insensitive searching
-- vim.opt.lazyredraw = true -- will buffer screen updates instead of updating all the time.:help 'ttyfast'
-- vim.opt.list = true -- Highlight unwanted spaces
-- vim.opt.listchars = {
-- 	tab = "│·",
-- 	trail = "·",
-- 	-- eol = '↵',
-- } -- Show hidden characters, In this case list things
--
-- -- https://unix.stackexchange.com/questions/139578/copy-paste-for-vim-is-not-working-when-mouse-set-mouse-a-is-on
-- vim.opt.mouse = "a" -- Mouse is on for all modes
--
-- -- vim.opt.hlsearch=false -- Turn on if you want to remove highlighted text
-- vim.opt.showmode = false -- insert is already showing in lightline -- I am not sure what effect this has
-- vim.opt.swapfile = false
-- vim.opt.wrap = false -- Don't ever wordwrap my code
-- vim.opt.number = true -- Line number
-- vim.opt.relativenumber = true --Show relative line numbers from current line
-- vim.opt.scrolloff = 8 -- Offsets the cursor from the top when scrolling
-- vim.opt.sidescroll = 1
-- vim.opt.sidescrolloff = 15
-- vim.opt.signcolumn = "yes:1" -- always show sign column (bookmarks, gitgutter,..)
-- vim.opt.smartcase = true -- if a pattern contains an uppercase letter, it is case sensitive
--
-- -- Undotree stuff
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Disable diagonstics
vim.diagnostic.disable()

--
-- -- Some wildcard options
-- vim.opt.wildmode = { "longest", "list", "full" }
-- vim.opt.wildignore = {
-- 	"*.pyc",
-- 	"*_build/*",
-- 	"**/coverage/*",
-- 	"**/node_modules/*",
-- 	"**/ios/*",
-- 	"**/.git/*",
-- }
--
-- vim.opt.showcmd = true
-- vim.opt.laststatus = 2
-- vim.opt.cmdheight = 1
--
-- -- these two define the commands W and Q as the regular lower case to prevent typo from exiting/saving vim
-- vim.api.nvim_exec([[ command W w ]], false) -- common typo
-- vim.api.nvim_exec([[ command Q q ]], false) -- common typo
--
-- -- Spelling # do  :set spell to highlight possible spelling mistakes. Probably wont use this too much
-- vim.opt.spelllang = "en"
-- vim.opt.spellsuggest = "best,10" -- show only the top 10 candidates
--
-- vim.opt.autoread = true -- Update buffer if file has changed outside vim.
