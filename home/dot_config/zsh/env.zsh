# PATH

export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:$HOME/.local/bin"

# Configuration

export EDITOR='vim'
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export ANSIBLE_LOAD_CALLBACK_PLUGINS=1
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES # Fixes python fork() issue on recent macOS

# Ruby

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Colored man pages (replacement for OMZ colored-man-pages plugin)
export LESS='-R'
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

# macOS/Homebrew completions
if [ -d /opt/homebrew/share/zsh/site-functions ]; then
  fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
fi
if [ -d /usr/local/share/zsh/site-functions ]; then
  fpath=(/usr/local/share/zsh/site-functions $fpath)
fi
if [ -d /usr/share/zsh/site-functions ]; then
  fpath=(/usr/share/zsh/site-functions $fpath)
fi
