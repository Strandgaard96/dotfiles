-- Set colorscheme to jellybeans. I dont know how to set other themes. This snippet does some magic i dont understand
vim.api.nvim_exec([[
let g:jellybeans_overrides = {
\    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
\}
if has('termguicolors') && &termguicolors
    let g:jellybeans_overrides['background']['guibg'] = 'none'
endif
try
    colorscheme jellybeans
catch /^Vim\%((\a\+)\)\=:E185/ " https://stackoverflow.com/questions/5698284/in-my-vimrc-how-can-i-check-for-the-existence-of-a-color-scheme
    " Probably first installation
endtry

highlight clear SignColumn  " fix bg color for SignColumn (for jellybeans)
highlight Pmenu ctermbg=none
]], false)

