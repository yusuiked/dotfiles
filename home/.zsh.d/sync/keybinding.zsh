# emacs keybinding mode
bindkey -e

bindkey '^U' backward-kill-line

# Move completion menu with Vim keybinding
# https://qiita.com/ToruIwashita/items/5cfa382e9ae2bd0502be
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# zsh-history-substring-search
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# Keybinding to fuzzy search the github repo and change dir to it
function anything-repo {
  local src=$(ghq list -p | fzf --query "$LBUFFER")
  if [[ -n "$src" ]]; then
    BUFFER="cd $src"
    zle accept-line
  fi
  zle -R -c
}
zle -N anything-repo
if [[ -x $HOMEBREW_PREFIX/bin/fzf && -x $HOMEBREW_PREFIX/bin/ghq ]]; then
  bindkey '^]' anything-repo
fi

