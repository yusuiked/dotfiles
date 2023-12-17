# sheldon
if type sheldon > /dev/null 2>&1; then
  eval "$(sheldon source)"
fi

if [[ -r $HOME/.zshrc.local ]]; then
  source $HOME/.zshrc.local
fi

