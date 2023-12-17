# sheldon
if type sheldon > /dev/null 2>&1; then
  eval "$(sheldon source)"
fi

#######################
# Completion settings #
#######################
# for zsh-completion
if type brew >/dev/null 2>&1; then
  fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
fi

# for Google Cloud Platform SDK completion
if [ -d $HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ]; then
  source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
  source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
fi

#######################
# Application setup   #
#######################
# homeshick
if [[ -x $HOMEBREW_PREFIX/bin/homeshick ]]; then
  export HOMESHICK_DIR=$HOMEBREW_PREFIX/opt/homeshick
  source $HOMEBREW_PREFIX/opt/homeshick/homeshick.sh
fi

# asdf
if type asdf >/dev/null 2>&1; then
  . $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh
fi

# direnv
if type direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

#######################
# misc config         #
#######################
# Set word break on CLI
autoload -Uz select-word-style
select-word-style default
#zstyle ':zle:*' word-chars " _-./;@"
zstyle ':zle:*' word-chars " ;@\"\'"
zstyle ':zle:*' word-style unspecified
WORDCHARS="$WORDCHARS\'\""

#######################
# utility function    #
#######################
# grep the JSON
function jgrep() { gron | grep $* | gron -u }

