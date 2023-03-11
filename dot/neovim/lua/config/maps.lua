-- Key maps :D

-- Inspo : https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- https://blog.devgenius.io/create-custom-keymaps-in-neovim-with-lua-d1167de0f2c2


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

-- floating terminal
map("n", "<leader>ft", function() Util.float_term(nil, { cwd = Util.get_root() }) end, { desc = "Terminal (root dir)" })
map("n", "<leader>fT", function() Util.float_term() end, { desc = "Terminal (cwd)" })
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

-- Navigate buffers
-- Much like a browser, just tab between buffers
vim.api.nvim_set_keymap('n', 'bn', ':bnext<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', 'bp', ':bprevious<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', 'bd', ':bdelete<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Tab>', ':bnext<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bprevious<cr>', { noremap = true })

-- Yank settings
-- Send yank register zero to ocs52
vim.keymap.set("n", "<Leader>y", function()
  local content = vim.fn.getreg('0')
  local escape = vim.fn.system("yank", content)
  vim.fn.writefile({ escape }, '/dev/tty', 'b')
end, { desc = "Yank OSC52" })

-- Useful stuff for copying stuf between vim sessions.
-- Copy the current visual slection to ~/.vbuf
vim.keymap.set('v', '<S-y>', ':w! ~/.vbuf<cr>')
-- Copy the current line to the buffer file if no visual selection
vim.keymap.set('n', '<S-y>', ':.w! ~/.vbuf<cr>')
-- Paste the contents of the buffer file
vim.keymap.set('n', '<S-p>', ':r ~/.vbuf<cr>')

-- Remove all white trails
vim.keymap.set('n', '<Leader>nw', [[:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>]], { desc = "Remove whitespaces" })

-- Format buffer based on isort and black
vim.api.nvim_set_keymap('n', '<Leader>nf', ':!format %<cr>', { silent = true, noremap = true, desc = "Format file" })

-- Use paste mode to prevent funcy paste for text copied outside of vim
vim.api.nvim_set_keymap('n', '<Leader>p', ':set invpaste<cr>', { desc = "Toggle pastemode" }) -- for that stackoverflow

-- Start spelling mode
vim.api.nvim_set_keymap('n', '<Leader>z', ':set spell!<cr>', { desc = "Toggle spellmode" })


-- Git commands
vim.api.nvim_set_keymap('n', '<leader>gu', ':GitGutterUndoHunk<cr>', { noremap = true, desc = 'Undo git hunk' })
vim.api.nvim_set_keymap('n', '<leader>gn', ':GitGutterNextHunk<cr>', { noremap = true, desc = 'Next git hunk' })
vim.api.nvim_set_keymap('n', '<leader>gp', ':GitGutterPrevHunk<cr>', { noremap = true, desc = 'Prev git hunk' })
vim.api.nvim_set_keymap('n', '<leader>gh', ':GitGutterPreviewHunk<cr>', { noremap = true, desc = 'Diff hunk' }) -- what changed in this hunk (close with :pclose)
vim.api.nvim_set_keymap('n', '<leader>gb', ':BlamerToggle<cr>', { noremap = true, desc = 'Toggle git blame' }) -- Show commit line is from

-- Cut commands
vim.api.nvim_set_keymap('n', '<leader>d', '""dd', { noremap = true, desc = 'Cut line' })
vim.api.nvim_set_keymap('v', '<leader>d', '""d', { noremap = true, desc = 'Cut' })
vim.api.nvim_set_keymap('n', '<leader>D', '""D', { noremap = true, desc = 'Cut rest of line' })


-- Sneak settings --Should checkout the keys for this
vim.api.nvim_exec([[
let g:sneak#label = 1
let g:sneak#target_labels = 'qwertasdfgzxcv'

" I need to do this to prevent the sneak map. I think there is a bug or something related to lazy. Sneak maps even
" if i set the other map below.
"unmap ,
" This is because , is my leader key. Now \ is the backwards key for sneak
nmap \ <Plug>Sneak_,

map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
]], false)

-- Lsp key bindings
vim.api.nvim_exec([[
nnoremap <Leader>ld    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>lD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <Leader>lr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <Leader>li    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <Leader>lh    <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <Leader>lf    <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <Leader>ln    <cmd>lua vim.lsp.buf.rename()<CR>
]], false)

-- A series of classic vim commands :D Changing some mappings
vim.api.nvim_exec([[
" More sane undo (undo breakpoints on char) # Not sure how this works
inoremap " "<c-g>u
inoremap ( (<c-g>u:
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap [ [<c-g>u

" Map movement keys to danish keyboard
noremap æ l
noremap l k
noremap k j
noremap j h

" I feel like going back a word should be consistent with w. Move backwards one word. Usual is b and B
nnoremap W b
vnoremap W b

" Delete without yank. The text is just removed
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

" keep me centered when jumping
nnoremap n nzzzv
nnoremap N Nzzzv
" I dont think i need this mapping : nnoremap J mzJ`z

" Reselect visual selection after indenting # Neat
vnoremap < <gv
vnoremap > >gv

" Maintain the cursor position when yanking a visual selection
" http://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap y myy`y

]], true)
