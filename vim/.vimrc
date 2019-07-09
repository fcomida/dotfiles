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

Plugin 'vim-airline/vim-airline'

Plugin 'vim-airline/vim-airline-themes'

Plugin 'edkolev/tmuxline.vim'

Plugin 'edkolev/promptline.vim'

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

Plugin 'vim-syntastic/syntastic'

Plugin 'tpope/vim-rhubarb'

Plugin 'scrooloose/nerdtree'

Plugin 'ervandew/supertab'

Plugin 'MarcWeber/vim-addon-mw-utils'

Plugin 'tomtom/tlib_vim'

Plugin 'SirVer/ultisnips'

Plugin 'honza/vim-snippets'

Plugin 'foxik/vim-makejob'

Plugin 'rhysd/vim-clang-format'

Plugin 'kana/vim-operator-user'

Plugin 'mboughaba/i3config.vim'

Plugin 'mkitt/tabline.vim'
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

vnoremap <C-c> "+y

"let mapleader = ','
let mapleader = ' '
"map <leader>( a()<ESC>i
map <Leader>( a<CR>{<CR><ESC>o<ESC>i}<ESC>ki<TAB>
map <C-n> :NERDTreeToggle<CR>
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
"nnoremap <C-down> ddp<ESC>
"nnoremap <C-up> ddk<ESC>P

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
set nopaste                    " Start in normal (non-paste) mode
set pastetoggle=<f11>          " Use <F11> to toggle paste modes

" Status / Command Line Options:
set wildmenu                   " Better commandline completion
set wildmode=longest:full,full " Expand match on first Tab complete
set showcmd                    " Show (partial) command in status line.
set laststatus=2               " Always show a status line
set cmdheight=2                " Prevent "Press Enter" messages
" Show detailed information in status line
set statusline=%f%m%r%h%w\ [%n:%{&ff}/%Y]%=[0x\%04.4B][%03v][%p%%\ line\ %l\ of\ %L]

"
set cursorline
set ruler
syntax enable
set synmaxcol=0
set display=uhex
set shortmess+=aAIsT
set nowrap
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
set autoindent

set smartcase
set relativenumber


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nowritebackup
set nobackup
set noswapfile

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
set grepprg=grep\ -nH\ $*
set t_Co=256
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
try
    colorscheme palenight
catch
endtry

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

let g:syntastic_debug = 0
let g:syntastic_cpp_compiler_options = '-std=gnu++11 -fPIC -Wno-deprecated-declarations'
let g:syntastic_cpp_include_dirs = ['./src', './build/src', '/usr/include','/usr/include/qt5','/usr/include/qt5/QtCore','/usr/include/qt5/QtGui','/usr/include/qt5/QtWidgets','/usr/include/qt5/QtConcurrent','/usr/include/qt5/QtSql','/usr/include/qt5/QtXml','/usr/include/qt5/QtWebEngineWidgets','/usr/include/qt5/QtNetwork','/usr/include/exiv2','/usr/include/OpenEXR','/usr/include/cfitsio','/usr/include/eigen3']
let g:syntastic_ignore_files = ['\m\c\<ui_[^/]*\.h$', '\m\c\<config\.h$', '\m\c\<global[^/]*$']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_auto_refresh_includes = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ultisnip
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme='jellybeans'
let g:airline_powerline_fonts = 1
let g:promptline_theme = 'jelly'
