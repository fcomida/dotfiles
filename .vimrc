set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'takac/vim-hardtime'

Plugin 'itchyny/lightline.vim'

Plugin 'arcticicestudio/nord-vim'

Plugin 'octol/vim-cpp-enhanced-highlight'

Plugin 'drewtempelmeyer/palenight.vim'

Plugin 'ayu-theme/ayu-vim'

Plugin 'tpope/vim-commentary'

Plugin 'MarcWeber/vim-addon-mw-utils'

Plugin 'tomtom/tlib_vim'

Plugin 'SirVer/ultisnips'

Plugin 'honza/vim-snippets'

Plugin 'foxik/vim-makejob'

Plugin 'kana/vim-operator-user'

Plugin 'mboughaba/i3config.vim'

Plugin 'frazrepo/vim-rainbow'

Plugin 'terryma/vim-expand-region'

Plugin 'christoomey/vim-tmux-navigator'

Plugin 'vim-syntastic/syntastic'

Plugin 'itchyny/vim-gitbranch'

Plugin 'nelstrom/vim-visual-star-search'

Plugin 'junegunn/fzf.vim'

Plugin 'Yggdroot/indentLine'

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

" Set Leader to Space
let mapleader = "\<Space>"

" Reformat current paragraph
nnoremap Q gqip

" Move cursor between visual lines on screen
nnoremap <Up> gk
nnoremap <Down> gj

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" -----------------------------------------------------------------------------
" Basic autocommands
" -----------------------------------------------------------------------------

" Auto-resize splits when Vim gets resized.
autocmd VimResized * wincmd =

" Lower timeour on InsertEnter
autocmd InsertEnter * silent! set timeoutlen=100
autocmd InsertLeave * silent! set timeoutlen=1000 | set nopaste

" -----------------------------------------------------------------------------

" Add all TODO items to the quickfix list relative to where you opened Vim.
function! s:todo() abort
  let entries = []
  for cmd in ['git grep -niIw -e TODO -e FIXME 2> /dev/null',
            \ 'grep -rniIw -e TODO -e FIXME . 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor

  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction

command! Todo call s:todo()

" -----------------------------------------------------------------------------
" Ctrl-Space for completions. Heck Yeah!
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
        \ "\<lt>C-n>" :
        \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
        \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
        \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

" Toggle search highlighting
nnoremap <Leader><Bslash>   :set hls!<bar>:set hls?<CR>
inoremap <Leader><Bslash>   <Esc>:set hls!<bar>:set hls?<CR>a

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

" Type <Space>w to save file (a lot faster than :w<Enter>):
nnoremap <Leader>w :w<CR>
nnoremap <Leader>s :wq<CR>
"nnoremap <Leader>v V
nnoremap <Leader>g gf

" nnoremap H 0
" nnoremap L $

" Copy & paste to system clipboard with <Space>p and <Space>y:
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

"Enter visual line mode with <Space><Space>:
nmap <Leader><Leader> V
nmap <Leader>b :MakeJob<CR>

" vim-expand
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Discover text search object
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

" Automatically jump to end of text you pasted:
" I can paste multiple lines multiple times with simple ppppp.
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" nnoremap <CR> G
" nnoremap <BS> gg

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

" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>

" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
xnoremap <Leader>r :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

" Type a replacement term and press . to repeat the replacement again. Useful
" for replacing a few instances of the term (comparable to multiple cursors).
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> s* "sy:let @/=@s<CR>cgn

" Edit Vim config file in a new tab.
map <Leader>ev :tabnew $MYVIMRC<CR>

" Source Vim config file.
map <Leader>sv :source $MYVIMRC<CR>

map <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
map <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>

" tab navigation
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprevious<CR>
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
set cmdheight=2                " Prevent 'Press Enter' messages

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noshowmode
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
set makeprg=make\ -j5\ -C\ ../build
set encoding=utf-8

set grepprg=grep\ -nH\ $*

set ttimeout
set ttyfast
set ttymouse=sgr

""""""""""""""""""""""""""""""""""""""""""""""
" COLORS
""""""""""""""""""""""""""""""""""""""""""""""
"set t_Co=256
set background="dark"
" let st terminal display true colors
if &term == "st-256color"
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

if &term == "st-256color" || &term == "xterm-256color"
    set termguicolors
elseif &term == "tmux-256color" || &term == "screen-256color"
    set term=xterm-256color
    set termguicolors
endif

let g:gruvbox_contrast_dark='hard'
let g:solarized_termcolors=256
let g:palenight_terminal_italics=1
let g:nord_italic=1
let g:nord_italic_comments=1
let ayucolor="dark"

try
    colorscheme ayu
catch
endtry

if (&background == "dark")
  " Fix the visual selection and cursorline colors of palenight
  hi Visual cterm=NONE ctermfg=NONE ctermbg=237 guibg=#550000
  hi Cursorline cterm=NONE ctermfg=NONE ctermbg=237 guibg=#202020

else
  hi Visual cterm=NONE ctermfg=NONE ctermbg=223 guibg=#ffd7af
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTAGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F5> :!ctags -R --c++-kinds=+p --fields=+liaS --extra=+q -f ~/.vim/tags/lhdr $(pwd)<CR>
set tags+=~/.vim/tags/lhdr
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/qt5-core
set tags+=~/.vim/tags/qt5-gui
set tags+=~/.vim/tags/qt5-widgets
set tags+=~/.vim/tags/qt5-concurrent
set tags+=~/.vim/tags/qt5-printsupport

set path+=$PROJECT

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD", "boost", "pfs", "libhdr"]
let OmniCpp_SelectFirstItem = 2 " select first popup item (without inserting it to the text)
" automatically open and close the popup menu / preview window
set completeopt=menuone,menu,longest,preview
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"autocmd CmdwinEnter * inoremap <expr><buffer> <TAB>
"      \ pumvisible() ? "\<C-n>" : "\<TAB>"

""""""""""""""""""""""""""""""""""""""""""""""""""""
" cpp enhanced highlight
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_template_highlight = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_debug = 0
let g:syntastic_cpp_compiler_options = '-std=gnu++11 -fPIC -Wno-deprecated-declarations'
let g:syntastic_cpp_include_dirs = [
            \ './src',
            \ './build/src',
            \ '/usr/include',
            \ '/usr/include/qt5',
            \ '/usr/include/qt5/QtCore',
            \ '/usr/include/qt5/QtGui',
            \ '/usr/include/qt5/QtWidgets',
            \ '/usr/include/qt5/QtConcurrent',
            \ '/usr/include/qt5/QtSql',
            \ '/usr/include/qt5/QtXml',
            \ '/usr/include/qt5/QtWebEngineWidgets',
            \ '/usr/include/qt5/QtNetwork',
            \ '/usr/include/exiv2',
            \ '/usr/include/OpenEXR',
            \ '/usr/include/cfitsio',
            \ '/usr/include/eigen3']
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
"let g:UltiSnipsExpandTrigger='<Tab>'
"let g:UltiSnipsJumpForwardTrigger='<c-j>'
"let g:UltiSnipsJumpBackwardTrigger='<c-k>'

""""""""""""""""""""""""""""""""""""""""""""""""""""
" lightline
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'ayu',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
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
let g:fzf_command_prefix = ''

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

nnoremap <silent> <leader>o :FZF -m<CR>

" Map a few common things to do with FZF.
nnoremap <silent> <Leader><Enter> :Buffers<CR>
nnoremap <silent> <Leader>l :Lines<CR>
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM RAINBOW
""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType c,cpp call rainbow#load()

let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'red',  'yellow', 'magenta']

""""""""""""""""""""""""""""""""""""""""""""""""""""
" IndentLine
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']