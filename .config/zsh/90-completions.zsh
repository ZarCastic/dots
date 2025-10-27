command -v devbox > /dev/null \
  && eval "$(devbox completion zsh)" \
  && eval "$(devbox global shellenv)"
command -v task > /dev/null && eval "$(task --completion zsh)"
command -v jj > /dev/null && source <(jj util completion zsh)
command -v fzf > /dev/null && eval "$(fzf --zsh)"
