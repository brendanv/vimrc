" Brendan Viscomi
" Vundle {{{

set nocompatible
set runtimepath^=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'     " Vundle has to manage itself
Plugin 'ctrlpvim/ctrlp.vim'       " fuzzy searching
Plugin 'chriskempson/base16-vim'  " color schemes
Plugin 'vim-airline/vim-airline'  " status bar
Plugin 'pangloss/vim-javascript'  " js syntax highlighting
Plugin 'mxw/vim-jsx'              " jsx syntax highlighting
Plugin 'Valloric/YouCompleteMe'   " autocomplete
Plugin 'scrooloose/nerdtree'      " file explorer
Plugin 'tomtom/tcomment_vim'      " easily comment/uncomment lines
Plugin 'airblade/vim-gitgutter'   " git status in sidebar
Plugin 'flowtype/vim-flow'        " flow
call vundle#end()
filetype plugin indent on

" }}}
" Colors {{{

colorscheme base16-tomorrow-night

" }}}
" UI Config {{{

syntax enable
set number            " line numbers
set relativenumber
set ruler             " show line/col number
set showcmd           " command
set cursorline        " highlight current lint
set wildmenu          " graphical autocomplete menu
set lazyredraw        " redraw only when necessary
set showmatch         " highlight matching paren/bracket
set modelines=1       " check last line only for file-specific config
set tabstop=2         " visual spaces per tab
set softtabstop=2
set shiftwidth=2
set expandtab         " tabs are spaces
set smarttab          " be smart
set scrolloff=5       " scroll when cursor is 5 lines from top/bottom

" }}}
" Search {{{

set incsearch   " search as you type
set hlsearch    " highlight matches
set ignorecase  " ignore case when searching
set smartcase   " unless it has a capital letter
" make it easy to turn off search highlighting
nnoremap <leader><space> :nohlsearch<CR>

" }}}
" Leader Config {{{

let mapleader=","

" fuzzy search
nnoremap <leader>a :CtrlP<CR>
" show/hide file tree
nnoremap <leader>f :NERDTreeFind<CR>
" Make it easy to edit and source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" switch CWD to path of current buffer
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" }}}
" Movement {{{

inoremap jk <Esc>
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" open/close folds with space
nnoremap <Space> za
" Move left and right between splits
nnoremap <C-j> <C-w><Left>
nnoremap <C-k> <C-w><Right>

" }}}
" Autogroups {{{

augroup uiconfig
  autocmd!
  " Show absolute line numbers in insert mode only
  autocmd InsertEnter * set norelativenumber
  autocmd InsertLeave * set relativenumber
augroup END

" }}}
" Tmux {{{

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" }}}
" Plugin - CtrlP {{{

let g:ctrlp_match_window = 'bottom,order:tbb'
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_switch_buffer = 0

" }}}
" Plugin - angloss/vim-javascript {{{

let g:jsx_ext_required = 0

" }}}
" Plugin - mxw/vim-jsx {{{

let g:javascript_plugin_flow = 1

" }}}
" Plugin - scrooloose/nerdtree {{{

augroup nerdtree
  autocmd!
  " Close vim if only window open is nerdtree
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  " If no file is specified when starting vim, open nerdtree
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup END

" }}}
" Plugin - tomtom/tcomment_vim {{{

nnoremap <C-_> :TComment<CR>
vnoremap <C-_> :TComment<CR>

" }}}
" Plugin - flowtype/vim-flow {{{

" Close flow errors quickfix window if there are no errors
let g:flow#autoclose = 1
augroup vimflow
  autocmd!
  " Should put this in a JS-specific file, but it's ok for now
  autocmd FileType javascript nnoremap <buffer> gD :FlowJumpToDef<CR>
augroup END

" }}}
" Plugin - Valloric/YouCompleteMe {{{

" Close doc preview after completing method names
let g:ycm_autoclose_preview_window_after_completion = 1
" JS module names appear in comments so this is useful
let g:ycm_collect_identifiers_from_comments_and_strings = 1
" Don't cache omnifunc results because flow results can change
let g:ycm_cache_omnifunc = 0

" }}}
" Custom Functions {{{

" }}}
" vim:foldmethod=marker:foldlevel=0
