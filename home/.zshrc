# Lines configured by zsh-newuser-install
#######################
# Key binding         #
#######################
bindkey -e
# End of lines configured by zsh-newuser-install
bindkey \^U backward-kill-line

#######################
# Alias settings      #
#######################
# ls
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
alias l.='ls -d .*'

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
bindkey '^]' anything-repo
function anything-repo() {
  local src=$(ghq list -p | fzf --query "$LBUFFER")
  if [ -n "$src" ]; then
    BUFFER="cd $src"
    zle accept-line
  fi
  zle -R -c
}
zle -N anything-repo

#######################
# Terminal appearance #
#######################
export CLICOLOR=true
## for BSD ls
export LSCOLORS=gxfxcxdxbxegedabagacad
## for GNU ls (require coreutils and colorscheme file for dircolors)
if type dircolors > /dev/null 2>&1 && [ -r $HOME/.dircolors ]; then
  eval $(dircolors $HOME/.dircolors)
fi

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
if type brew &>/dev/null 2>&1; then
  fpath=($HOMEBREW_PREFIX/share/zsh-completions $fpath)
  fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
fi

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


# Completion candidate color setting
[ -n "${LS_COLORS}" ] && zstyle ':completion:*' list-colors "${LS_COLORS}"

#######################
# Prompt appearance   #
#######################
# Colorize prompt
autoload -Uz colors
colors

# Git prompt customize

# In order to substitute in powerline-gitstatus, the following has been commented out.
# https://github.com/jaspernbrouwer/powerline-gitstatus
# ## using git-prompt
# source /usr/local/etc/bash_completion.d/git-prompt.sh
# setopt prompt_subst
# setopt transient_rprompt
# precmd () {
#   RPROMPT="%F{red}$(__git_ps1)%f"
# }
# GIT_PS1_SHOWDIRTYSTATE=true
# GIT_PS1_SHOWSTASHSTATE=true
# GIT_PS1_SHOWUNTRACKEDFILES=true
# GIT_PS1_SHOWUPSTREAM="auto"
# GIT_PS1_SHOWCOLORHINTS=true
#
# PROMPT="[%F{green}%n@%m%f %F{blue}%~%f]%# "

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
# Elimination of duplicate PATH
typeset -U path fpath manpath

# direnv
if type direnv > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# homeshick
if [[ -x $HOMEBREW_PREFIX/bin/homeshick ]]; then
  export HOMESHICK_DIR=$HOMEBREW_PREFIX/opt/homeshick
  source $HOMEBREW_PREFIX/opt/homeshick/homeshick.sh
fi

# powerline
if type powerline-daemon > /dev/null 2>&1; then
  powerline-daemon -q --replace
  . $HOMEBREW_PREFIX/lib/python3.9/site-packages/powerline/bindings/zsh/powerline.zsh
fi

#######################
# custom function     #
#######################
# Ref: https://blog.shibayu36.org/entry/2019/01/09/193000
function epoch2date() {
  date --date="@$1" +%Y-%m-%dT%H:%M:%S%z
}

# Ref: https://takezoe.hatenablog.com/entry/2017/08/19/164355
function sbtn() {
  local TEMPLATE=`curl -s https://github.com/foundweekends/giter8/wiki/giter8-templates | grep "\.g8<" | sed -e "s/</ /g" -e "s/>/ /g" | awk '{print $3}' | fzf | head -n1`
  if [[ -z "$TEMPLATE" ]]; then
    return
  fi
  sbt new $TEMPLATE
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# for Google Cloud Platform SDK completion
if [ -d $HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ]; then
  source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
  source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C $HOME/.anyenv/envs/tfenv/bin/terraform terraform
