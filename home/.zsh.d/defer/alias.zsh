# ls
if type eza > /dev/null 2>&1; then
  alias ls='eza -F --color=auto --icons'
  alias la='eza -aF --color=auto --icons'
  alias ll='eza -hlF --git --color=auto --icons'
  alias lla='eza -ahlF --git --color=auto --icons'
  alias lld='eza -dhlF --color=auto --icons'
  alias ll.='eza -dhlF --git --color=auto --icons .*'
  alias lt='eza -F -TL 2 --color=auto --icons'
  alias llt='eza -F -hlTL 2 --git --color=auto --icons'
else
  case ${OSTYPE} in
    freebsd*|darwin*)
      if [ -x $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin/ls ]; then
        # GNU
        alias ls='ls -F --color=auto'
      else
        alias ls='ls -GF'
      fi
      ;;
    linux*)
      alias ls='ls -F --color=auto'
      ;;
  esac
  alias la='ls -a'
  alias ll='ls -hl'
  alias lla='ll -a'
  alias lld='ll -d'
  alias ll.='ls -d .*'
fi

# Use `bat` instead of cat,less
if type bat > /dev/null 2>&1; then
  alias cat='bat --paging=never'
  alias less='bat'
fi

# Use `ripgrep` instead of normal grep
if type rg > /dev/null 2>&1; then
  alias grep='rg -S'
fi

# Use `trash` instead of rm
if type trash > /dev/null 2>&1; then
  alias rm='trash -F'
fi

# vim
alias vi='vim'

# tmux
alias tm='tmux'

# clipboard utility for WSL2
if [[ "$(uname -r)" == *microsoft* ]]; then
  alias pbcopy='clip.exe'
  alias pbpaste='powershell.exe -Command Get-Clipboard'
fi

# for github navigation
if [[ -x $HOMEBREW_PREFIX/bin/fzf && -x $HOMEBREW_PREFIX/bin/ghq && -x $HOMEBREW_PREFIX/bin/gh ]]; then
  alias repo='cd $(ghq list -p | fzf)'
  alias ghrepo='gh browse -R $(ghq list | grep "github.com" | fzf | cut -d "/" -f 2,3)'
fi

# grep the JSON
function jgrep() {
  if ! [[ -x $HOMEBREW_PREFIX/bin/gron ]]; then
    echo 'gron command is not installed'
    return 1
  fi
  gron | grep $* | gron -u
}

