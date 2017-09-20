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
Plugin 'Shougo/neocomplete.vim'   " autocomplete
Plugin 'tomtom/tcomment_vim'      " easily comment/uncomment lines
Plugin 'airblade/vim-gitgutter'   " git status in sidebar
Plugin 'flowtype/vim-flow'        " flow
Plugin 'Shougo/vimfiler.vim'      " File explorer
Plugin 'Shougo/unite.vim'         " Dependency for vimfiler.vim
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
nnoremap <leader>f :VimFilerExplore -find -force-hide<CR>
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
  " Trim trailing whitespace on save
  autocmd FileType c,cabal,cpp,haskell,javascript,php,python,readme,text,vim
        \ autocmd BufWritePre <buffer>
        \ :call <SID>TrimWhitespace()
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
" Plugin - Shougo/vimfiler.vim {{{

" Replace default file explorer
let g:vimfiler_as_default_explorer = 1
" Change expand/collapse icons
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'
let g:vimfiler_tree_leaf_icon = ' '

" }}}
" Plugin - Shougo/neocomplete {{{

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
" These options basically replicate Atom/Nuclide's behavior for autcomplete.
" Select the first item in the list automatically, Tab or Enter confirms.
let g:neocomplete#enable_auto_select = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-y>" : "\<TAB>"
inoremap <expr><CR>  pumvisible() ? "\<C-y>" : "\<CR>"

" }}}
" Custom Functions {{{

fun! <SID>TrimWhitespace()
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfun

" }}}
" vim:foldmethod=marker:foldlevel=0
