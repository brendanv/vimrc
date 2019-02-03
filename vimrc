if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'drewtempelmeyer/palenight.vim'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'ervandew/supertab'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'nathangrigg/vim-beancount', { 'for': 'beancount' }
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
call plug#end()

set term=screen-256color
set t_ut=
set t_Co=256
set background=dark
colorscheme palenight

" --------------------------------------------------------------
" |                                                 configleader
" --------------------------------------------------------------
let mapleader=','
" make it easy to edit and source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" make it easy to turn off search highlighting
nnoremap <leader><space> :nohlsearch<CR>
" Open fzf search pane for local files as well as recent buffers
nnoremap <leader>t :Files<CR>
nnoremap <leader>b :Buffers<CR>
" switch CWD to path of current buffer
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>
" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" --------------------------------------------------------------
" |                                               configmovement
" --------------------------------------------------------------
inoremap jk <Esc>
" move easily between splits
nnoremap <C-h> <C-w><Left>
nnoremap <C-l> <C-w><Right>
nnoremap <C-j> <C-w><Down>
nnoremap <C-k> <C-w><Up>
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" space collapses/expands folds
nnoremap <space> za
" highlight last inserted text
nnoremap gV `[v`]

" --------------------------------------------------------------
" |                                                     configui
" --------------------------------------------------------------
syntax enable
set number            " line numbers
set relativenumber
set ruler             " show line/col number
set nowrap            " no line wrapping
set cursorline        " highlight current lint
set wildmenu          " graphical autocomplete menu
"" First tab completes longest match, second tab begins cycling through the list
set wildmode=longest:full,full
set showmatch         " highlight matching paren/bracket
set modelines=0
set tabstop=2         " visual spaces per tab
set softtabstop=2     " number of spaces in tab when editing
set shiftwidth=2      " spaces for automatic indentation
set autoindent
set expandtab         " tabs are spaces
set smarttab          " be smart
set scrolloff=5       " scroll when cursor is 5 lines from top/bottom
set foldenable				" enable code folding
set foldmethod=syntax " Fold based on code syntax
set foldlevelstart=10 " Open most folds by default when opening buffers
set foldnestmax=10    " Don't nest folds too much
set formatoptions+=j  " Delete comment character when joining commented lines
set autoread          " Reload file

" --------------------------------------------------------------
" |                                                 configeditor
" --------------------------------------------------------------
" Create persistent undo files and store them all in the same directory
" Undo directory should be stored next to the vimrc.
let vimrcdir = fnamemodify($MYVIMRC, ':p:h')
let undopath = vimrcdir.'/undo/'
" Create the dir if it doesn't exist
if !isdirectory(undopath)
  silent call mkdir(undopath, 'p')
endif
let &undodir=undopath
set undofile
set lazyredraw               " redraw only when necessary
set completeopt=longest,menu " complete to longest match, show menu

" In insert mode, convert the word under the cursor to uppercase
inoremap <C-u> <esc>viwUea

" --------------------------------------------------------------
" |                                                 configsearch
" --------------------------------------------------------------
set incsearch   " search as you type
set hlsearch    " highlight matches
set ignorecase  " ignore case when searching
set smartcase   " unless it has a capital letter
set nohlsearch  " clear search

" --------------------------------------------------------------
" |                                             configautogroups
" --------------------------------------------------------------

augroup uiconfig
  autocmd!
  " Show absolute line numbers in insert mode only
  autocmd InsertEnter * set norelativenumber
  autocmd InsertLeave * set relativenumber
  " put cursor at previous position on file open
  autocmd BufReadPost * exe "normal! g`\""
  " resize splits when vim is resized
  autocmd VimResized * wincmd =
  " Trim trailing whitespace on save
  autocmd FileType c,cabal,cpp,haskell,javascript,php,python,readme,text,vim,beancount
        \ autocmd BufWritePre <buffer>
        \ :call <SID>TrimWhitespace()
  autocmd FocusGained,BufEnter * :checktime
augroup END


" --------------------------------------------------------------
" |                                                configairline
" --------------------------------------------------------------
let g:airline_theme='base16'

" --------------------------------------------------------------
" |                                        configcustomfunctions
" --------------------------------------------------------------
fun! <SID>TrimWhitespace()
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfun

" --------------------------------------------------------------
" |                                             configcommentary
" --------------------------------------------------------------
" vim recognized <C-/> as <C-_>
" In both normal and visual mode make <C-/> (un)comment the line
nnoremap <C-_> :Commentary<cr>
vnoremap <C-_> :Commentary<cr>

" --------------------------------------------------------------
" |                                                    configfzf
" --------------------------------------------------------------
" Update fzf pane to match current color scheme
let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
