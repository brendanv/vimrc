set nocompatible

" vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
call plug#end()

" UI Config
set term=screen-256color
set t_ut=
set t_Co=256
set background=dark
silent! colorscheme nord

syntax enable
set number            " line numbers
set relativenumber
set ruler             " show line/col number
set nowrap            " no line wrapping
set linebreak         " if wrapping is enabled, break between words
set cursorline        " highlight current lint
set showmatch         " highlight matching paren/bracket
set modelines=0
set tabstop=2         " visual spaces per tab
set softtabstop=2     " number of spaces in tab when editing
set shiftwidth=2      " spaces for automatic indentation
set autoindent
set expandtab         " tabs are spaces
set smarttab          " be smart
set scrolloff=5       " scroll when cursor is 5 lines from top/bottom
set foldenable " enable code folding
set foldmethod=syntax " Fold based on code syntax
set foldlevelstart=10 " Open most folds by default when opening buffers
set foldnestmax=10    " Don't nest folds too much
set visualbell        " Don't make noise

" Search
set incsearch   " search as you type
set hlsearch    " highlight matches
set ignorecase  " ignore case when searching
set smartcase   " unless it has a capital letter

" Movement
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

" Leader
" Open fzf search pane for local files as well as recent buffers
let mapleader=','
nnoremap <leader>t :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>c :Tags<CR>

" Editor
set formatoptions+=j         " Delete comment character when joining commented lines
set autoread                 " Reload file
set history=1000             " Store more :cmdline history
set lazyredraw               " redraw only when necessary
set completeopt=longest,menu " complete to longest match, show menu
set wildmenu                 " graphical autocomplete menu
"" First tab completes longest match, second tab begins cycling through the list
set wildmode=longest:full,full

" Lightline
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }

" FZF
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

" Commentary
" vim recognized <C-/> as <C-_>
" In both normal and visual mode make <C-/> (un)comment the line
nnoremap <C-_> :Commentary<cr>
vnoremap <C-_> :Commentary<cr>
