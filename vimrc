if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'drewtempelmeyer/palenight.vim'
call plug#end()

set term=screen-256color
set t_ut=
set t_Co=256
set background=dark
colorscheme palenight

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

" --------------------------------------------------------------
" |                                                     configui
" --------------------------------------------------------------
syntax enable
set number            " line numbers
set relativenumber
set ruler             " show line/col number
set nowrap
set showcmd           " command
set cursorline        " highlight current lint
set wildmenu          " graphical autocomplete menu
"" First tab completes longest match, second tab begins cycling through the list
set wildmode=longest:full,full
set showmatch         " highlight matching paren/bracket
set modelines=0
set tabstop=2         " visual spaces per tab
set softtabstop=2
set shiftwidth=2
set autoindent
set expandtab         " tabs are spaces
set smarttab          " be smart
set scrolloff=5       " scroll when cursor is 5 lines from top/bottom
set foldmethod=syntax " Fold based on code syntax
set foldlevelstart=10 " Open most folds by default when opening buffers
set foldnestmax=10    " Don't nest folds too much
set formatoptions+=j  " Delete comment character when joining commented lines


