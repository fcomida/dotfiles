set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'easymotion/vim-easymotion'

Plugin 'takac/vim-hardtime'

Plugin 'itchyny/lightline.vim'

Plugin 'arcticicestudio/nord-vim'

Plugin 'octol/vim-cpp-enhanced-highlight'

Plugin 'drewtempelmeyer/palenight.vim'

Plugin 'ayu-theme/ayu-vim'

Plugin 'lsdr/monokai'

Plugin 'phanviet/vim-monokai-pro'

Plugin 'sonph/onehalf', {'rtp': 'vim/'}

Plugin 'tpope/vim-commentary'

Plugin 'MarcWeber/vim-addon-mw-utils'

Plugin 'tomtom/tlib_vim'

Plugin 'SirVer/ultisnips'

Plugin 'honza/vim-snippets'

Plugin 'foxik/vim-makejob'

Plugin 'kana/vim-operator-user'

Plugin 'frazrepo/vim-rainbow'

Plugin 'terryma/vim-expand-region'

Plugin 'christoomey/vim-tmux-navigator'

Plugin 'vim-syntastic/syntastic'

Plugin 'airblade/vim-gitgutter'

Plugin 'itchyny/vim-gitbranch'

Plugin 'nelstrom/vim-visual-star-search'

Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plugin 'junegunn/fzf.vim'

Plugin 'Yggdroot/indentLine'

Plugin 'ycm-core/YouCompleteMe'

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

" saner CTRL-L
nnoremap <leader>L :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" Quickly edit macros
nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

" n always search forward and N backward
nnoremap <expr> n  'Nn'[v:searchforward]
xnoremap <expr> n  'Nn'[v:searchforward]
onoremap <expr> n  'Nn'[v:searchforward]

nnoremap <expr> N  'nN'[v:searchforward]
xnoremap <expr> N  'nN'[v:searchforward]
onoremap <expr> N  'nN'[v:searchforward]

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

" -----------------------------------------------------------------------------
" Basic autocommands
" -----------------------------------------------------------------------------

" Auto-resize splits when Vim gets resized.
autocmd VimResized * wincmd =

" Lower timeour on InsertEnter
autocmd InsertEnter * silent! set timeoutlen=100
autocmd InsertLeave * silent! set timeoutlen=1000 | set nopaste

autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

" -----------------------------------------------------------------------------

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

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright

command -nargs=1 Vsb call VsbFunction(<f-args>)

function VsbFunction (arg1)
  execute 'vert sb' a:arg1
endfunction

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

set redrawtime=20000
""""""""""""""""""""""""""""""""""""""""""""""
" COLORS
""""""""""""""""""""""""""""""""""""""""""""""
"set t_Co=256
set background="dark"
" let st terminal display true colors
if &term == "st-256color"
    let &t_8f = "[38;2;%lu;%lu;%lum"
    let &t_8b = "[48;2;%lu;%lu;%lum"
    set t_ut=
endif

if &term == "st-256color" || &term == "xterm-256color" || &term == "alacritty" || &term == "xterm-new"
    set termguicolors
elseif &term == "tmux-256color" || &term == "screen-256color"
    set term=xterm-256color
    set termguicolors
endif

if !empty($DVTM_TERM)
    set notermguicolors
endif

let g:gruvbox_contrast_dark='hard'
let g:solarized_termcolors=256
let g:palenight_terminal_italics=1
let g:nord_italic=1
let g:nord_italic_comments=1
let ayucolor="dark"

try
    colorscheme onehalfdark
catch
endtry

if (&background == "dark")
  " Fix the visual selection and cursorline colors of ayu
  hi Visual cterm=NONE ctermfg=NONE ctermbg=237 guibg=#550000
  hi Cursorline cterm=NONE ctermfg=NONE ctermbg=237 guibg=#202020

else
  hi Visual cterm=NONE ctermfg=NONE ctermbg=223 guibg=#ffd7af
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DIFF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup aug_color_scheme
  au!

  autocmd ColorScheme slate call s:PatchColorScheme()
augroup END

function s:PatchColorScheme()
  hi! link DiffChange NONE
  hi! clear DiffChange
  hi! DiffText term=NONE ctermfg=215 ctermbg=233 cterm=NONE guifg=#FFB86C guibg=#14141a gui=NONE

endfunction

set diffopt=vertical,filler,context:3,indent-heuristic,algorithm:patience,internal

" Detect if vim is started as a diff tool (vim -d, vimdiff)
" NOTE: Does not work when you start Vim as usual and enter diff mode using :diffthis
if &diff
  let s:is_started_as_vim_diff = 1
  syntax off
  setlocal nospell
  colorscheme slate
endif

augroup aug_diffs
  au!

  " Inspect whether some windows are in diff mode, and apply changes for such windows
  " Run asynchronously, to ensure '&diff' option is properly set by Vim
  au WinEnter,BufEnter * call timer_start(50, 'CheckDiffMode')

augroup END

" In diff mode:
" - Disable syntax highlighting
" - Disable spell checking
function CheckDiffMode(timer)
  let curwin = winnr()

  " Check each window
  for _win in range(1, winnr('$'))
    exe "noautocmd " . _win . "wincmd w"

    call s:change_option_in_diffmode('b:', 'syntax', 'off')
    call s:change_option_in_diffmode('w:', 'spell', 0, 1)
  endfor

  " Get back to original window
  exe "noautocmd " . curwin . "wincmd w"
endfunction

" Detect window or buffer local option is in sync with diff mode
function s:change_option_in_diffmode(scope, option, value, ...)
  let isBoolean = get(a:, "1", 0)
  let backupVarname = a:scope . "_old_" . a:option

  " Entering diff mode
  if &diff && !exists(backupVarname)
    colorscheme slate
    exe "let " . backupVarname . "=&" . a:option
    call s:set_option(a:option, a:value, 1, isBoolean)
  endif

  " Exiting diff mode
  if !&diff && exists(backupVarname)
    colorscheme ayu
    let oldValue = eval(backupVarname)
    call s:set_option(a:option, oldValue, 1, isBoolean)
    exe "unlet " . backupVarname
  endif
endfunction

function s:set_option(option, value, ...)
  let isLocal = get(a:, "1", 0)
  let isBoolean = get(a:, "2", 0)
  if isBoolean
    exe (isLocal ? "setlocal " : "set ") . (a:value ? "" : "no") . a:option
  else
    exe (isLocal ? "setlocal " : "set ") . a:option . "=" . a:value
  endif
endfunction

nnoremap <silent> <leader>q :call <SID>QuitWindow()<CR>

function s:QuitWindow()
  if get(s:, 'is_started_as_vim_diff', 0)
    qall
    return
  endif

  quit
endfunction

nmap <expr> <Up> &diff ? '[czz' : '<Up>'
nmap <expr> <Down> &diff ? ']czz' : '<Down>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTAGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F5> :!ctags -R --c++-kinds=+p --fields=+liaS --extra=+q -f ~/.vim/tags/lhdr $(pwd) /usr/include/net-snmp<CR>
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
" Easy Motion
""""""""""""""""""""""""""""""""""""""""""""""
nmap f <Plug>(easymotion-overwin-f2)
map <leader>/ <Plug>(easymotion-bd-w)
nmap <leader>/f <Plug>(easymotion-overwin-w)

""""""""""""""""""""""""""""""""""""""""""""""
" OmniCppComplete
""""""""""""""""""""""""""""""""""""""""""""""
" let OmniCpp_NamespaceSearch = 1
" let OmniCpp_GlobalScopeSearch = 1
" let OmniCpp_ShowAccess = 1
" let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
" let OmniCpp_MayCompleteDot = 1 " autocomplete after .
" let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
" let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
" let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD", "boost", "pfs", "libhdr", "Qt"]
" let OmniCpp_SelectFirstItem = 2 " select first popup item (without inserting it to the text)
" " automatically open and close the popup menu / preview window
" set completeopt=menuone,menu,longest,preview
" au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"autocmd CmdwinEnter * inoremap <expr><buffer> <TAB>
"      \ pumvisible() ? "\<C-n>" : "\<TAB>"
let g:ycm_auto_hover = ""
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
            \ './build/',
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
      \ 'colorscheme': 'onehalfdark',
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
set rtp+=/home/franco/.vim/bundle/fzf
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

" Empty value to disable preview window altogether
 let g:fzf_preview_window = ''

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" File path completion in Insert mode using fzf
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-buffer-line)

" Use preview when FzfFiles runs in fullscreen
command! -bang -nargs=? -complete=dir FzfFiles
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--height=100%']}, <bang>0)

" Show list of change in fzf
" Some code is borrowed from ctrlp.vim and tweaked to work with fzf
command FzfChanges call s:fzf_changes()
nnoremap <silent> <leader>, :FzfChanges<CR>

function! s:fzf_changelist()
  redir => result
  silent! changes
  redir END
  return map(split(result, "\n")[1:], 'tr(v:val, "	", " ")')
endf

function! s:fzf_changeaccept(line)
  let info = matchlist(a:line, '\s\+\(\d\+\)\s\+\(\d\+\)\s\+\(\d\+\).\+$')
  call cursor(get(info, 2), get(info, 3))
  silent! norm! zvzz
endfunction

function! s:fzf_changes()
  return fzf#run(fzf#wrap({
\ 'source': reverse(s:fzf_changelist()),
\ 'sink': function('s:fzf_changeaccept'),
\ 'options': '+m +s --nth=3..'
\ }))
endfunction

" Mappings
nnoremap <silent> <leader>o :FzfFiles<CR>
nnoremap <silent> <leader>O :FzfFiles!<CR>
nnoremap <silent> <leader>l  :FzfBuffers<CR>
nnoremap <silent> <leader>b :FzfBLines<CR>
nnoremap <silent> <leader>`  :FzfMarks<CR>
nnoremap <silent> <leader>p :FzfCommands<CR>
nnoremap <silent> <leader>t :FzfFiletypes<CR>
nnoremap <silent> <leader>c :FzfChanges<CR>
nnoremap <silent> <leader>f :FzfGFiles<CR>
nnoremap <silent> <leader>? :FzfGFiles?<CR>
nnoremap <silent> <F1> :FzfHelptags<CR>
inoremap <silent> <F1> <ESC>:FzfHelptags<CR>
cnoremap <silent> <expr> <C-p> getcmdtype() == ":" ? "<C-u>:FzfHistory:\<CR>" : "\<ESC>:FzfHistory/\<CR>"
cnoremap <silent> <C-_> <C-u>:FzfCommands<CR>

" fzf.Tags uses existing 'tags' file or generates it otherwise
nnoremap <silent> <leader>] :FzfTags<CR>
xnoremap <silent> <leader>] "zy:FzfTags <C-r>z<CR>

" fzf.BTags generate tags on-fly for current file
nnoremap <silent> <leader>} :FzfBTags<CR>
xnoremap <silent> <leader>} "zy:FzfBTags <C-r>z<CR>

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
