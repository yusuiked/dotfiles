# sheldon
if type sheldon > /dev/null 2>&1; then
  eval "$(sheldon source)"
fi

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

