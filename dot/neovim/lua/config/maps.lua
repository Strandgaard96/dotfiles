-- Key maps :D

-- Inspo : https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- https://blog.devgenius.io/create-custom-keymaps-in-neovim-with-lua-d1167de0f2c2

local Util = require("util")

-- Lua function to map
local function map(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	---@cast keys LazyKeysHandler
	-- do not create the keymap if a lazy keys handler exists
	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
		opts = opts or {}
		opts.silent = opts.silent ~= false
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

-- Better up and down allegedly
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Navigate buffers
-- Much like a browser, just tab between buffers
map("n", "bn", ":bnext<cr>", { noremap = true })
map("n", "bp", ":bprevious<cr>", { noremap = true })
map("n", "bd", ":bdelete<cr>", { noremap = true })
map("n", "<Tab>", ":bnext<cr>", { noremap = true })
map("n", "<S-Tab>", ":bprevious<cr>", { noremap = true })

-- vim script code from https://sunaku.github.io/tmux-yank-osc52.html.
vim.api.nvim_exec(
	[[
" copy to attached terminal using the yank(1) script:
" https://github.com/sunaku/home/blob/master/bin/yank
function! Yank(text) abort
  let escape = system('yank', a:text)
  if v:shell_error
    echoerr escape
  else
    call writefile([escape], '/dev/tty', 'b')
  endif
endfunction
noremap <silent> <Leader>y y:<C-U>call Yank(@0)<CR>

" automatically run yank(1) whenever yanking in Vim
" (this snippet was contributed by Larry Sanderson)
function! CopyYank() abort
  call Yank(join(v:event.regcontents, "\n"))
endfunction
autocmd TextYankPost * call CopyYank()
]],
	false
)
-- Useful stuff for copying stuf between vim sessions.
-- Copy the current visual slection to ~/.vbuf
map("v", "<S-y>", ":w! ~/.vbuf<cr>")
-- Copy the current line to the buffer file if no visual selection
map("n", "<S-y>", ":.w! ~/.vbuf<cr>")
-- Paste the contents of the buffer file
map("n", "<S-p>", ":r ~/.vbuf<cr>")

-- Remove all white trails
map("n", "<Leader>nw", [[:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>]], { desc = "Remove whitespaces" })

-- Format buffer based on isort and black. This func can be found in an lsp !
map("n", "<Leader>nf", ":!format %<cr>", { silent = true, noremap = true, desc = "Format file" })

-- Use paste mode to prevent funcy paste for text copied outside of vim
map("n", "<Leader>p", ":set invpaste<cr>", { desc = "Toggle pastemode" }) -- for that stackoverflow

-- Start spelling mode
map("n", "<Leader>z", ":set spell!<cr>", { desc = "Toggle spellmode" })
<<<<<<< HEAD
--
-- Delete without yank
map("n", "d", '"_d', { noremap = true, desc = "Delete without yank" })
map("n", "D", '"_D', { noremap = true, desc = "Delete without tank" })
map("v", "d", '"_d', { noremap = true, desc = "Delete without yank" })

-- Cut commands
map("n", "<leader>d", "dd", { noremap = true, desc = "Cut line" })
map("v", "<leader>d", "d", { noremap = true, desc = "Cut" })
map("n", "<leader>D", "D", { noremap = true, desc = "Cut rest of line" })
=======

-- Cut commands
map("n", "<leader>d", '""dd', { noremap = true, desc = "Cut line" })
map("v", "<leader>d", '""d', { noremap = true, desc = "Cut" })
map("n", "<leader>D", '""D', { noremap = true, desc = "Cut rest of line" })

<<<<<<< HEAD
-- Map movement keys to danish keyboard
map("n", "æ", "l", { noremap = true, desc = "Move right" })
map("n", "l", "k", { noremap = true, desc = "Move Up" })
map("n", "k", "j", { noremap = true, desc = "Move Down" })
map("n", "j", "h", { noremap = true, desc = "Move left" })
>>>>>>> e3abee7 (formatting and refactor.)
=======
>>>>>>> f67aa6d (Removed nordic keymap. Added isort black to null-ls.)

-- Reselect visual selection after indenting # Neat
map("v", "<", "<gv", { noremap = true, desc = "Reselect when indenting" })
map("v", ">", ">gv", { noremap = true, desc = "Reselect when indenting" })

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
map("v", "y", "myy`y", { noremap = true, desc = "Maintain the cursor position when yanking a visual selection" })

-- Trouble key maps
map("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Floating terminal keybinds
map("n", "<leader>ft", function()
	Util.float_term(nil, { cwd = Util.get_root() })
end, { desc = "Terminal (root dir)" })
map("n", "<leader>fT", function()
	Util.float_term()
end, { desc = "Terminal (cwd)" })
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
<<<<<<< HEAD

map("n", "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
=======
>>>>>>> e3abee7 (formatting and refactor.)

-- Unbind this immensly annoying keybind
map("n", "q:", "<nop>", { noremap = true, desc = "Quit on mistype" })

vim.api.nvim_set_keymap(
	"n",
	"<Leader>nd",
	":lua require('neogen').generate()<CR>",
	{ noremap = true, silent = true, desc = "Generate docstring" }
)

-- Delete without yank
map("n", "d", '"_d', { noremap = true, desc = "Delete without yank" })
map("n", "D", '"_D', { noremap = true, desc = "Delete without tank" })
map("v", "d", '"_d', { noremap = true, desc = "Delete without yank" })

--" I feel like going back a word should be consistent with w. Move backwards one word. Usual is b and B
--nnoremap W b
--vnoremap W b-

--centered when jumping
--nnoremap n nzzzv
--nnoremap N Nzzzv
