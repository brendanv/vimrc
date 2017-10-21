" TABLE OF CONTENTS
" - configplugins
" - configcolors
" - configeditor
" - configui
" - configsearch
" - configleader
" - configmovement
" - configautogroups
" - configtmux
" - configcommandt
" - configvimjavascript
" - configvimjsx
" - configvimfiler
" - configvimflow
" - configcustomfunctions
" - configsupertab
" - configdelimitmate


" --------------------------------------------------------------
" |                                                configplugins
" --------------------------------------------------------------
call plug#begin('~/.vim/plugged')
Plug 'wincent/command-t', {
    \   'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
    \ }
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'flowtype/vim-flow', { 'for': 'javascript' }
Plug 'Shougo/vimfiler.vim' |  Plug 'Shougo/unite.vim'
Plug 'tomtom/tcomment_vim'
Plug 'chriskempson/base16-vim'
Plug 'ervandew/supertab'
Plug 'raimondi/delimitmate'
Plug 'easymotion/vim-easymotion'
call plug#end()


" --------------------------------------------------------------
" |                                                 configcolors
" --------------------------------------------------------------
colorscheme base16-tomorrow-night
set bg=dark


" --------------------------------------------------------------
" |                                                 configeditor
" --------------------------------------------------------------
" Create persistent undo files and store them all in the same directory
set undofile
set undodir=~/.vim/undodir
set lazyredraw               " redraw only when necessary
set completeopt=longest,menu " complete to longest match, show menu


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
set foldnestmax=10    " Don't next folds too much
set formatoptions+=j  " Delete comment character when joining commented lines


" --------------------------------------------------------------
" |                                                 configsearch
" --------------------------------------------------------------
set incsearch   " search as you type
set hlsearch    " highlight matches
set ignorecase  " ignore case when searching
set smartcase   " unless it has a capital letter
set nohlsearch  " clear search


" --------------------------------------------------------------
" |                                                 configleader
" --------------------------------------------------------------
let mapleader=','
" show/hide file tree
nnoremap <leader>f :VimFilerExplore -find -force-hide<CR>
" make it easy to edit and source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" make it easy to turn off search highlighting
nnoremap <leader><space> :nohlsearch<CR>


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
" |                                                   configtmux
" --------------------------------------------------------------
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif


" --------------------------------------------------------------
" |                                                configairline
" --------------------------------------------------------------
let g:airline_theme='deus'


" --------------------------------------------------------------
" |                                               configcommandt
" --------------------------------------------------------------
let g:CommandTWildIgnore=&wildignore . ",*/node_modules/*,*/build/*,*/bin/*,*/coverage/*"
let g:CommandTSmartCase=1


" --------------------------------------------------------------
" |                                          configvimjavascript
" --------------------------------------------------------------
let g:jsx_ext_required = 0


" --------------------------------------------------------------
" |                                                 configvimjsx
" --------------------------------------------------------------
let g:javascript_plugin_flow = 1


" --------------------------------------------------------------
" |                                               configvimfiler
" --------------------------------------------------------------
" Replace default file explorer
let g:vimfiler_as_default_explorer = 1
" Change expand/collapse icons
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'
let g:vimfiler_tree_leaf_icon = ' '


" --------------------------------------------------------------
" |                                                configvimflow
" --------------------------------------------------------------
" Close flow errors quickfix window if there are no errors
let g:flow#autoclose = 1
augroup vimflow
  autocmd!
  " Should put this in a JS-specific file, but it's ok for now
  autocmd FileType javascript nnoremap <buffer> gD :FlowJumpToDef<CR>
augroup END


" --------------------------------------------------------------
" |                                               configsupertab
" --------------------------------------------------------------
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabLongestEnhanced=1
let g:SuperTabLongestHighlight=1


" --------------------------------------------------------------
" |                                            configdelimitmate
" --------------------------------------------------------------
" delimitMateCR inserts CR and will space things nicely if inside brackets
imap <expr><CR>  pumvisible() ? "\<C-y>" : "\<Plug>delimitMateCR"


" --------------------------------------------------------------
" |                                             configeasymotion
" --------------------------------------------------------------
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0 " Disable defaults
nmap s <Plug>(easymotion-overwin-f)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)


" --------------------------------------------------------------
" |                                        configcustomfunctions
" --------------------------------------------------------------
fun! <SID>TrimWhitespace()
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfun
