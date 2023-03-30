# If you come from bash you might have to change your $PATH.
#export PATH=$HOME/.scripts/:$PATH
# export TERMINAL=st
#source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#if [ "$(pidof fbterm)" ]
#then
#  export TERM=fbterm
#fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="agnoster"
ZSH_THEME="fox"
ZLE_RPROMPT_INDENT=0
# ZSH_THEME="powerlevel9k/powerlevel9k"
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs vi_mode time)

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  common-aliases
  colorize
  cp
  dnf
  history
  git
  k
  sudo
  systemd
  tmux
  vi-mode
  zsh-syntax-highlighting
  # fzf
  history-substring-search
  vundle
  pj
  catimg
  extract
  forgit
  themes
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=it_IT.UTF-8

#export COLORTERM=truecolor

#  pj
export PROJECT_PATHS=(~/src/fcomida/LuminanceHDR/src)
export PROJECT=~/src/fcomida/LuminanceHDR/src

export BROWSER='env MOZ_X11_EGL=1 firefox'
export XIVIEWER=sxiv
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
  export VISUAL='vim'
else
  alias vim=vimx
  export EDITOR='vimx'
  export VISUAL='vim'
fi

#zstyle ':completion:*' rehash true
# # # # # # # # ttyctl -f
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
export LESS='-C -M -R -I -j 10 -# 4'

if [[ -z $(tty | grep '/dev/pts') ]];
then
    ;
elif [[ "$TERM" == "dvtm-256color" ]];
then
    ;
else
function zle-line-init () { echoti smkx }
function zle-line-finish () { echoti rmkx }
zle -N zle-line-init
zle -N zle-line-finish

vim_ins_mode="INS"
vim_cmd_mode="NML"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  #__promptline
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

function TRAPINT() {
  vim_mode=$vim_ins_mode
  return $(( 128 + $1 ))
}
fi

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias lm='ls --group-directories-first --color=always -lh | less -r'        # pipe through 'less'
alias lma='ls --group-directories-first --color=always -alh | less -r'        # pipe through 'less'
alias lx='ls -lXB'              # sort by extension
alias lk='ls -lSrh'              # sort by size
alias lc='colorls -lA --sd --color=always'
alias vimrc='vim ~/.vimrc'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

# fzf stuff
# source /usr/share/zsh/site-functions/fzf
# Setting fd as the default source for fzf
# export FZF_DEFAULT_COMMAND='fd --type f'
# Configure fzf, command line fuzzyf finder
alias fzf=fzf-tmux
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
FD_OPTIONS="--follow --exclude .git --exclude node_modules"
#export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -F {}),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy),ctrl-x:execute(rm -i {+})+abort'"
export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat {}),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | xsel --clipboard --input),ctrl-x:execute(rm -i {+})+abort,ctrl-o:become(vim {} < /dev/tty > /dev/tty)'"

#export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info"

# Use git-ls-files inside git repo, otherwise fd
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard || fd --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="fd --type f --type l $FD_OPTIONS"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"
export FZF_TMUX_OPTS='-p80%,60%'

export BAT_PAGER="less -R"
export BAT_THEME="OneHalfDark"

export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export FORGIT_COPY_CMD='xclip -selection clipboard'

source $HOME/.local/share/fzf-git/fzf-git.sh

v() {
  local files
  files=$(grep '^>' ~/.viminfo | cut -c3- |
          while read line; do
            [ -f "${line/\~/$HOME}" ] && echo "$line"
          done | fzf-tmux -d -m -q "$*" -1) && vim ${files//\~/$HOME}
}

# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

# Enable decent options. See http://zsh.sourceforge.net/Doc/Release/Options.html.
# emulate zsh                    # restore default options just in case something messed them up
# setopt ALWAYS_TO_END           # full completions move cursor to the end
# setopt AUTO_CD                 # `dirname` is equivalent to `cd dirname`
# setopt AUTO_PARAM_SLASH        # if completed parameter is a directory, add a trailing slash
# setopt AUTO_PUSHD              # `cd` pushes directories to the directory stack
# setopt COMPLETE_IN_WORD        # complete from the cursor rather than from the end of the word
# setopt EXTENDED_GLOB           # more powerful globbing
# setopt EXTENDED_HISTORY        # write timestamps to history
# setopt HIST_EXPIRE_DUPS_FIRST  # if history needs to be trimmed, evict dups first
# setopt HIST_FIND_NO_DUPS       # don't show dups when searching history
# setopt HIST_IGNORE_DUPS        # don't add consecutive dups to history
# setopt HIST_IGNORE_SPACE       # don't add commands starting with space to history
# setopt HIST_VERIFY             # if a command triggers history expansion, show it instead of running
# setopt INTERACTIVE_COMMENTS    # allow comments in command line
# setopt MULTIOS                 # allow multiple redirections for the same fd
# setopt NO_BG_NICE              # don't nice background jobs
# setopt NO_FLOW_CONTROL         # disable start/stop characters in shell editor
# setopt PATH_DIRS               # perform path search even on command names with slashes
# setopt SHARE_HISTORY           # write and import history on every command
# setopt C_BASES                 # print hex/oct numbers as 0xFF/077 instead of 16#FF/8#77
setopt alwaystoend
setopt autocd
setopt autopushd
setopt nobeep
setopt completeinword
setopt correct
setopt extendedglob
setopt extendedhistory
setopt noflowcontrol
setopt histexpiredupsfirst
setopt histignorealldups
setopt histignoredups
setopt histignorespace
setopt histverify
setopt nohup
setopt incappendhistory
setopt interactive
setopt interactivecomments
setopt login
setopt longlistjobs
setopt nonotify
setopt nopromptcr
setopt nopromptsp
setopt promptsubst
setopt pushdignoredups
setopt pushdminus
setopt sharehistory
#setopt shinstdin
setopt vi
