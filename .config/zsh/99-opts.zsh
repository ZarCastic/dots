HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=${HISTSIZE}
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt auto_cd

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

export PATH=$PATH:$HOME/bin:$HOME/.local/bin:$HOME/Scripts:$HOME/go/bin
export EDITOR=nvim
