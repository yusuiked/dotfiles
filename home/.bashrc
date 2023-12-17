# User specific aliases and functions

# The global setting of the laptop is the English locale, in order to use Japanese in the terminal
export LANG=ja_JP.UTF-8

#######################
# Terminal appearance #
#######################
# Setting of the Terminal Color
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

# Prompt format of the terminal
#PS1='\[\ek\e\\\][\u@\h \W]\$ '
# for Git
PS1='\[\ek\e\\\][\[\e[32m\]\u@\h \[\e[34m\]\w\[\e[31m\]$(__git_ps1)\[\e[00m\]]\$ '

# Git settings
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM="auto"
#GIT_PS1_SHOWUPSTREAM="verbose name git"

# less colorize, syntax highlighting
export LESS='-R -x4'    # ANSI Color Escape Sequence, tab stop
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'

##################
# Alias settings #
##################
# ls
alias ls='ls -G'
alias la='ls -a'
alias ll='ls -hl'
alias lf='ls -F'
alias l.='ls -d .*'
# for hub
eval "$(hub alias -s)"
# for ghq,peco,hub
alias repo='cd $(ghq list -p | peco)'
alias ghrepo='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
# vim
alias vi='vim'
# tmux
alias tm='tmux'

#################
# PATH settings #
#################
# man
export MANPATH="/usr/local/share/man:$MANPATH"
# anyenv
if [ -d $HOME/.anyenv ]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
fi
# coreutils
if [ -d /usr/local/opt/coreutils/libexec/gnubin ]; then
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
  # alias for ls
  alias ls='ls --color'
fi
# findutils
if [ -d /usr/local/opt/findutils/bin ]; then
  export PATH="/usr/local/opt/findutils/bin:$PATH"
  export MANPATH="/usr/local/opt/findutils/share/man:$MANPATH"
fi
# diffutils
if [ -d /usr/local/opt/diffutils/bin ]; then
  export PATH="/usr/local/opt/diffutils/bin:$PATH"
  export MANPATH="/usr/local/opt/diffutils/share/man:$MANPATH"
fi
# sed
if [ -d /usr/local/opt/gnu-sed/bin ]; then
  export PATH="/usr/local/opt/gnu-sed/bin:$PATH"
  export MANPATH="/usr/local/opt/gnu-sed/share/man:$MANPATH"
fi
# tar
if [ -d /usr/local/opt/gnu-tar/bin ]; then
  export PATH="/usr/local/opt/gnu-tar/bin:$PATH"
  export MANPATH="/usr/local/opt/gnu-tar/share/man:$MANPATH"
fi
# grep
if [ -d /usr/local/opt/grep/bin ]; then
  export PATH="/usr/local/opt/grep/bin:$PATH"
  export MANPATH="/usr/local/opt/grep/share/man:$MANPATH"
fi
# gzip
if [ -d /usr/local/opt/gzip/bin ]; then
  export PATH="/usr/local/opt/gzip/bin:$PATH"
  export MANPATH="/usr/local/opt/gzip/share/man:$MANPATH"
fi
# awk
if [ -d /usr/local/opt/gawk/bin ]; then
  export PATH="/usr/local/opt/gawk/bin:$PATH"
  export MANPATH="/usr/local/opt/gawk/share/man:$MANPATH"
fi
# python
if [ -d /usr/local/opt/python/libexec/bin ]; then
  export PATH="/usr/local/opt/python/libexec/bin:$PATH"
fi

##################
# Other settings #
##################
# Setting the character encoding of the Java and Groovy
# http://uehaj.hatenablog.com/entry/20090815/1250316330
# When changing the character encoding of the entire JVM language to UTF-8.
export _JAVA_OPTIONS='-Dfile.encoding=UTF-8'
# Groovy only when changing the character enconding to UTF-8.
#export JAVA_OPTS='-Dgroovy.source.encoding=UTF-8'

# Settings Java version
export JAVA_HOME=$(/usr/libexec/java_home -v "$(jenv global)")

# for direnv
export EDITOR=vim
eval "$(direnv hook bash)"

# Work around which PATH duplication for tmux
# refs: http://qiita.com/key-amb/items/ce39b0c85b30888e1e3b
_path=""
for _p in $(echo $PATH | tr ':' ' '); do
  case ":${_path}:" in
    *:"${_p}":* )
      ;;
    * )
      if [ "$_path" ]; then
        _path="$_path:$_p"
      else
        _path=$_p
      fi
      ;;
  esac
done
PATH=$_path

unset _p
unset _path

_path=""
for _p in $(echo $MANPATH | tr ':' ' '); do
  case ":${_path}:" in
    *:"${_p}":* )
      ;;
    * )
      if [ "$_path" ]; then
        _path="$_path:$_p"
      else
        _path=$_p
      fi
      ;;
  esac
done
MANPATH=$_path

unset _p
unset _path

complete -C /usr/local/bin/terraform terraform

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
