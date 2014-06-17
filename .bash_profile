# Get the aliases and functions
if [ -f ~/.bashrc ] ; then
    . ~/.bashrc
fi

# User specific environment and startup programs
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
