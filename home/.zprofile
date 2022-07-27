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

# Switching with CPU architecture
if [ "$(uname -m)" = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"

  # Add /usr/local/sbin to PATH.
  if [ -d /usr/local/sbin ]; then
    export PATH="/usr/local/sbin:$PATH"
  fi
  # Initialize MANPATH
  if [ -d /usr/local/share/man ]; then
    export MANPATH="/usr/local/share/man:$MANPATH"
  fi
fi

# anyenv
if [ -x $HOMEBREW_PREFIX/bin/anyenv ]; then
  eval "$(anyenv init -)"
fi

# coreutils
if [ -d $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin ]; then
  export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
  export MANPATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"
fi

# findutils
if [ -d $HOMEBREW_PREFIX/opt/findutils/libexec/gnubin ]; then
  export PATH="$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin:$PATH"
  export MANPATH="$HOMEBREW_PREFIX/opt/findutils/libexec/gnuman:$MANPATH"
fi

# diffutils
if [ -d /usr/local/opt/diffutils/bin ]; then
  export PATH="/usr/local/opt/diffutils/bin:$PATH"
  export MANPATH="/usr/local/opt/diffutils/libexec/gnuman:$MANPATH"
fi
# sed
if [ -d /usr/local/opt/gnu-sed/bin ]; then
  export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
fi
# tar
if [ -d /usr/local/opt/gnu-tar/bin ]; then
  export PATH="/usr/local/opt/gnu-tar/bin:$PATH"
  export MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"
fi
# time
if [ -d /usr/local/opt/gnu-time/bin ]; then
  export PATH="/usr/local/opt/gnu-time/bin:$PATH"
fi
# grep
if [ -d /usr/local/opt/grep/bin ]; then
  export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/grep/libexec/gnuman:$MANPATH"
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
# fzf default options
if [ -x /usr/local/bin/fzf ]; then
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
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
export PATH="$GOPATH/bin:$PATH"

##
# for postgresql 11
##

if [ -d /usr/local/opt/postgresql@11/bin ]; then
  export PATH="/usr/local/opt/postgresql@11/bin:$PATH"
fi
