# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# User specific environment and startup programs

# Enable `bash-completion`
[ -f $(brew --prefix)/etc/bash_completion ] && . $(brew --prefix)/etc/bash_completion