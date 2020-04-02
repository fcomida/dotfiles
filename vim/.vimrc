set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'takac/vim-hardtime'

Plugin 'ycm-core/YouCompleteMe'

Plugin 'rdnetto/YCM-Generator'

Plugin 'itchyny/lightline.vim'

Plugin 'arcticicestudio/nord-vim'

Plugin 'octol/vim-cpp-enhanced-highlight'

Plugin 'altercation/vim-colors-solarized'

Plugin 'dracula/vim'

Plugin 'morhetz/gruvbox'

Plugin 'joshdick/onedark.vim'

Plugin 'drewtempelmeyer/palenight.vim'

Plugin 'rafi/awesome-vim-colorschemes'

Plugin 'tpope/vim-fugitive'

Plugin 'tpope/vim-commentary'

Plugin 'airblade/vim-gitgutter'

Plugin 'tpope/vim-rhubarb'

Plugin 'scrooloose/nerdtree'

Plugin 'MarcWeber/vim-addon-mw-utils'

Plugin 'tomtom/tlib_vim'

Plugin 'SirVer/ultisnips'

Plugin 'honza/vim-snippets'

Plugin 'foxik/vim-makejob'

Plugin 'kana/vim-operator-user'

Plugin 'mboughaba/i3config.vim'

"Plugin 'mkitt/tabline.vim'
""Plugin 'justmao945/vim-clang'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"""""""
" Maps
"""""""
" Reformat current paragraph
nnoremap Q gqip

" Move cursor between visual lines on screen
nnoremap <Up> gk
nnoremap <Down> gj

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Toggle search highlighting
nnoremap <C-Bslash>       :set hls!<bar>:set hls?<CR>
inoremap <C-Bslash>       <Esc>:set hls!<bar>:set hls?<CR>a

no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>
" ino <down> <Nop>
" ino <left> <Nop>
" ino <right> <Nop>
" ino <up> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>

" copy visual selected test to clipboard
vnoremap <C-c> "+y

let mapleader = ' '
"map <Leader>( a<CR>{<CR><ESC>o<ESC>i}<ESC>ki<TAB>

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" Toggle between source and header
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Reselect code after indentation
vnoremap > >gv
vnoremap < <gv

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" tab navigation
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
" Alternatively use
"nnoremap th :tabnext<CR>
"nnoremap tl :tabprev<CR>
"nnoremap tn :tabnew<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright

command -nargs=1 Vsb call VsbFunction(<f-args>)

function VsbFunction (arg1)
  execute 'vert sb' a:arg1
endfunction


" =============
"  CUSTOM CODE
" =============
" Delete trailing white space on save.
func! DeleteTrailingWhiteSpace()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWhiteSpace()

""""""""""
" Options
""""""""""
" Use :help 'option (including the ' character) to learn more about each one.
"
" Automatic reloading of .vimrc file
"autocmd! bufwritepost .vimrc source %

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Buffer (File) Options:
set hidden                     " Edit multiple unsaved files at the same time
set confirm                    " Prompt to save unsaved changes when exiting
" Keep various histories between edits
set viminfo='1000,f1,<500,:100,/100,h

" search Options:
set hlsearch                   " Highlight searches. See below for more.
set ignorecase                 " Do case insensitive matching...
set smartcase                  " ...except when using capital letters
set incsearch                  " Incremental search

" Insert (Edit) Options:
set backspace=indent,eol,start " Better handling of backspace key
set autoindent                 " Sane indenting when filetype not recognised
set nostartofline              " Emulate typical editor navigation behaviour
set nowrap
set nopaste                    " Start in normal (non-paste) mode
set pastetoggle=<f11>          " Use <F11> to toggle paste modes

"
set relativenumber
set cursorline
set ruler
syntax enable
set synmaxcol=0
set display=uhex
set shortmess+=aAIsT

" Status / Command Line Options:
set wildmenu                   " Better commandline completion
set wildmode=longest:full,full " Expand match on first Tab complete
set showcmd                    " Show (partial) command in status line.
set laststatus=2               " Always show a status line
set cmdheight=2                " Prevent "Press Enter" messages

" Show detailed information in status line
" set statusline=%f%m%r%h%w\ [%n:%{&ff}/%Y]%=[0x\%04.4B][%03v][%p%%\ line\ %l\ of\ %L]

" set statusline=%F%m%r%h%w\
" set statusline+=%{fugitive#statusline()}\
" set statusline+=[%{strlen(&fenc)?&fenc:&enc}]
" set statusline+=\ [line\ %l\/%L]

" set statusline=[%n]\ %<%.99f\ %h%w%m%r%{fugitive#statusline()}%y%=%-16.(\ %l,%c-%v\ %)%P
" tpope's
" set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\ %l,%c-%v\ %)%P
"
" check if variable bg exists at all, and return it in a safe way
fun! GetBG()
if exists("&bg")|return &bg|else|return "-"|endif
endfun

" check is colorscheme name exists and return it
fun! GetCN()
if exists("g:colors_name") | return g:colors_name | else | return "-" | endif
endfun

set statusline=
set statusline+=%f%=\ " filename
set statusline+=%< " folding left
set statusline+=%{fugitive#statusline()}\
set statusline+=[%{GetBG()}\:%{GetCN()}]\ " background and colorscheme
set statusline+=[%1*%M%*%n%R%W\,%{strlen(&ft)?&ft:'none'}]\ " flags and filetype
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\ " highlight type on word
set statusline+=%(%3l,%02c%03V%)\ " row,column,virtual-column
set statusline+=\b\:%-04O\ " cursor hex offset from start of file
set statusline+=\c\:%03b\ " char byte code under cursor
set statusline+=%P " percentage of the file

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab
" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

set smartindent
set smartcase
" set noshowmode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
"set nowritebackup
"set nobackup
"set noswapfile

set showmatch
set matchtime=1

set completeopt=menu
set mousemodel=popup
set backspace=2
set number

set cc=+1,+2
set colorcolumn=133
set linespace=0
set history=1000
set list listchars=tab:›\ ,trail:-,extends:>,precedes:<,eol:¬
set makeprg=make\ -j5\ -C\ build
set encoding=utf-8

set grepprg=grep\ -nH\ $*

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTAGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f ~/.vim/tags/lhdr $(pwd)/src<CR>
set tags+=~/.vim/tags/lhdr
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/qt5-core
set tags+=~/.vim/tags/qt5-gui
set tags+=~/.vim/tags/qt5-widgets
set tags+=~/.vim/tags/qt5-concurrent
set tags+=~/.vim/tags/qt5-printsupport

""""""""""""""""""""""""""""""""""""""""""""""
" OmniCppComplete
""""""""""""""""""""""""""""""""""""""""""""""
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ['std', '_GLIBCXX_STD']
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

""""""""""""""""""""""""""""""""""""""""""""""
" COLORS
""""""""""""""""""""""""""""""""""""""""""""""
"set t_Co=256
set background=dark
" let st terminal display true colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
if &term == "st-256color"
    set termguicolors
endif
if &term == "xterm-256color"
    set termguicolors
endif
if &term == "tmux-256color"
    set term=xterm-256color
    set termguicolors
endif

let g:gruvbox_contrast_dark='hard'
let g:solarized_termcolors=256
let g:palenight_terminal_italics=1
let g:nord_italic=1
let g:nord_italic_comments=1
unlet g:c_comment_strings
try
    colorscheme palenight
catch
endtry

set statusline+=%#warningmsg#
set statusline+=%*

""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_clangd_binary_path = "/usr/bin/clangd"
"let g:ycm_key_list_select_completion=[]
"let g:ycm_key_list_previous_completion=[]

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ultisnip
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger='<leader><tab>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

""""""""""""""""""""""""""""""""""""""""""""""""""""
" lightline
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf
""""""""""""""""""""""""""""""""""""""""""""""""""""
" Customize fzf colors to match your color scheme
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

let g:fzf_layout = { 'down': '~40%' }

" Populate quickfix list with selected files
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  botright copen
  cc
endfunction

" Ctrl-q allows to select multiple elements an open them in quick list
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" Add namespace for fzf.vim exported commands
let g:fzf_command_prefix = 'Fzf'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

nnoremap <silent> <leader>o :FZF<CR>
