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
setopt interactive_comments

# vim mode
bindkey -v
export KEYTIMEOUT=1
export VI_MODE_SET_CURSOR=true

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]]; then
    echo -ne '\e[2 q' # block in vi mode
  else 
    echo -ne '\e[6 q' # beam in cmd mode
  fi
}
zle -N zle-keymap-select

function zle-line-init {
  zle -K viins
  echo -n '\e[6 q' # beam in cmd mode
}
zle -N zle-line-init

# global clipboard (cross platform because I like pain)
function vi-yank-clipboard {
  function clipboard_wrapper {
    if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
      wl-copy $1;
    elif [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
      xsel -ib $1;
    else
      pbcopy -i $1;
    fi
  }

  zle vi-yank
  echo "$CUTBUFFER" | clipboard_wrapper
}
zle -N vi-yank-clipboard
bindkey -M vicmd 'y' vi-yank-clipboard

# edit command in nvim buffer
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd n edit-command-line
