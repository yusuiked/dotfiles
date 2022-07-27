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
if [ -d $HOMEBREW_PREFIX/opt/diffutils/bin ]; then
  export PATH="$HOMEBREW_PREFIX/opt/diffutils/bin:$PATH"
  export MANPATH="$HOMEBREW_PREFIX/opt/diffutils/share/man:$MANPATH"
fi

# sed
if [ -d $HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin ]; then
  export PATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
  export MANPATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnuman:$MANPATH"
fi

# tar
if [ -d $HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin ]; then
  export PATH="$HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin:$PATH"
  export MANPATH="$HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnuman:$MANPATH"
fi

# time
if [ -d $HOMEBREW_PREFIX/opt/gnu-time/bin ]; then
  export PATH="$HOMEBREW_PREFIX/opt/gnu-time/bin:$PATH"
fi

# grep
if [ -d $HOMEBREW_PREFIX/opt/grep/libexec/gnubin ]; then
  export PATH="$HOMEBREW_PREFIX/opt/grep/libexec/gnubin:$PATH"
  export MANPATH="$HOMEBREW_PREFIX/opt/grep/libexec/gnuman:$MANPATH"
fi

# gzip
if [ -d $HOMEBREW_PREFIX/opt/gzip/bin ]; then
  export PATH="$HOMEBREW_PREFIX/opt/gzip/bin:$PATH"
  export MANPATH="$HOMEBREW_PREFIX/opt/gzip/share/man:$MANPATH"
fi

# awk
if [ -d $HOMEBREW_PREFIX/opt/gawk/libexec/gnubin ]; then
  export PATH="$HOMEBREW_PREFIX/opt/gawk/libexec/gnubin:$PATH"
  export MANPATH="$HOMEBREW_PREFIX/opt/gawk/libexec/man:$MANPATH"
fi

# python
if [ -d $HOMEBREW_PREFIX/opt/python/libexec/bin ]; then
  export PATH="$HOMEBREW_PREFIX/opt/python/libexec/bin:$PATH"
fi

# for diff-highlight with Git
if [ -x $HOMEBREW_PREFIX/share/git-core/contrib/diff-highlight/diff-highlight ]; then
  export PATH="$HOMEBREW_PREFIX/share/git-core/contrib/diff-highlight:$PATH"
fi

# fzf default options
if [ -x $HOMEBREW_PREFIX/bin/fzf ]; then
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

