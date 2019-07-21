# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# User specific environment and startup programs

# Enable `bash-completion`
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/yukung/.sdkman"
[[ -s "/Users/yukung/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/yukung/.sdkman/bin/sdkman-init.sh"
