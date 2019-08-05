# Lines configured by zsh-newuser-install
#######################
# History settings    #
#######################
HISTFILE=${HOME}/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

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
    if [ -f /usr/local/opt/coreutils/libexec/gnubin/ls ]; then
      alias ls='ls -F --color=auto'
    else
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
# vim
alias vi='vim'
# colordiff
if [ -f /usr/local/opt/colordiff/bin/colordiff ]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi
# tmux
alias tm='tmux'
# hub
eval "$(hub alias -s)"
# ghq, peco, hub (It is likely to be replaced by anyframe)
alias repo='cd $(ghq list -p | peco)'
alias ghrepo='hub browse $(ghq list | grep "github.com" | peco | cut -d "/" -f 2,3)'

#######################
# Terminal appearance #
#######################
export CLICOLOR=true
## for BSD ls
export LSCOLORS=gxfxcxdxbxegedabagacad
## for GNU ls (require coreutils and seebi/dircolors-solarized)
if [ -f /usr/local/opt/coreutils/libexec/gnubin/dircolors ] && [ -f ~/.dircolors ]; then
  eval $(dircolors ~/.dircolors)
fi

# less colorize, syntax highglighting
export LESS='-R -x4'    # ANSI Color Escape Sequence, tab stop
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'

# zsh-syntax-highlighting (See: https://github.com/zsh-users/zsh-syntax-highlighting)
if [ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

#######################
# Completion settings #
#######################
# for zsh-completion
if [ -d /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

# for User-Specific completion
if [ -d ~/.zsh/completions ]; then
  fpath=(~/.zsh/completions $fpath)
fi

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/yukung/.zshrc'

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
# direnv
eval "$(direnv hook zsh)"

# Set word break on CLI

autoload -Uz select-word-style
select-word-style default
#zstyle ':zle:*' word-chars " _-./;@"
zstyle ':zle:*' word-chars " ;@"
zstyle ':zle:*' word-style unspecified
# Elimination of duplicate PATH
typeset -U path fpath manpath

# powerline
if $(whence powerline-daemon) > /dev/null; then
  powerline-daemon -q --replace
  . /usr/local/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh
fi

#######################
# custom function     #
#######################
# Ref: https://blog.shibayu36.org/entry/2019/01/09/193000
function epoch2date() {
    date --date="@$1" +%Y-%m-%dT%H:%M:%S%z
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
