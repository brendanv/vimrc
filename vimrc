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
Plug 'ctrlpvim/ctrlp.vim'
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
nnoremap <leader>t :CtrlP<CR>


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

" --------------------------------------------------------------
" |                                                 configeditor
" --------------------------------------------------------------
" Create persistent undo files and store them all in the same directory
set undofile
set undodir=~/.vim/undodir
set lazyredraw               " redraw only when necessary
set completeopt=longest,menu " complete to longest match, show menu

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
  autocmd FileType c,cabal,cpp,haskell,javascript,php,python,readme,text,vim
        \ autocmd BufWritePre <buffer>
        \ :call <SID>TrimWhitespace()
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

