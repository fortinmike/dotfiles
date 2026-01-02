# PATH

export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:$HOME/.local/bin" # Contains the binaries included in this repo

# Configuration

export EDITOR='micro'
export VISUAL='micro'
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export ANSIBLE_LOAD_CALLBACK_PLUGINS=1
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES # Fixes python fork() issue on recent macOS

# History (OMZ-style defaults)
export HISTSIZE=10000 # In-memory history size
export SAVEHIST=10000 # Number of history entries to save to disk

# Autosuggestions: only use completion results to avoid stale history paths
export ZSH_AUTOSUGGEST_STRATEGY=(completion)

# Ruby

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Colored man pages (replacement for OMZ colored-man-pages plugin)
export LESS='-R'
export LESSHISTFILE=- # Disable less history file
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

# History behavior (OMZ-style)
setopt append_history # Append to history file, don't overwrite
setopt hist_ignore_dups # Skip duplicate commands in history
setopt hist_ignore_space # Ignore commands that start with a space
setopt hist_verify # Edit expanded history before running
setopt inc_append_history # Write to history file immediately
setopt share_history # Share history across sessions
setopt extended_history # Save timestamps in history
setopt hist_expire_dups_first # Expire duplicate entries first

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
