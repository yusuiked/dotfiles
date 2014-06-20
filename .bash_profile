# Get the aliases and functions
if [ -f ~/.bashrc ] ; then
    . ~/.bashrc
fi

# User specific environment and startup programs
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Specify your defaults in this environment variable
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"

# rbenv init
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/a12323/.gvm/bin/gvm-init.sh" ]] && source "/Users/a12323/.gvm/bin/gvm-init.sh"
