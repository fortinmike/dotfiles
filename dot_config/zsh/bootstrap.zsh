ZSH_CONFIG_DIR="${0:A:h}"

source "$ZSH_CONFIG_DIR/env.zsh"
source "$ZSH_CONFIG_DIR/plugins.zsh"
source "$ZSH_CONFIG_DIR/commands.zsh"
source "$ZSH_CONFIG_DIR/key-bindings.zsh"

# Load starship and zoxide using their explicit homebrew paths because
# homebrew might not yet have added its bin directories to PATH at this point.

local STARSHIP_BIN
STARSHIP_BIN="$("$BREW" --prefix starship)/bin/starship"
eval "$("$STARSHIP_BIN" init zsh)"

local ZOXIDE_BIN
ZOXIDE_BIN="$("$BREW" --prefix zoxide)/bin/zoxide"
eval "$("$ZOXIDE_BIN" init zsh)"

if [ -e ~/.zshrc_local ]; then source ~/.zshrc_local; fi
