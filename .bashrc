# User specific aliases and functions

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

# Setting of aliases below
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
# tmux
alias tm='tmux'

# Prevent PATH duplication for tmux
# refs:
# - http://qiita.com/morygonzalez/items/a1404b1e42d44b528ab3
# - http://blog.aqutras.com/entry/2016/05/12/210000
if [ -z $TMUX ]; then

  # anyenv
  if [ -d $HOME/.anyenv ]; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
  fi

fi

# Setting the character encoding of the Java and Groovy
# http://uehaj.hatenablog.com/entry/20090815/1250316330
# When changing the character encoding of the entire JVM language to UTF-8.
export _JAVA_OPTIONS='-Dfile.encoding=UTF-8'
# Groovy only when changing the character enconding to UTF-8.
#export JAVA_OPTS='-Dgroovy.source.encoding=UTF-8'

# Settings Java version
export JAVA_HOME=$(/usr/libexec/java_home -v "$(jenv global)")