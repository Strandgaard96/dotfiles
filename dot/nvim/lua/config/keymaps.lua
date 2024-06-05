-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Lua function to map

local function map(mode, lhs, rhs, opts)
  -- do not create the keymap if a lazy keys handler exists
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
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
map("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

-- Delete without yank
map("n", "d", '"_d', { noremap = true, desc = "Delete without yank" })
map("n", "D", '"_D', { noremap = true, desc = "Delete without tank" })
map("v", "d", '"_d', { noremap = true, desc = "Delete without yank" })

-- Cut commands
map("n", "<leader>dc", "dd", { noremap = true, desc = "Cut line" })
map("v", "<leader>dc", "d", { noremap = true, desc = "Cut" })
map("n", "<leader>Dc", "D", { noremap = true, desc = "Cut rest of line" })

vim.keymap.set("n", "<Leader>oy", function()
  local content = vim.fn.getreg("0")
  -- local escape = vim.fn.system("yank", content)
  -- local filename = vim.fn.expand('$HOME/.vbufb')
  -- local file = assert(io.open(filename, "w"))
  -- file:write(escape)
  -- file:close()
  local f = io.popen("yank", "w")
  f:write(content)
  f:close()
end, { desc = "Yank OSC52" })

---------------------
---- ETC -----
---------------------

-- Unbind this immensly annoying keybind
map("n", "q:", "<nop>", { noremap = true, desc = "Quit on mistype" })

-- Easier access to substitute.
map("n", "<leader>su", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
--Make file exectuable. nice.
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Reselect visual selection after indenting # Neat
map("v", "<", "<gv", { noremap = true, desc = "Reselect when indenting" })
map("v", ">", ">gv", { noremap = true, desc = "Reselect when indenting" })

-- Start spelling mode
map("n", "<Leader>z", ":set spell!<cr>", { desc = "Toggle spellmode" })

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
map("v", "y", "myy`y", { noremap = true, desc = "Maintain the cursor position when yanking a visual selection" })

-- save file
map({ "i", "v", "n", "s" }, "<C-S>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- map("n", "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })

-- Scrolling lines in insert mode
map("i", "<M-k>", "<ESC>:m .+1<cr>==gi", { noremap = true, desc = "Neat scroll map insert" })
map("i", "<M-k>", "<ESC>:m .+1<cr>==gi", { noremap = true })

-- -- Peristence
-- -- -- restore the session for the current directory
-- vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {})
--
-- -- restore the last session
-- vim.api.nvim_set_keymap("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {})
