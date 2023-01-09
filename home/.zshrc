# Lines configured by zsh-newuser-install
#######################
# Key binding         #
#######################
bindkey -e
# End of lines configured by zsh-newuser-install
bindkey \^U backward-kill-line
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
# Alias settings      #
#######################
# Prefer exa, If not available, use ls to set alias.
if type exa &>/dev/null; then
  alias ls='exa -F --color=auto --icons'
  alias la='exa -aF --color=auto --icons'
  alias ll='exa -hlF --git --color=auto --icons'
  alias lla='exa -ahlF --git --color=auto --icons'
  alias lld='exa -dhlF --color=auto --icons'
  alias ll.='exa -dhlF --git --color=auto --icons .*'
  alias lt='exa -FTL 2 --color=auto --icons'
  alias llt='exa -hlFTL 2 --git --color=auto --icons'
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

# colordiff
if [ -x $HOMEBREW_PREFIX/opt/colordiff/bin/colordiff ]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
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
# Terminal appearance #
#######################
export CLICOLOR=true
## for BSD ls
export LSCOLORS=gxfxcxdxbxegedabagacad

# less colorize, syntax highglighting
export LESS='-R -x4'    # ANSI Color Escape Sequence, tab stop
export LESSOPEN="| $HOMEBREW_PREFIX/bin/src-hilite-lesspipe.sh %s"

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
# Completion settings #
#######################
# for zsh-completion
if type brew &>/dev/null; then
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
# Move completion menu with Vim keybind
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

#######################
# Prompt appearance   #
#######################
# Completion candidate color setting
[ -n "${LS_COLORS}" ] && zstyle ':completion:*' list-colors "${LS_COLORS}"
# Colorize prompt
autoload -Uz colors
colors

#######################
# miscellaneous       #
#######################
# Set word break on CLI
autoload -Uz select-word-style
select-word-style default
#zstyle ':zle:*' word-chars " _-./;@"
zstyle ':zle:*' word-chars " ;@\"\'"
zstyle ':zle:*' word-style unspecified
WORDCHARS="$WORDCHARS\'\""

# direnv
if type direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi

# homeshick
if [[ -x $HOMEBREW_PREFIX/bin/homeshick ]]; then
  export HOMESHICK_DIR=$HOMEBREW_PREFIX/opt/homeshick
  source $HOMEBREW_PREFIX/opt/homeshick/homeshick.sh
fi

#######################
# custom function     #
#######################

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C $HOME/.anyenv/envs/tfenv/bin/terraform terraform

eval "$(starship init zsh)"

