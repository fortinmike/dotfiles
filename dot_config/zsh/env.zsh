# PATH

export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:$HOME/.local/bin" # Contains the binaries included in this repo

# Disable Analytics and Telemetry

export HOMEBREW_NO_ANALYTICS=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export POWERSHELL_TELEMETRY_OPTOUT=1
export AZURE_CLI_DISABLE_TELEMETRY=1
export CHECKPOINT_DISABLE=1 # HashiCorp tools (terraform/packer/vault/etc.)
export GOTELEMETRY=off # Go toolchain telemetry
export NPM_CONFIG_FUND=false # Disable npm "funding" message after installs
export YARN_ENABLE_TELEMETRY=0 # Yarn telemetry
export NEXT_TELEMETRY_DISABLED=1 # Next.js telemetry
export HF_HUB_DISABLE_TELEMETRY=1 # Hugging Face Hub telemetry
export WANDB_DISABLED=true # Weights & Biases telemetry (ML / AI libs)

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
setopt hist_ignore_space # Do not add commands that start with a space to the history
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

# Keep window/tab title in sync so it resets after SSH exits.
function _set_terminal_title() {
  # %n = user, %m = host (short)
  print -Pn "\e]0;%n@%m\a"
}
precmd_functions+=(_set_terminal_title)
