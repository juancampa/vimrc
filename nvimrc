set encoding=utf8

" NeoBundle config
if (has('vim_starting'))
    set nocompatible              " be iMproved
    set rtp+=~/vimfiles/bundle/neobundle.vim/
    set rtp+=~/.vim/bundle/neobundle.vim/

    " Remove GUI on gvim
    if has("gui_running")
      set guioptions-=T   " No tool bar
      set guioptions-=m   " No menu bar
      set guioptions-=e   " No tab bar (just the regular non GUI one)
      set guifont=consolas:h8
      " Maximize gvim window.
      set lines=999 columns=150
    endif
endif

call neobundle#begin(expand('~/vimfiles/bundle/'))

" required! 
NeoBundleFetch 'Shougo/neobundle.vim'

" My bundles here:
NeoBundle 'sjl/gundo.vim'               " Visualize the undo tree
"NeoBundle 'Lokaltog/vim-easymotion'    " "Easy" motion, I prefer "/"
NeoBundle 'flazz/vim-colorschemes'      " A bunch of colorschemes
NeoBundle 'bling/vim-airline'           " Improved status line
" NeoBundle 'kien/ctrlp.vim'              " Quick open file
"NeoBundle 'juancampa/mrutabs.vim'
NeoBundle 'yegappan/mru'                " MRU documents
" NeoBundle 'zef/vim-cycle'               " Cycle between related constructs (e.g. true -> false)
NeoBundle 'AndrewRadev/switch.vim'      " Seems better than vim-cycle
NeoBundle 'vim-scripts/keepcase.vim'    " Replace by keeping original upper/lower casing
NeoBundle 'xolox/vim-misc'              " Required by vim-session below
" NeoBundle 'xolox/vim-session'           " Improved session management
"
" On windows build manually or add the cl.exe compiler to PATH
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_msvc32.mak', 
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/unite.vim'            " Awesomest plugin ever? uber navigation
" NeoBundle 'scrooloose/nerdtree'         " Apparently is The file explorer
NeoBundle 'pangloss/vim-javascript'     " Improved Javascript syntax
NeoBundle 'elzr/vim-json'               " Improved Json syntax
NeoBundle 'kana/vim-textobj-user'       " Easily create text objects
NeoBundle 'glts/vim-textobj-comment'    " Comment Text object 

" To try
" NeoBundle 'rking/ag.vim'                " Awesome searching?
"NeoBundle 'jistr/vim-nerdtree-tabs'        " Improved behavior for the nerdtree

NeoBundle 'vim-scripts/visual_studio.vim'
NeoBundle 'tomtom/tcomment_vim'         " Commenting stuffSolution

NeoBundle 'tpope/vim-dispatch'          " :Make, and async wrapper for :make
" NeoBundle 'heaths/vim-msbuild'          " Compiling Visual Studio .*proj files
NeoBundle 'gcmt/wildfire.vim'
NeoBundle 'tpope/vim-fugitive'          " Git from vim
" NeoBundle 'nosami/Omnisharp'            " C# intellisense
" NeoBundle 'Valloric/YouCompleteMe'      " Superb code completion

" NeoBundle 'd:\git\vim_msbuild', { 'type': 'nosync'}
NeoBundle 'octol/vim-cpp-enhanced-highlight' " Improved c++
NeoBundle 'kana/vim-altr'               " Switch between related files
NeoBundle 'shougo/unite-outline'        " Unite source for an outline of the file
NeoBundle 'tsukkee/unite-tag'           " Unite source for tags (ctags)
NeoBundle 'AndrewRadev/undoquit.vim'    " Undo close of window with <c-w>u
NeoBundle 'MattesGroeger/vim-bookmarks' " Bookmarks
NeoBundle 'godlygeek/Tabular'           " Tabularizing text
NeoBundle 'christoomey/vim-tmux-navigator'

call neobundle#end()

" let g:agprg="C:\\Windows\\System32\\ag.exe --column"
"
" settings for gundo
if has("win32")
    set undodir=~/vimfiles/undodir  " This dir needs to be created manually for persistent undo to work.
else
    set undodir=~/.vim/undodir      " This dir needs to be created manually for persistent undo to work.
endif
set undofile
set undolevels=1000
set undoreload=10000

" Highlight the cursor line
set cursorline

" settings for vim-airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'jellybeans'

" Filetype detection including loading of plugins and indentation
filetype plugin indent on " required!

" colorscheme camper                      " My own theme based on BusyBee/Jellybeans
colorscheme BusyBee
" hi CursorLine term=none cterm=none guibg=none
"highlight CursorLine cterm=NONE ctermbg=darkred ctermfg=white

set number
set clipboard+=unnamedplus
set ignorecase
set smartcase

"  Standard for most filetypes
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4

" Treat Handlebars as HTML
autocmd BufRead *.handlebars set filetype=html

" Specific configuration for different filetypes
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType jade setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType stylus setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Java style (following wwf2 standards) 
autocmd FileType java setlocal noexpandtab

" Some tags in html are not indented by default.
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc" 
let g:html_indent_style1 = "inc"

" Managing items in the todo file
augroup todo
    autocmd BufRead *todo.txt setlocal filetype=markdown
    autocmd BufRead *todo.txt set autoindent
    autocmd BufRead *todo.txt let b:switch_custom_definitions =
        \ [
        \   {
        \     '^\( \+\)- \[ \]\(.*\)$'                     : '\1- [IN PROGRESS]\2',
        \     '^\( \+\)- \[IN PROGRESS\]\(.*\)$'           : '\1- [x]\2',
        \     '^\( \+\)- \[x\] \(.*\)$'                    : '\1\2',
        \     '^\( - \[[a-zA-Z ]\]\)\@!\( \+\)\([^-].*\)$' : '\2- [ ] \3',
        \     '^\( - \[[a-zA-Z ]\]\)\@!\( \@![^-].*\)$'    : ' - [ ] \2',
        \   },
        \ ]
augroup END

"        \     '\( - \[x\]\)\@<! \?\(.*\)$' : ' - [ ] \2',

" Swapping of quote <---> double quotes in javascipt
autocmd FileType javascript let b:switch_custom_definitions = [ { '"\(.*?\)"': "'\1'", "'\(.*?\)'": '"\1"' } ]

" Wildfire config
let g:wildfire_fuel_map = "<c-cr>" " This selects the next closest text object.
let g:wildfire_water_map = "<c-s-cr>" " This selects the previous closest text object.

" Switch.vim
nnoremap - :Switch<cr>

" Unite stuff
if has("win32")
    nnoremap <a-u> :<C-u>Unite buffer file_rec<cr>
else
    nnoremap <C-p> :<C-u>Unite buffer file_rec/git<cr>
    nnoremap <C-f> :<C-u>Unite -no-quit grep:.<cr>
    " Note: <c-@> actually means <c-space>
    nnoremap <C-@> :<C-u>Unite outline<cr>   
    autocmd BufEnter *
    \   if empty(&buftype)
    \|       nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
    \|   endif
endif

let g:unite_enable_start_insert=1     " Start in insert mode by default
" let g:unite_source_rec_async_command = 'ag --follow --nocolor --nogroup --hidden -g ""'
" let g:unite_source_grep_command = 'ag'
  " let g:unite_source_grep_default_opts =
  "       \ '--line-numbers --nocolor --nogroup --hidden --ignore ' .
  "       \ '''.svn'' --ignore ''.git'''

function! SolventBuildWrapper()
    !copy /Y "D:\Git\solventlogger\solventlogger\bin\Release\SolventLogger.dll" "D:\Git\vim_msbuild\plugin"
    py Solvent.Build()
endfunction

" Function key mappings
nnoremap <F5> :GundoToggle<Cr>
nnoremap <F6> :call SolventBuildWrapper()<Cr>
nnoremap <F7> :Mru<Cr>

nnoremap <A-o> :OpenSession<Cr>

" Next/prev buffer. TODO: MRU buffers
nnoremap <C-j> :bnext<Cr>
nnoremap <C-k> :bprev<Cr>
nnoremap <C-h> :call altr#forward()<Cr>

"" Select what just got put (pasted) 
nnoremap gp `[v`]

" Visual indent/unindent using tab
vmap <Tab> >gv;;
vmap <S-Tab> <gv;

" Ctrl-S save
inoremap  <Esc>:w<Enter>i
nnoremap  :w<Enter>
vnoremap  :<Bs><Bs><Bs><Bs><Bs>w<Enter>gv

" Ctrl-Backspace delete word
inoremap <C-BS> <Esc>dbi
nnoremap <C-BS> db

" inoremap <C-N> <Esc>:NERDTreeToggle<Cr>
" nnoremap <C-N> <Esc>:NERDTreeToggle<Cr>

" Syntax, indentation, line numbers
syntax on
set number
set hlsearch

" Enable backspace in insert mode
set backspace=2

" Use <A-u> instead of <C-p> for ctrlp, consistent with VS's DPack.
" let g:ctrlp_map = '<a-u>'
" let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_working_path_mode = 'ra'

" Session config for vim-session plugin
let g:session_autosave = 'yes'
let g:session_autoload = 'yes' 

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

if has("win32")
    set backupdir=~/vimfiles/swapfiles//,c:\\tmp
    set directory=~/vimfiles/swapfiles//,c:\\tmp
else
    set backupdir=~/.vim/swapfiles//,/tmp
    set directory=~/.vim/swapfiles//,/tmp
endif

" Nice command that lets you see a diff between the current buffer
" and what is actually saved in the file.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

" Command to change the directory to the current file
function! CdToCurrentFile()
    cd %:p:h
endfunction
command! Cdl call CdToCurrentFile()

" When in visual mode, use s to swap the currently selected text with
" the last deleted text.
function! Swaptext()
    let [row, column] = getpos("'[")[1:2]
    execute "normal! gvp"
    call setpos(".", [0, row, column, 0])
    if column > len(getline(row)) - 1
        normal! p
    else
        normal! P
    endif
endfunction
vnoremap <silent> s :<C-U>call Swaptext()<Cr>
nnoremap <silent> ss V:call Swaptext()<Cr>
nnoremap <silent> siw viw:call Swaptext()<Cr>
nnoremap <silent> siW viW:call Swaptext()<Cr>
nnoremap <silent> si" vi":call Swaptext()<Cr>
nnoremap <silent> si' vi':call Swaptext()<Cr>
nnoremap <silent> sib vib:call Swaptext()<Cr>
nnoremap <silent> siB viB:call Swaptext()<Cr>
nnoremap <silent> saw vaw:call Swaptext()<Cr>
nnoremap <silent> saW vaW:call Swaptext()<Cr>
nnoremap <silent> sa" va":call Swaptext()<Cr>
nnoremap <silent> sa' va':call Swaptext()<Cr>
nnoremap <silent> sab vab:call Swaptext()<Cr>
nnoremap <silent> saB vaB:call Swaptext()<Cr>

" convenience for testing solvent.vim
noremap <F11> :RestartVim<Cr>
noremap <F12> :Dissolve<Cr>

" Windowc closing, when the mapping is issued, if the current window has
" one of the closable buffers it will be closed, if the current window
" has another buffer the last buffer will be loaded on that window instead
" and the current one will be deleted.
let g:closable_buffers = ["solvent-tree"]
function! CloseBuffer()
    if !exists("g:closable_buffers")
        let g:closable_buffers = []
    endif
    if index(g:closable_buffers, @%) >= 0
        echo "closing closable"
        execute "normal :q\<cr>"
    else
        echo "closing non-closable"
        execute "normal :bp\<bar>sp\<bar>bn\<bar>bd\<cr>"
    endif
endfunction

" Ctrl-w twice to close tab
" nnoremap <c-w><c-w> :bdelete<Cr>
nnoremap <c-w><c-w> :call CloseBuffer()<Cr>

" Disable highlight search with escape instea of writing something like '/q-w-e-q-w-e'
" This causes problems in Mac for some reason
if has("win32")
    nnoremap <silent> <Esc> :let @/ = ""<cr><Esc>
endif

" set the textwidth to 80 so we can use gq on comments and make the look
" better but disable autoamtic wrapping.
set textwidth=80
set formatoptions-=t      " Fon't format regular code but,
set formatoptions-=c      " format comments :)

" " Make # and * work in visual mode too. Need more work because you can't
" " press it several times. I should select the next match.
vnoremap <buffer> # y?<c-r>*<cr>
vnoremap <buffer> * y/<c-r>*<cr>

set mouse=a

" Highlight some stuff
highlight CommonErrors guifg=black guibg=red
syntax match CommonErrors /[Aa]chive/

highlight PendingTasksGroup ctermfg=red
syntax match PendingTasksGroup /TODO/

highlight TicketNumber ctermfg=yellow ctermbg=black term=underline
syntax match TicketNumber /WWFT-[0-9]*/

" Transform Xcode default header template to WWF2 standard
augroup Words2
    autocmd filetype cpp let @f='gg/Createdd3djwwd3t_xv$U$iHyiwjviwpjjddOclass ggjwyiw/class$pa {public:};k<<Gwwd$xo:?classwyiwjop>>$a();yypyiwwbivirtual ~G:w'
    autocmd filetype cpp let @g='gg/Createdd3dj$bbbyiwopa::pa() {}pa::~pa() {}:w'
augroup END

" Checks if there are any new bundles pending install
NeoBundleCheck
