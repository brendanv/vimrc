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
set expandtab         " tabs are spaces

" }}}
" Search {{{

set incsearch " search as you type
set hlsearch  " highlight matches

" }}}
" Leader Config {{{

let mapleader=","
nnoremap <leader>a :CtrlP<CR>
nnoremap <leader>r :call ToggleNumber()<CR>
" Make it easy to edit and source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" }}}
" Movement {{{

inoremap jk <Esc>
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" open/close folds with space
nnoremap <Space> za

" }}}
" Plugin - CtrlP {{{

let g:ctrlp_match_window = 'bottom,order:tbb'
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_switch_buffer = 0

" }}}
" Plugin - angloss/vim-javascript {{{

let g:jsx_ext_required = 0

" }}}
" Plugin  - mxw/vim-jsx {{{

let g:javascript_plugin_flow = 1

" }}}
" Custom Functions {{{

function! ToggleNumber()
	if(&relativenumber == 1)
		set norelativenumber
		set number
	else
		set relativenumber
	endif
endfunc

" }}}
" vim:foldmethod=marker:foldlevel=0
