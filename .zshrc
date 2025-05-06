# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export DOCKER_BUILDKIT=1

export CDPATH=$HOME:$HOME/Projects:$HOME/Scripts/
export PATH=$PATH:$HOME/bin:$HOME/.local/bin:$HOME/Scripts:$HOME/go/bin

export EDITOR=nvim

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
zstyle ':omz:plugins:nvm' lazy yes

plugins=(git dotenv direnv zsh-autosuggestions zsh-syntax-highlighting tmuxinator nvm)

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases.zsh
source $HOME/Scripts/functions.sh

eval "$(devbox completion zsh)"
eval "$(devbox global shellenv)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

source <(jj util completion zsh)

export NODE_OPTIONS=--use-openssl-ca

bindkey -v
eval "$(starship init zsh)"

eval "$(task --completion zsh)"

[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

eval "$(zoxide init zsh)"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk
