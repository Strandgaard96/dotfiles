-- settings related to interface

-- Ruler options are overruled by vim-airline so only needed if you dont have the plugin
--Set the stuff in the bottom statusline
--vim.opt.ruler=true -- show the ruler
-- See https://vimhelp.org/options.txt.html#%27statusline%27 for formatting explanation
--vim.opt.rulerformat=[[=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)]]

vim.opt.showcmd=true
vim.opt.laststatus=2
vim.opt.cmdheight=1


-- fzf visual # fzf_layout is some variables specific to fzf.
vim.api.nvim_exec([[
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
]], false)

-- NB THIS OVERRIDES RULER SETTINGS !
-- Airline theme # colors  the different modes in vim. Makes it look nicer.
-- https://github.com/vim-airline/vim-airline
vim.api.nvim_exec([[
let g:airline_theme='jellybeans'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#tab_min_count = 2  " ignored : (
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline_powerline_fonts = 0
au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['%3p%% %L:%3v'])
]], false)


-- bookmark
vim.api.nvim_exec([[
let g:bookmark_sign = '•'
]], false)

--  Git # Setting gutter symbols for git changes. Like you have in pycharm
vim.api.nvim_exec([[
let g:gitgutter_sign_added = '|'
let g:gitgutter_sign_modified = '|'
let g:gitgutter_sign_removed = '|'
let g:gitgutter_sign_modified_removed = '|'
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red
]], false)

