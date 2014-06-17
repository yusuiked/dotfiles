# User specific aliases and functions
export PATH=/usr/local/bin:$PATH

# Setting the character encoding of the Java and Groovy
# http://uehaj.hatenablog.com/entry/20090815/1250316330
# Java と Groovy 全体（JVM全体）のエンコーディングを変更したい場合
export _JAVA_OPTIONS='-Dfile.encoding=UTF-8'
# Groovy のみエンコーディングを変更したい場合
#export JAVA_OPTS='-Dgroovy.source.encoding=UTF-8'

# git settings
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true

# Setting of the Terminal Color
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

# Prompt setting of the terminal
#PS1='\[\ek\e\\\][\u@\h \W]\$ '
PS1='\[\ek\e\\\][\[\e[32m\]\u@\h \[\e[34m\]\w\[\e[31m\]$(__git_ps1)\[\e[00m\]]\$ '

# color diff
alias diff='colordiff'
# less の syntax highlight
export LESS='-R'
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'

# Setting of aliases below
# ls
alias ls='ls -G'
alias la='ls -a'
alias ll='ls -hl'
alias lf='ls -F'
alias l.='ls -d .*'

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/yukung/.gvm/bin/gvm-init.sh" ]] && source "/Users/yukung/.gvm/bin/gvm-init.sh"
