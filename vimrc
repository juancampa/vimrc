" NeoBundle config
if (has('vim_starting'))
    set nocompatible              " be iMproved
    set rtp+=~/vimfiles/bundle/neobundle.vim/

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

call neobundle#rc(expand('~/vimfiles/bundle/'))

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
NeoBundle 'xolox/vim-session'           " Improved session management
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
NeoBundle 'scrooloose/nerdtree'         " Apparently is The file explorer
NeoBundle "pangloss/vim-javascript"     " Improved Javascript support

" To try
NeoBundle 'rking/ag.vim'                " Awesome searching?
"NeoBundle 'jistr/vim-nerdtree-tabs'        " Improved behavior for the nerdtree

NeoBundle 'vim-scripts/visual_studio.vim'
NeoBundle 'tomtom/tcomment_vim'         " Commenting stuffSolution

NeoBundle 'tpope/vim-dispatch'          " :Make, and async wrapper for :make
" NeoBundle 'heaths/vim-msbuild'          " Compiling Visual Studio .*proj files
NeoBundle 'gcmt/wildfire.vim'
NeoBundle 'tpope/vim-fugitive'          " Git from vim
" NeoBundle 'nosami/Omnisharp'            " C# intellisense
NeoBundle 'Valloric/YouCompleteMe'      " Superb code completion

NeoBundle 'd:\git\vim_msbuild', { 'type': 'nosync'}

let g:agprg="C:\\Windows\\System32\\ag.exe --column"

" settings for gundo
set undodir=~/vimfiles/undodir " This dir needs to be created manually for persistent undo to work.
set undofile
set undolevels=1000
set undoreload=10000

" settings for vim-airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'jellybeans'

" Filetype detection including loading of plugins and indentation
filetype plugin indent on " required!

colorscheme camper                      " My own theme based on BusyBee/Jellybeans
set number
set clipboard=unnamed
set ignorecase
set smartcase

"  Standard for most filetypes
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4

" Specific configuration for different filetypes
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType jade setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType stylus setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Some tags in html are not indented by default.
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc" 
let g:html_indent_style1 = "inc"

" Adding item in the todo file
autocmd BufRead *todo.txt nnoremap o o - [ ] 
autocmd BufRead *todo.txt nnoremap O O - [ ] 
autocmd BufRead *todo.txt set filetype=markdown
autocmd BufRead *todo.txt let b:switch_custom_definitions =
    \ [
    \   {
    \     ' - \[ \]\(.*\)': ' - [IN PROGRESS]\1',
    \     ' - \[IN PROGRESS\]\(.*\)': ' - [x]\1',
    \     ' - \[x\]\(.*\)': ' - [ ]\1',
    \   },
    \ ]

autocmd FileType javascript let b:switch_custom_definitions = [ { '"\(.*?\)"': "'\1'", "'\(.*?\)'": '"\1"' } ]

" Wildfire config
let g:wildfire_fuel_map = "<c-cr>" " This selects the next closest text object.
let g:wildfire_water_map = "<c-s-cr>" " This selects the previous closest text object.

" Switch.vim
nnoremap - :Switch<cr>

" Unite stuff
nnoremap <a-u> :Unite buffer file_rec/async<cr>
let g:unite_enable_start_insert=1     " Start in insert mode by default

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

" Highlight the cursor line
set cursorline

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

" Put swap files in a common dir
set backupdir=~/vimfiles/swapfiles//,C:\\temp//
set directory=~/vimfiles/swapfiles//,C:\\temp//

" Highlight some stuff
highlight CommonErrors guifg=black guibg=red
syntax match CommonErrors /[Aa]chive/

highlight PendingTasksGroup ctermfg=red
match PendingTasksGroup /TODO/

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

" Disable highlight search with escape instea of writing something like '/qweqwe'
nnoremap <silent> <Esc> :let @/ = ""<cr><Esc>

" set the textwidth to 80 so we can use gq on comments and make the look
" better but disable autoamtic wrapping.
set textwidth=80
set formatoptions-=t      " Fon't format regular code but,
set formatoptions-=c      " format comments :)

" Make # and * work in visual mode too. Need more work because you can't
" press it several times. I should select the next match.
vnoremap <buffer> # y?<c-r>*<cr>
vnoremap <buffer> * y/<c-r>*<cr>

" Checks if there are any new bundles pending install
NeoBundleCheck
