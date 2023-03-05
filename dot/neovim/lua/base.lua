-- Base vim settings in the lua syntax

-- vim.o: behaves like :let &{option-name}
-- vim.go: behaves like :let &g:{option-name}
-- vim.bo: behaves like :let &l:{option-name} for buffer-local options
-- vim.wo: behaves like :let &l:{option-name} for window-local options

-- vim.opt: behaves like :set
-- vim.opt_global: behaves like :setglobal
-- vim.opt_local: behaves like :setlocal

-- Indent settings
vim.opt.autoindent=true
vim.opt.expandtab=true
vim.opt.indentexpr=O
vim.opt.shiftwidth=4
vim.opt.smartindent=true
vim.opt.smarttab=true
vim.opt.softtabstop=0
vim.opt.tabstop=4

vim.opt.clipboard = "unnamed,unnamedplus"
vim.opt.hlsearch=true -- highlight searched words
vim.opt.ignorecase=true -- Case-insensitive searching
vim.opt.lazyredraw=true -- will buffer screen updates instead of updating all the time.:help 'ttyfast'
vim.opt.list=true -- Highlight unwanted spaces
vim.opt.listchars = {
    tab = '│·',
    trail = '·',
    -- eol = '↵',
} -- Show hidden characters, In this case list things

-- https://unix.stackexchange.com/questions/139578/copy-paste-for-vim-is-not-working-when-mouse-set-mouse-a-is-on
vim.opt.mouse='a' -- Mouse is on for all modes

-- vim.opt.hlsearch=false -- Turn on if you want to remove highlighted text
vim.opt.showmode=false -- insert is already showing in lightline -- I am not sure what effect this has
vim.opt.swapfile=false
vim.opt.wrap=false -- Don't ever wordwrap my code
vim.opt.number=true -- Line number
vim.opt.relativenumber=true --Show relative line numbers from current line
vim.opt.scrolloff=8 -- Offsets the cursor from the top when scrolling
vim.opt.sidescroll=1
vim.opt.sidescrolloff=15
vim.opt.signcolumn='yes:1' -- always show sign column (bookmarks, gitgutter,..)
vim.opt.smartcase=true -- if a pattern contains an uppercase letter, it is case sensitive

-- Some wildcard options
vim.opt.wildmode={'longest','list','full'}
vim.opt.wildignore={
    '*.pyc',
    '*_build/*',
    '**/coverage/*',
    '**/node_modules/*',
    '**/ios/*',
    '**/.git/*',
}


-- these two define the commands W and Q as the regular lower case to prevent typo from exiting/saving vim
vim.api.nvim_exec([[ command W w ]], false) -- common typo
vim.api.nvim_exec([[ command Q q ]], false) -- common typo

-- Disable filetype plugin (it overwrites tab/indentation settings)
vim.api.nvim_exec([[filetype plugin off]], false)

-- Spelling # do  :set spell to highlight possible spelling mistakes. Probably wont use this too much
vim.opt.spelllang="en"
vim.opt.spellsuggest="best,10" -- show only the top 10 candidates

vim.opt.autoread=true -- Update buffer if file has changed outside vim.

-- https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
vim.api.nvim_exec([[
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
]],false)

-- Useful commands # This is a custom function! When you do :SortWords this function is run!
vim.api.nvim_exec([[
command -nargs=0 -range SortWords <line1>,<line2>call setline('.',join(sort(split(getline('.'),' ')),' '))
]],false)

-- if diff, ignore whitespace
if vim.api.nvim_win_get_option(0, "diff") then
    vim.opt.diffopt:append("iwhite")
end

----- Autocommands from LazyVim!
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query", -- :InspectTree
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
