# direnv
if type direnv > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# sdkman
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# asdf
if type asdf > /dev/null 2>&1; then
  source $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh
fi

