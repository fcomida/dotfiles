# Setup fzf
# ---------
if [[ ! "$PATH" == */home/franco/.vim/bundle/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/franco/.vim/bundle/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/franco/.vim/bundle/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/franco/.vim/bundle/fzf/shell/key-bindings.zsh"
