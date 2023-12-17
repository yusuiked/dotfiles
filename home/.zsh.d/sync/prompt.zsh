# starship
if type starship > /dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# colorize default ls command
# for OSX/BSD ls
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
# for GNU ls
export LS_COLORS="di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43:"
# if use dircolors, set here below
if [ -f ~/.dircolors ]; then
  if type dircolors > /dev/null 2>&1; then
    eval $(dircolors ~/.dircolors)
  fi
fi
[ -n "${LS_COLORS}" ] && zstyle ':completion:*' list-colors "${LS_COLORS}"

