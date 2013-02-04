set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

colorscheme desert

set cursorline

filetype indent on
set guifont=consolas
set number
set hlsearch
set incsearch

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Go to the first non whitespace line instead of col 0
nmap 0 ^
nmap <Space> i_<Esc>r

" So we can delete a word with control-backspace
imap <C-BS> <Esc><Right>dbi

" Save with c-s
nnoremap <C-S> :w<Enter>
inoremap <C-S> <Esc>:w<Enter>
vnoremap <C-S> <Esc>:w<Enter>gv

nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

nnoremap gp `[v`]

nunmap <C-a>

" Macros
let @j='<Esc>0i[Done] <Esc>'

" Share yanks with window clipboard
set clipboard=unnamed
