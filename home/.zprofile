# Initialize EDITOR
export EDITOR="vim"

# Initialize PATH
if [ -x /usr/libexec/path_helper ]; then
  eval $(/usr/libexec/path_helper -s)
fi

# Homebrew
case $(uname -m) in
  "x86_64" ) 
    if [[ $OSTYPE == linux* ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  else
      eval "$(/usr/local/bin/brew shellenv)"
    fi
    ;;
  "arm64" )
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ;;
esac
fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
manpath=($HOMEBREW_PREFIX/share/man $manpath)

# homeshick
if [[ -d $HOMEBREW_PREFIX/opt/homeshick ]]; then
  export HOMESHICK_DIR=$HOMEBREW_PREFIX/opt/homeshick
  source $HOMESHICK_DIR/homeshick.sh
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
if [ -x $HOMEBREW_PREFIX/bin/fd ]; then
    export FZF_DEFAULT_COMMAND="fd -t f -L -H -E .git --color=always"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --ansi"
  fi
fi

# sdkman
export SDKMAN_DIR="$HOME/.sdkman"

# maven
if [[ -x $HOME/.sdkman/candidates/maven/current/bin/mvn ]]; then
  export M2_HOME=$HOME/.sdkman/candidates/maven/current/bin/mvn
fi

## Setting the character encoding of the Java and Groovy
## http://uehaj.hatenablog.com/entry/20090815/1250316330
## Groovy only when changing the character enconding to UTF-8.
#export JAVA_OPTS='-Dgroovy.source.encoding=UTF-8 -Dfile.encoding=UTF-8'
## When changing the character encoding of the entire JVM language to UTF-8.
#export _JAVA_OPTIONS='-Dfile.encoding=UTF-8'

# golang
export GOPATH=$HOME
export PATH="$GOPATH/bin:$PATH"

# gcloud
if [[ -f $HOMEBREW_PREFIX/share/google-cloud-sdk/path.zsh.inc ]]; then
  source $HOMEBREW_PREFIX/share/google-cloud-sdk/path.zsh.inc
fi
