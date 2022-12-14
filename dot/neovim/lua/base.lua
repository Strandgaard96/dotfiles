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

vim.opt.hlsearch=true -- highlight searched words

vim.opt.ignorecase=true -- Case-insensitive searching
vim.opt.lazyredraw=true -- will buffer screen updates instead of updating all the time.:help 'ttyfast'
vim.opt.list=true -- Highlight unwanted spaces
vim.opt.listchars = {
    tab = '│·',
    trail = '·',
    -- eol = '↵',
} -- Show hidden characters, In this case list things

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

-- Buffer specific
-- _G is some global namespace
-- Im am not sure what is happening here. But this stuff is automatic and used to do some nice stuff for me
-- These commands are somwhow handling space/tab formats when opening files.
_G._autocommands = {}
_G._autocommands.is_space_or_tab = function()
    -- Check space or tab format. If space, check space width and update buffer

    -- File is very large, just use the default.
    if vim.fn.getfsize(vim.fn.bufname("%")) > 25600 then
        return
    end

    local lines = vim.fn.getbufline(vim.fn.bufname("%"), 1, 250)
    local lines_tabs = vim.fn.filter(lines, 'v:val =~ "^\\t"')
    local lines_spaces = vim.fn.filter(lines, 'v:val =~ "^ "')

    if #lines_tabs > #lines_spaces then
        vim.opt_local.expandtab=false
    else
        vim.opt_local.expandtab=true
        if #lines_spaces > 0 then
            _G._autocommands.find_indent_width(lines_spaces)
        end
    end
end

_G._autocommands.find_indent_width = function(lines)
    -- Check the whitespace per-buffer and set tabwidth

    local line = lines[1]
    local whitespace = 0

    for i = 1, #line do
        if (string.sub(line, i, i) == " ") then
            whitespace = whitespace + 1
        else
            break
        end
    end

    vim.opt_local.shiftwidth = whitespace
    vim.opt_local.tabstop = whitespace

end

-- Here the autocmd is defined. After reading buffer it is run.
-- TODO Is there a lua interface for BufReadPost?
vim.api.nvim_exec([[
autocmd BufReadPost * lua _autocommands.is_space_or_tab()
]], false)

-- these two define the commands W and Q as the regular lower case to prevent typo from exiting/saving vim
vim.api.nvim_exec([[ command W w ]], false) -- common typo
vim.api.nvim_exec([[ command Q q ]], false) -- common typo


-- Set default behavior for filetypes # I dont know whats going one here kekw
vim.api.nvim_exec([[
au BufRead,BufNewFile *.md,*.mdx,*.markdown setfiletype markdown
au BufRead,BufNewFile Jenkinsfile,*.Jenkinsfile setfiletype groovy
au BufRead,BufNewFile *.src setfiletype fortran
let fortran_more_precise=1
let fortran_dialect = "f77"
let s:extfname = expand("%:e")
if s:extfname ==? "f90"
    let fortran_free_source=1
    unlet! fortran_fixed_source
else
    let fortran_fixed_source=1
    unlet! fortran_free_source
endif
]], false)

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
