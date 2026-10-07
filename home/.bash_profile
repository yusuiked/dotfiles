# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# User specific environment and startup programs

# Enable `bash-completion`
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/yusuiked/.docker/bin"
# End of Docker Desktop section.

