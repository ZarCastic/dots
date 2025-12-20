ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "${ZINIT_HOME}" ]; then 
  print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
  command mkdir -p "$(dirname ${ZINIT_HOME})"
  command git clone https://github.com/zdharma-continuum/zinit "${ZINIT_HOME}"
fi

source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions

autoload -Uz compinit && compinit
zinit cdreplay -q
eval "$(direnv hook zsh)"
export PATH=$PATH:$HOME/bin:$HOME/.local/bin:$HOME/Scripts:$HOME/go/bin
export CDPATH=$CDPATH:$HOME:$HOME/Projects
export EDITOR=nvim
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
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
command -v devbox > /dev/null \
  && eval "$(devbox completion zsh)" \
  && eval "$(devbox global shellenv)"
command -v task > /dev/null && eval "$(task --completion zsh)"
command -v jj > /dev/null && source <(jj util completion zsh)
command -v fzf > /dev/null && eval "$(fzf --zsh)"
zinit wait lucid for \
  OMZL::git.zsh \
  OMZP::git
#some quickfixes
alias k="exit"

alias cat='bat'

alias ls='exa --icons'
alias l='exa --long --header --icons --git'
alias la='exa --long --all --icons --git'

alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down
mkcd() {
  mkdir -p "$*"
  cd "$*"
}
LS_COLORS='no=00;37:fi=00:di=00;33:ln=04;36:pi=40;33:so=01;35:bd=40;33;01:'
export LS_COLORS
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa --icons $realpath'
