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

---------------------
---- NAVIGATION -----
---------------------

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

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

-- Navigate buffers
-- Much like a browser, just tab between buffers
map("n", "bn", ":bnext<cr>", { noremap = true })
map("n", "bp", ":bprevious<cr>", { noremap = true })
map("n", "bd", ":bdelete<cr>", { noremap = true })
map("n", "<Tab>", ":bnext<cr>", { noremap = true })
map("n", "<S-Tab>", ":bprevious<cr>", { noremap = true })

---------------------
---- Copy Paste -----
---------------------

-- greatest remap ever. Paste over word. Preserve the paste.
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- OSC 52 keymaps
map("n", "<leader>c", require("osc52").copy_operator, { expr = true })
map("n", "<leader>cc", "<leader>c_", { remap = true })
map("v", "<leader>c", require("osc52").copy_visual)

-- Delete without yank
map("n", "d", '"_d', { noremap = true, desc = "Delete without yank" })
map("n", "D", '"_D', { noremap = true, desc = "Delete without tank" })
map("v", "d", '"_d', { noremap = true, desc = "Delete without yank" })

-- Cut commands
map("n", "<leader>d", "dd", { noremap = true, desc = "Cut line" })
map("v", "<leader>d", "d", { noremap = true, desc = "Cut" })
map("n", "<leader>D", "D", { noremap = true, desc = "Cut rest of line" })

---------------------
---- ETC -----
---------------------

-- Unbind this immensly annoying keybind
map("n", "q:", "<nop>", { noremap = true, desc = "Quit on mistype" })

vim.api.nvim_set_keymap(
	"n",
	"<Leader>nd",
	":lua require('neogen').generate()<CR>",
	{ noremap = true, silent = true, desc = "Generate docstring" }
)

-- Easier access to substitute.
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
--Make file exectuable. nice.
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Reselect visual selection after indenting # Neat
map("v", "<", "<gv", { noremap = true, desc = "Reselect when indenting" })
map("v", ">", ">gv", { noremap = true, desc = "Reselect when indenting" })

-- Start spelling mode
map("n", "<Leader>z", ":set spell!<cr>", { desc = "Toggle spellmode" })
-- Format buffer based on isort and black. This func can be found in an lsp !
map("n", "<Leader>nf", ":!format %<cr>", { silent = true, noremap = true, desc = "Format file" })

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

map("n", "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
