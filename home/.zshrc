#######################
# Completion settings #
#######################
# for zsh-completion
if type brew >/dev/null 2>&1; then
  fpath=($HOMEBREW_PREFIX/share/zsh-completions $fpath)
  fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
fi

# for Google Cloud Platform SDK completion
if [ -d $HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ]; then
  source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
  source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
fi

# Elimination of duplicate PATH
typeset -U path fpath manpath

# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Interactive refinement of completion candidates
# https://qiita.com/ToruIwashita/items/5cfa382e9ae2bd0502be
zstyle ':completion:*' menu select interactive
zstyle ':completion:*:default' menu select=2
setopt menu_complete
# Enhance completion
setopt auto_param_slash
setopt mark_dirs

# Lines configured by zsh-newuser-install
#######################
# Key binding         #
#######################
bindkey -e
# End of lines configured by zsh-newuser-install
bindkey \^U backward-kill-line
# Move completion menu with Vim keybind
# https://qiita.com/ToruIwashita/items/5cfa382e9ae2bd0502be
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
# Keybinding to fuzzy search the github repo and change dir to it
function anything-repo() {
  local src=$(ghq list -p | fzf --query "$LBUFFER")
  if [ -n "$src" ]; then
    BUFFER="cd $src"
    zle accept-line
  fi
  zle -R -c
}
zle -N anything-repo
bindkey '^]' anything-repo

#######################
# Terminal appearance #
#######################
export CLICOLOR=true
# for BSD ls
export LSCOLORS=gxfxcxdxbxegedabagacad
# Completion candidate color setting
[ -n "${LS_COLORS}" ] && zstyle ':completion:*' list-colors "${LS_COLORS}"
# Colorize prompt
autoload -Uz colors
colors

# prompt customization by starship
if type starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

#######################
# zsh plugins         #
#######################
# zsh-syntax-highlighting (See: https://github.com/zsh-users/zsh-syntax-highlighting)
if [ -f $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# zsh-history-substring-search (See: https://github.com/zsh-users/zsh-history-substring-search)
if [ -f $HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
  source $HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh
fi

# zsh-autosuggestions (See: https://github.com/zsh-users/zsh-autosuggestions)
if [ -f $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

#######################
# Application setup   #
#######################
# homeshick
if [[ -x $HOMEBREW_PREFIX/bin/homeshick ]]; then
  export HOMESHICK_DIR=$HOMEBREW_PREFIX/opt/homeshick
  source $HOMEBREW_PREFIX/opt/homeshick/homeshick.sh
fi

# asdf
if type asdf >/dev/null 2>&1; then
  . $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh
fi

# direnv
if type direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

#######################
# Alias settings      #
#######################
# Prefer eza, If not available, use ls to set alias.
if type eza >/dev/null 2>&1; then
  alias ls='eza -F --color=auto --icons'
  alias la='eza -aF --color=auto --icons'
  alias ll='eza -hlF --git --color=auto --icons'
  alias lla='eza -ahlF --git --color=auto --icons'
  alias lld='eza -dhlF --color=auto --icons'
  alias ll.='eza -dhlF --git --color=auto --icons .*'
  alias lt='eza -FTL 2 --color=auto --icons'
  alias llt='eza -hlFTL 2 --git --color=auto --icons'
else
  case ${OSTYPE} in
    freebsd*|darwin*)
      if [ -x $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin/ls ]; then
        # GNU
        alias ls='ls -F --color=auto'
      else
        # BSD
        alias ls='ls -GF'
      fi
      ;;
    linux*)
      alias ls='ls -F --color=auto'
      ;;
  esac
  alias la='ls -a'
  alias ll='ls -hl'
  alias lla='ll -a'
  alias lld='ll -d'
  alias ll.='ls -d .*'
fi

# Use `bat` instead of cat,less
if type bat >/dev/null 2>&1; then
  alias cat='bat --paging=never'
  alias less='bat'
fi

# Use `ripgrep` instead of normal grep
if type rg >/dev/null 2>&1; then
  alias grep='rg -S'
fi

# Use trash instead of rm
if type trash >/dev/null 2>&1; then
  alias rm='trash -F'
fi

# vim
alias vi='vim'
# tmux
alias tm='tmux'

# for github navigation
if [[ -x $HOMEBREW_PREFIX/bin/fzf && -x $HOMEBREW_PREFIX/bin/ghq && -x $HOMEBREW_PREFIX/bin/gh ]]; then
  alias repo='cd $(ghq list -p | fzf)'
  alias ghrepo='gh browse -R $(ghq list | grep "github.com" | fzf | cut -d "/" -f 2,3)'
fi

#######################
# misc config         #
#######################
# Set word break on CLI
autoload -Uz select-word-style
select-word-style default
#zstyle ':zle:*' word-chars " _-./;@"
zstyle ':zle:*' word-chars " ;@\"\'"
zstyle ':zle:*' word-style unspecified
WORDCHARS="$WORDCHARS\'\""

#######################
# utility function    #
#######################
# grep the JSON
function jgrep() { gron | grep $* | gron -u }

