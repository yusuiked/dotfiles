# The global setting of the laptop is the English locale, in order to use Japanese in the terminal
export LANG=en_US.UTF-8
# Initialize EDITOR
export EDITOR="vim"
#######################
# History settings    #
#######################
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=10000
export SAVEHIST=100000
setopt hist_ignore_dups
setopt extended_history

# Initialize PATH
if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi

# Initialize MANPATH
if [ -d /usr/local/share/man ]; then
  export MANPATH="/usr/local/share/man:$MANPATH"
fi
# Add /usr/local/sbin to PATH.
if [ -d /usr/local/sbin ]; then
  export PATH="/usr/local/sbin:$PATH"
fi
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
  #alias ls='ls --color'
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
if [ -d /usr/local/opt/python@3/libexec/bin ]; then
  export PATH="/usr/local/opt/python@3/libexec/bin:$PATH"
fi
# for diff-highlight with Git
if [ -e /usr/local/share/git-core/contrib/diff-highlight/diff-highlight ]; then
  export PATH="/usr/local/share/git-core/contrib/diff-highlight:$PATH"
fi

###################################
# Specified Environment Variables #
###################################

# Settings Java version
if type jenv > /dev/null 2>&1; then
  export JAVA_HOME=$(/usr/libexec/java_home -v "$(jenv global)")
fi

# Setting the character encoding of the Java and Groovy
# http://uehaj.hatenablog.com/entry/20090815/1250316330
# When changing the character encoding of the entire JVM language to UTF-8.
#export _JAVA_OPTIONS='-Dfile.encoding=UTF-8'
# Groovy only when changing the character enconding to UTF-8.
#export JAVA_OPTS='-Dgroovy.source.encoding=UTF-8'

# for golang
export GOPATH=$HOME
export PATH="$HOME/bin:$PATH"

##
# for postgresql 10
##

if [ -d /usr/local/opt/postgresql@10/bin ]; then
  export PATH="/usr/local/opt/postgresql@10/bin:$PATH"
fi
