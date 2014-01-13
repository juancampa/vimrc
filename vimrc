" NeoBundle config
if (has('vim_starting'))
    set nocompatible              " be iMproved
    set rtp+=~/vimfiles/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/vimfiles/bundle/'))

" required! 
NeoBundleFetch 'Shougo/neobundle.vim'

" My bundles here:
NeoBundle 'sjl/gundo.vim'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'bling/vim-airline'

" settings for gundo
nnoremap <F5> :GundoToggle<CR>
set undodir=~/vimfiles/undodir " This dir needs to be created manually for persistent undo to work.
set undofile
set undolevels=1000
set undoreload=10000

"some change

" settings for vim-airline
set laststatus=2

" Filetype detection including loading of plugins and indentation
filetype plugin indent on " required!

colorscheme candyman
set relativenumber
set clipboard=unnamed
set guifont=consolas:h8
set ignorecase

" Standard for most filetypes
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4

" Specific configuration for different filetypes
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType jade setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType stylus setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Select what just got put (pasted) 
nnoremap gp `[v`]

" Visual indent/unindent using tab
vmap <Tab> >gv
vmap <S-Tab> <gv

" Ctrl-S save
inoremap  <Esc>:w<Enter>i
nnoremap  :w<Enter>
vnoremap  :<Bs><Bs><Bs><Bs><Bs>w<Enter>gv

" Ctrl-Backspace delete word
inoremap <C-BS> <Esc>dbi
nnoremap <C-BS> db

" Syntax, indentation, line numbers
syntax on
set number
set hlsearch

" Highlight the cursor line
set cursorline

" Enable backspace in insert mode
set backspace=2

" Use <A-u> instead of <C-p> for ctrlp, consistent with VS's DPack.
nnoremap <A-u> :Ctrlp<Enter>
inoremap <A-u> <Esc>:Ctrlp<Enter>
vnoremap <A-u> <Esc>:Ctrlp<Enter>

" Smash j and k together to Escape.
inoremap jk <Esc>
inoremap kj <Esc>

" Keep 2 lines in view at the top/bottom of the buffer
set scrolloff=2

" Show matching parenthesis
set showmatch               " show matching braces, parantheses, brackets, etc
set matchpairs+=<:>         " show and % jump matching brackets
set matchpairs+=(:)
set matchpairs+={:}
set matchpairs+=[:]
set matchpairs+==:;         " variable assignments, etc
set matchtime=5             " Show match for 0.2 sec;

" Put swap files in a common dir
set backupdir=~/vimfiles/swapfiles//,C:\\temp//
set directory=~/vimfiles/swapfiles//,C:\\temp//

" Remove GUI on gvim
set guioptions-=T   " No toolbar
set guioptions-=m   " No menubar

" Highlight some stuff
highlight CommonErrors guifg=black guibg=red
syntax match CommonErrors /[Aa]chive/

" Macro to change special chars into their html entities.
let s:substitutionStr=':%s/á/\&aacute;/ge:%s/é/\&eacute;/ge:%s/í/\&iacute;/ge:%s/ó/\&oacute;/ge:%s/ú/\&uacute;/ge:%s/Á/\&aacute;/ge:%s/É/\&eacute;/ge:%s/Í/\&iacute;/ge:%s/Ó/\&oacute;/ge:%s/Ú/\&uacute;/ge'
autocmd FileType html let @a=s:substitutionStr
autocmd FileType jade let @a=s:substitutionStr

" Nice command that lets you see a diff between the current buffer
" and what is actually saved in the file.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif
