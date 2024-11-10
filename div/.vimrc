" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Dec 17
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

set number
" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif


set scrolloff=10
set number
set relativenumber
set showmode
set showcmd
set smartcase
set incsearch
set hlsearch
set visualbell
set clipboard+=unnamed
let mapleader = ","


"  Key maps and settings

vmap K :m '<-2<CR>gv=gv
vmap J :m '>+1<CR>gv=gv
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Better up and down
nmap <expr> <silent> j v:count == 0 ? 'gj' : 'j'
nmap <expr> <silent> k v:count == 0 ? 'gk' : 'k'

" greatest remap ever. Paste over word. Preserve the paste.
xmap <leader>p [["_P]]

" Delete without yank
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

" Cut commands
nnoremap <leader>dc dd
vnoremap <leader>dc d
nnoremap <leader>Dc D

" Reselect visual selection after indenting # Neat
vnoremap < <gv
vnoremap > >gv
